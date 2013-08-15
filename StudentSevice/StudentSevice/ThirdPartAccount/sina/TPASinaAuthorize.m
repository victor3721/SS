//
//  TPASinaAuthorize.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPASinaAuthorize.h"
#import "TPASinaURLGenerator.h"
#import "TPASinaDefines.h"

@interface TPASinaAuthorize () {
	BOOL			_haveAuthorizeInfo;
}

@end

@implementation TPASinaAuthorize
@synthesize appKey = _appKey;
@synthesize appSecret = _appSecret;
@synthesize redirectURI = _redirectURI;
@synthesize delegate = _delegate;

- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI {
	self = [super init];
	if(self) {
		self.appKey = appKey;
		self.appSecret = appSecret;
		self.redirectURI = redirectURI;
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

	[_webView release]; _webView = nil;
	[_request release]; _request = nil;
    
//    rootViewController = nil;
	_delegate = nil;

	[super dealloc];
}

- (void)startAuthorize {
	NSString *urlString = [TPASinaURLGenerator authorizeWithKey:_appKey secret:_appSecret redirectURI:_redirectURI];
	NSLog(@"startAuthorize: %@", urlString);
    
	if(_webView) {
		[_webView setDelegate:nil];
		[_webView hide:NO];
		[_webView release];
		_webView = nil;
	}
	
	_webView = [[TPASinaAuthorizeWebView alloc] init];
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
	
	NSDictionary *params = [TPASinaURLGenerator accessTokenParamsWithKey:_appKey secret:_appSecret redirectURI:_redirectURI code:code];

	_request = [[TPASinaRequest alloc] initWithURL:kSinaAccessTokenURL
										  delegate:self
										httpMethod:@"POST"
											params:params
									  postDataType:kTPARequestPostDataTypeNormal];
	
	[_request connect];
}

- (void)refreshAuthorize {
}

- (void)refreshAuthorize:(NSString *)accessToken {
	if(_request) {
		_request.delegate = nil;
		[_request disconnect];
		[_request release];
		_request = nil;
	}
	
	NSDictionary *params = [TPASinaURLGenerator accessTokenParamsWithKey:_appKey
																  secret:_appSecret
															 redirectURI:_redirectURI
																	code:nil
																  others:[NSDictionary dictionaryWithObjectsAndKeys:
																		  @"refresh_token", @"grant_type",
																		  accessToken, @"access_token",
																		  nil]];
	
	_request = [[TPASinaRequest alloc] initWithURL:kSinaAccessTokenURL
										  delegate:self
										httpMethod:@"POST"
											params:params
									  postDataType:kTPARequestPostDataTypeNormal];
	
	[_request connect];
}

- (void)authorizeWebView:(TPAAuthorizeWebView *)webView didReceiveAuthorizeInfo:(NSDictionary *)info {
	NSString *code = [info objectForKey:@"code"];
	// if not canceled
	if (![code isEqualToString:@"21330"]) {
		_haveAuthorizeInfo = YES;
		[self requestAccessTokenWithAuthorizeCode:code];
	}

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
		NSString *userID = [dict objectForKey:@"uid"];
		NSInteger seconds = [[dict objectForKey:@"expires_in"] intValue];
		
		success = token && userID;
		
		if (success && [self.delegate respondsToSelector:@selector(authorize:didSucceedWithAccessToken:userID:expiresIn:otherInfos:)]) {
			[self.delegate authorize:self didSucceedWithAccessToken:token userID:userID expiresIn:seconds otherInfos:nil];
		}
	}
	
	// should not be possible
	if (!success && [self.delegate respondsToSelector:@selector(authorize:didFailWithError:)]) {
		NSError *error = [NSError errorWithDomain:kSinaErrorDomain
											 code:kSinaErrorCode
										 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", kSinaErrorCodeAuthorizeError]
																			  forKey:kSinaErrorCodeKey]];
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
