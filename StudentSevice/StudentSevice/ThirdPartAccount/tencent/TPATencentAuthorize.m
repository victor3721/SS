//
//  TPATencentAuthorize.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPATencentAuthorize.h"
#import "TPATencentURLGenerator.h"
#import "TPATencentDefines.h"

@interface TPATencentAuthorize () {
	BOOL			_haveAuthorizeInfo;
}

@end

@implementation TPATencentAuthorize
@synthesize appKey = _appKey;
@synthesize appSecret = _appSecret;
@synthesize redirectURI = _redirectURI;
@synthesize openID = _openID;
@synthesize openKey = _openKey;
@synthesize delegate = _delegate;

- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI {
	self = [super init];
	if(self) {
		self.appKey = appKey;
		self.appSecret = appSecret;
		self.redirectURI = redirectURI;
		self.openID = nil;
		self.openKey = nil;
		
		_haveAuthorizeInfo = NO;
	}
	
	return self;
}

- (void)dealloc {
	_request.delegate = nil;
	[_request disconnect];

	[_appKey release]; _appKey = nil;
	[_appSecret release]; _appSecret = nil;

	[_redirectURI release]; _redirectURI = nil;
	
	[_openID release]; _openID = nil;
	[_openKey release]; _openKey = nil;

	[_webView release]; _webView = nil;
	[_request release]; _request = nil;
    
//    rootViewController = nil;
	_delegate = nil;

	[super dealloc];
}

- (void)startAuthorize {
	NSString *urlString = [TPATencentURLGenerator authorizeWithKey:_appKey secret:_appSecret redirectURI:_redirectURI];
	NSLog(@"startAuthorize: %@", urlString);
    
	if(_webView) {
		[_webView setDelegate:nil];
		[_webView hide:NO];
		[_webView release];
		_webView = nil;
	}
	
	_webView = [[TPATencentAuthorizeWebView alloc] init];
	[_webView setDelegate:self];
	[_webView loadRequestWithURL:[NSURL URLWithString:urlString]];
	[_webView show:YES];
}

- (void)requestAccessTokenWithAuthorizeCode:(NSString *)code {
	if(_request) {
		_request.delegate = nil;
		[_request disconnect];
		[_request release];
		_request = nil;
	}
	
	NSDictionary *params = [TPATencentURLGenerator accessTokenParamsWithKey:_appKey secret:_appSecret redirectURI:_redirectURI code:code];

	_request = [[TPATencentRequest alloc] initWithURL:kTencentAccessTokenURL
										  delegate:self
										httpMethod:@"GET"
											params:params
									  postDataType:kTPARequestPostDataTypeNormal];
	
	[_request connect];
}

- (void)refreshAuthorize {
}

- (void)refreshAuthorize:(NSString *)refreshToken {
	if(_request) {
		_request.delegate = nil;
		[_request disconnect];
		[_request release];
		_request = nil;
	}
	
	NSDictionary *params = [TPATencentURLGenerator accessTokenParamsWithKey:_appKey
																  secret:_appSecret
															 redirectURI:_redirectURI
																	code:nil
																  others:[NSDictionary dictionaryWithObjectsAndKeys:
																		  @"refresh_token", @"grant_type",
																		  refreshToken, @"refresh_token",
																		  nil]];
	
	_request = [[TPATencentRequest alloc] initWithURL:kTencentAccessTokenURL
										  delegate:self
										httpMethod:@"GET"
											params:params
									  postDataType:kTPARequestPostDataTypeNormal];
	
	[_request connect];
}

- (void)authorizeWebView:(TPAAuthorizeWebView *)webView didReceiveAuthorizeInfo:(NSDictionary *)info {
	NSString *code = [info objectForKey:@"code"];
	self.openID = [info objectForKey:@"openid"];
	self.openKey = [info objectForKey:@"openkey"];

	_haveAuthorizeInfo = YES;
	[self requestAccessTokenWithAuthorizeCode:code];

	[webView hide:YES];
}

- (void)authorizeWebViewClosed:(TPAAuthorizeWebView *)webView {
	if(!_haveAuthorizeInfo) {
		if([_delegate respondsToSelector:@selector(authorizeCancelled:)]) {
			[_delegate authorizeCancelled:self];
		}
	}
}

- (void)request:(TPARequest *)request didFinishLoadingWithResult:(id)result {
	[_request disconnect];
	
	BOOL success = NO;
	if ([result isKindOfClass:[NSDictionary class]]) {
		NSDictionary *dict = (NSDictionary *)result;
		NSLog(@"dict: %@", dict);
		
		NSString *token = [dict objectForKey:@"access_token"];
		NSString *refresh_token = [dict objectForKey:@"refresh_token"];
		NSInteger seconds = [[dict objectForKey:@"expires_in"] intValue];
		
		success = token && (seconds > 0);
		
		if (success && [self.delegate respondsToSelector:@selector(authorize:didSucceedWithAccessToken:userID:expiresIn:otherInfos:)]) {
			[self.delegate authorize:self
		   didSucceedWithAccessToken:token
							  userID:nil
						   expiresIn:seconds
						  otherInfos:[NSDictionary dictionaryWithObject:refresh_token forKey:@"refresh_token"]];
		}
	}
	
	// should not be possible
	if (!success && [self.delegate respondsToSelector:@selector(authorize:didFailWithError:)]) {
		NSError *error = [NSError errorWithDomain:kTencentErrorDomain
											 code:kTencentErrorCode
										 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", kTencentErrorCodeAuthorizeError]
																			  forKey:kTencentErrorCodeKey]];
		[self.delegate authorize:self didFailWithError:error];
	}
}

- (void)request:(TPARequest *)request didFailWithError:(NSError *)error {
	[_request disconnect];
	
	if ([self.delegate respondsToSelector:@selector(authorize:didFailWithError:)]) {
		[self.delegate authorize:self didFailWithError:error];
	}
}

@end
