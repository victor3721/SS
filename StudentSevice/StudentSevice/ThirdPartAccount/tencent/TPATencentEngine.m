//
//  TPATencentEngine.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPATencentEngine.h"
#import "TPATencentURLGenerator.h"
#import "TPATencentDefines.h"
#import "SFHFKeychainUtils.h"

#define kTencentKeychainAccessToken			@"TencentAccessToken"
#define kTencentKeychainExpireTime			@"TencentExpireTime"
#define kTencentKeychainRefreshToken		@"TencentRefreshToken"
#define kTencentKeychainOpenID				@"TencentOpenID"
#define kTencentKeychainOpenKey				@"TencentOpenKey"

@implementation TPATencentEngine

@synthesize appKey = _appKey;
@synthesize appSecret = _appSecret;
@synthesize refreshToken = _refreshToken;
@synthesize accessToken = _accessToken;
@synthesize expireTime = _expireTime;
@synthesize openID = _openID;
@synthesize openKey = _openKey;
@synthesize redirectURI = _redirectURI;
@synthesize delegate = _delegate;
@synthesize requestMethod = _requestMethod;
@synthesize request = _request;
@synthesize authorize = _authorize;

- (id)init {
	self = [super init];
	if(self) {
		self.appKey = nil;
		self.appSecret = nil;
		self.refreshToken = nil;
		self.accessToken = nil;
		self.expireTime = 0;
		self.openID = nil;
		self.openKey = nil;
		self.redirectURI = nil;
		self.requestMethod = nil;
		self.request = nil;
		self.authorize = nil;
	}
	
	return self;
}

- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret {
	return [self initWithAppKey:appKey appSecret:appSecret ssoCallback:nil];
}

- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret ssoCallback:(NSString *)ssoCallback {
	self = [self init];
	if(self) {
		self.appKey = appKey;
		self.appSecret = appSecret;
		self.redirectURI = @"http://";
		
		[self readAuthorizeDataFromKeychain];
	}
	
	return self;
}

- (void)dealloc {
    [_request setDelegate:nil];
    [_request disconnect];

    [_appKey release]; _appKey = nil;

    [_appSecret release]; _appSecret = nil;
    
    [_refreshToken release]; _refreshToken = nil;
    [_accessToken release]; _accessToken = nil;
    
	[_openID release]; _openID = nil;
	[_openKey release]; _openKey = nil;

    [_redirectURI release]; _redirectURI = nil;
    
	[_requestMethod release]; _requestMethod = nil;
    [_request release]; _request = nil;
    
    [_authorize setDelegate:nil];
    [_authorize release]; _authorize = nil;

	_delegate = nil;
//    rootViewController = nil;
    
    [super dealloc];
}

- (TPATencentAuthorize *)authorize {
	if(!_authorize) {
		_authorize = [[TPATencentAuthorize alloc] initWithAppKey:_appKey appSecret:_appSecret redirectURI:_redirectURI];
		_authorize.openID = self.openID;
		_authorize.openKey = self.openKey;
		_authorize.delegate = self;
	}
	
	return _authorize;
}

- (void)login {
	if ([self isAlreadyLogin]) {
		if ([_delegate respondsToSelector:@selector(engineAlreadyLogin:)]) {
			[_delegate engineAlreadyLogin:self];
		}
		return;
    }

	[self.authorize startAuthorize];
}

- (void)logout {
    [self deleteAuthorizeDataInKeychain];
    
    if ([_delegate respondsToSelector:@selector(engineDidLogout:)]) {
        [_delegate engineDidLogout:self];
    }
}

- (void)refreshAuthorize {
	[self.authorize refreshAuthorize:_refreshToken];
}

- (BOOL)isAlreadyLogin {
    return _accessToken && (_expireTime > 0);
}

- (BOOL)isAuthorizeExpired {
    if ([[NSDate date] timeIntervalSince1970] > _expireTime) {
        // force to log out
        [self deleteAuthorizeDataInKeychain];

        return YES;
    }
    return NO;
}

- (void)loadRequestWithMethodName:(NSString *)methodName
                       httpMethod:(NSString *)httpMethod
                           params:(NSDictionary *)params
                     postDataType:(TPARequestPostDataType)postDataType
                 httpHeaderFields:(NSDictionary *)httpHeaderFields {
	if (![self isAlreadyLogin]) {
        if ([_delegate respondsToSelector:@selector(engineNotAuthorized:)]) {
            [_delegate engineNotAuthorized:self];
        }
        return;
	}
    
	// Step 2.
    // Check if the access token is expired.
    if ([self isAuthorizeExpired]) {
        if ([_delegate respondsToSelector:@selector(engineAuthorizeExpired:)]) {
            [_delegate engineAuthorizeExpired:self];
        }
        return;
    }
    
	if(_request) {
		_request.delegate = nil;
		[_request disconnect];
		[_request release];
		_request = nil;
	}
	
	self.requestMethod = methodName;
	if([httpMethod isEqualToString:@"GET"]) {
		NSString *urlString = [TPATencentURLGenerator serializeURL:[NSString stringWithFormat:@"%@%@", kTencentAPIDomain, methodName]
															params:params
															appKey:_appKey
													   accessToken:_accessToken
															openID:_openID
														httpMethod:httpMethod];
		_request = [[TPATencentRequest alloc] initWithURL:urlString
												 delegate:self
											   httpMethod:httpMethod
												   params:nil
											 postDataType:kTPARequestPostDataTypeNone
										 httpHeaderFields:httpHeaderFields];
	} else {
		NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
		[mutableParams setObject:_appKey forKey:@"oauth_consumer_key"];
		[mutableParams setObject:_accessToken forKey:@"access_token"];
		[mutableParams setObject:_openID forKey:@"openid"];
		[mutableParams setObject:@"2.a" forKey:@"oauth_version"];
		[mutableParams setObject:@"all" forKey:@"scope"];
		[mutableParams setObject:@"json" forKey:@"format"];

		_request = [[TPATencentRequest alloc] initWithURL:[NSString stringWithFormat:@"%@%@", kTencentAPIDomain, methodName]
												 delegate:self
											   httpMethod:@"POST"
												   params:mutableParams
											 postDataType:postDataType
										 httpHeaderFields:httpHeaderFields];
	}
	
	[_request connect];
}

- (void)request:(TPARequest *)request didFinishLoadingWithResult:(id)result {
	[_request disconnect];
	
	NSLog(@"result: %@", result);
	if ([_delegate respondsToSelector:@selector(engine:requestDidSucceedWithResult:)]) {
		[_delegate engine:self requestDidSucceedWithResult:result];
	}
}

- (void)request:(TPARequest *)request didFailWithError:(NSError *)error {
	[_request disconnect];
	
	if ([_delegate respondsToSelector:@selector(engine:requestDidFailWithError:)]) {
		[_delegate engine:self requestDidFailWithError:error];
	}
}

- (void)saveAuthorizeDataToKeychain {
	NSString *serviceName = [NSString stringWithFormat:@"%@_KeyChain", NSStringFromClass([self class])];
	[SFHFKeychainUtils storeUsername:kTencentKeychainRefreshToken andPassword:_refreshToken forServiceName:serviceName updateExisting:YES error:nil];
	[SFHFKeychainUtils storeUsername:kTencentKeychainAccessToken andPassword:_accessToken forServiceName:serviceName updateExisting:YES error:nil];
	[SFHFKeychainUtils storeUsername:kTencentKeychainExpireTime andPassword:[NSString stringWithFormat:@"%lf", _expireTime] forServiceName:serviceName updateExisting:YES error:nil];
	[SFHFKeychainUtils storeUsername:kTencentKeychainOpenID andPassword:_openID forServiceName:serviceName updateExisting:YES error:nil];
	[SFHFKeychainUtils storeUsername:kTencentKeychainOpenKey andPassword:_openKey forServiceName:serviceName updateExisting:YES error:nil];
}

- (void)readAuthorizeDataFromKeychain {
	NSString *serviceName = [NSString stringWithFormat:@"%@_KeyChain", NSStringFromClass([self class])];
	self.refreshToken = [SFHFKeychainUtils getPasswordForUsername:kTencentKeychainRefreshToken andServiceName:serviceName error:nil];
	self.accessToken = [SFHFKeychainUtils getPasswordForUsername:kTencentKeychainAccessToken andServiceName:serviceName error:nil];
	self.expireTime = [[SFHFKeychainUtils getPasswordForUsername:kTencentKeychainExpireTime andServiceName:serviceName error:nil] doubleValue];
	self.openID = [SFHFKeychainUtils getPasswordForUsername:kTencentKeychainOpenID andServiceName:serviceName error:nil];
	self.openKey = [SFHFKeychainUtils getPasswordForUsername:kTencentKeychainOpenKey andServiceName:serviceName error:nil];
}

- (void)deleteAuthorizeDataInKeychain {
	self.refreshToken = nil;
	self.accessToken = nil;
	self.openID = nil;
	self.openKey = nil;
	self.expireTime = 0;

	NSString *serviceName = [NSString stringWithFormat:@"%@_KeyChain", NSStringFromClass([self class])];
	[SFHFKeychainUtils deleteItemForUsername:kTencentKeychainRefreshToken andServiceName:serviceName error:nil];
	[SFHFKeychainUtils deleteItemForUsername:kTencentKeychainAccessToken andServiceName:serviceName error:nil];
	[SFHFKeychainUtils deleteItemForUsername:kTencentKeychainExpireTime andServiceName:serviceName error:nil];
	[SFHFKeychainUtils deleteItemForUsername:kTencentKeychainOpenID andServiceName:serviceName error:nil];
	[SFHFKeychainUtils deleteItemForUsername:kTencentKeychainOpenKey andServiceName:serviceName error:nil];
}

- (void)authorize:(id<TPAAuthorize>)authorize didSucceedWithAccessToken:(NSString *)accessToken userID:(NSString *)userID expiresIn:(NSInteger)seconds otherInfos:(NSDictionary *)otherInfos {
	self.accessToken = accessToken;
	self.refreshToken = [otherInfos objectForKey:@"refresh_token"];
	self.expireTime = [[NSDate date] timeIntervalSince1970] + seconds;
	self.openID = _authorize.openID;
	self.openKey = _authorize.openKey;
	
	[self saveAuthorizeDataToKeychain];
	
	if ([self.delegate respondsToSelector:@selector(engineDidLogin:)]) {
		[self.delegate engineDidLogin:self];
	}
}

- (void)authorizeCancelled:(id<TPAAuthorize>)authorize {
	if ([self.delegate respondsToSelector:@selector(engineDidLoginCancelled:)]) {
		[self.delegate engineDidLoginCancelled:self];
	}
}

- (void)authorize:(id<TPAAuthorize>)authorize didFailWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(engine:didFailToLoginWithError:)]) {
        [self.delegate engine:self didFailToLoginWithError:error];
    }
}

- (BOOL)handleOpenURL:(NSURL *)url {
	return YES;
}

- (void)applicationDidBecomeActive {
}

@end
