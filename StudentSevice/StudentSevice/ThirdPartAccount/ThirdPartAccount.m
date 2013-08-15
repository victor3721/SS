//
//  ThirdPartAccount.m
//  ThirdPartAccount
//
//  Created by Yin Martin on 12-7-16.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "ThirdPartAccount.h"

//#define SINA_APPKEY		@"3005385612"
//#define SINA_APPSECRET	@"bf9d88e809de8db0c0ae023d1e1254ad"
//#define SINA_REDIRECT	@"http://sina/login.html"

//#define SINA_APPKEY		@"1371389937"
//#define SINA_APPSECRET	@"c6fb4990cb45f300eb6122dc8582af6e"
//#define SINA_REDIRECT	@"http://sina/login.html"

#define SINA_APPKEY		@"4039624193"
#define SINA_APPSECRET	@"efe9ad60e845ec07db05af37023c8eae"
#define SINA_REDIRECT	@"http://www.baidu.com"

#define QQ_APPKEY		@"801189857"
#define QQ_APPSECRET	@"5f511fee374e2b57925bcdbd202e940d"

#define kTPAEngineKeySina			@"TPAEngineKeySina"
#define kTPAEngineKeyTencent		@"TPAEngineKeyTencent"

#define kSina_UserInfo				@"users/show.json"

#define kTencent_UserInfo			@"user/info"

@interface ThirdPartAccount () {
	TPASinaEngine				*_sinaEngine;
	TPATencentEngine			*_tencentEngine;
}

@end

static ThirdPartAccount *_standardTPA;
@implementation ThirdPartAccount
@synthesize delegate = _delegate;
@synthesize ssoCallback = _ssoCallback;
@synthesize engineType = _engineType;



#pragma mark -
#pragma mark life style
+ (id)standardTPA {
	if(!_standardTPA) {
		_standardTPA = [[ThirdPartAccount alloc] init];
	}
	
	return _standardTPA;
}

- (id)init {
	self = [super init];
	if(self) {
		_ssoCallback = nil;
		_engineType = TPAEngineTypeNone;
		_sinaEngine = nil;
		_tencentEngine = nil;
	}
	
	return self;
}

- (void)dealloc {
	[_ssoCallback release];
	_ssoCallback = nil;
	
	[_sinaEngine setDelegate:nil];
	[_sinaEngine release];
	_sinaEngine = nil;
	
	[_tencentEngine setDelegate:nil];
	[_tencentEngine release];
	_tencentEngine = nil;

	[super dealloc];
}


#pragma mark -
#pragma mark public method

//
//登陆退出调用的方法
- (void)login {
	if(_engineType == TPAEngineTypeNone) {
		[self reportNotSetEngineType];
		return;
	}
    
    //跳转到currentEngine类当中获取输入的获取那个信息的类型
	[[self currentEngine] setDelegate:self];
	[[self currentEngine] login];
}
- (void)logout {
	if(_engineType == TPAEngineTypeNone) {
		[self reportNotSetEngineType];
		return;
	}
    //跳转到currentEngine类当中获取输入的获取那个信息的类型
	[[self currentEngine] setDelegate:self];
	[[self currentEngine] logout];
}

//
//返回要获取那种信息的类型
- (id<TPAEngine>)currentEngine {
	switch (_engineType) {
		case TPAEngineTypeNone:
			return nil;
			break;
		case TPAEngineTypeSina:
			return self.sinaEngine;
			break;
		case TPAEngineTypeTencent:
			return self.tencentEngine;
			break;
		default:
			break;
	}
    
	return nil;
}

//
//获取用户的信息
- (void)getUserInfo {
	switch (_engineType) {
		case TPAEngineTypeNone:
			[self reportNotSetEngineType];
			break;
		case TPAEngineTypeSina:
		{
			[_sinaEngine setDelegate:self];
			[_sinaEngine loadRequestWithMethodName:kSina_UserInfo
										httpMethod:@"GET"
											params:[NSDictionary dictionaryWithObject:_sinaEngine.userID forKey:@"uid"]
									  postDataType:kTPARequestPostDataTypeNone
								  httpHeaderFields:nil];
		}
			break;
		case TPAEngineTypeTencent:
		{
			[_tencentEngine setDelegate:self];
			[_tencentEngine loadRequestWithMethodName:kTencent_UserInfo
										   httpMethod:@"GET"
											   params:nil
										 postDataType:kTPARequestPostDataTypeNone
									 httpHeaderFields:nil];
		}
			break;
		default:
			break;
	}
}



- (void)applicationDidBecomeActive
{
	[[self currentEngine] applicationDidBecomeActive];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
	return [[self currentEngine] handleOpenURL:url];
}

#pragma mark -
#pragma mark private method
//
//调用代理返回信息没有输入要获取那种信息的类型
- (void)reportNotSetEngineType {
	if([self.delegate respondsToSelector:@selector(thirdPartAccountNotSetEngineType:)]) {
		[self.delegate thirdPartAccountNotSetEngineType:self];
	}
}


#pragma mark setter&getter method
//
//配置新浪微博登陆时的appkey和secority并初始化
- (TPASinaEngine *)sinaEngine {
	if(!_sinaEngine) {
		_sinaEngine = [[TPASinaEngine alloc] initWithAppKey:SINA_APPKEY appSecret:SINA_APPSECRET ssoCallback:_ssoCallback];
		_sinaEngine.redirectURI = SINA_REDIRECT;
	}
	
	return _sinaEngine;
}

//
//配置微信登陆时的appkey和secority并初始化
- (TPATencentEngine *)tencentEngine {
	if(!_tencentEngine) {
		_tencentEngine = [[TPATencentEngine alloc] initWithAppKey:QQ_APPKEY appSecret:QQ_APPSECRET];
		_tencentEngine.redirectURI = @"http://mask911.net/";
	}
	
	return _tencentEngine;
}


#pragma mark -
#pragma mark TPAEngineDelegate
- (void)engineAlreadyLogin:(id<TPAEngine>)engine {
	if([self.delegate respondsToSelector:@selector(thirdPartAccount:didLoginSccuess:)]) {
		[self.delegate thirdPartAccount:self didLoginSccuess:_engineType];
	}
}

- (void)engineDidLogin:(id<TPAEngine>)engine {
	if([self.delegate respondsToSelector:@selector(thirdPartAccount:didLoginSccuess:)]) {
		[self.delegate thirdPartAccount:self didLoginSccuess:_engineType];
	}
}

- (void)engineDidLoginCancelled:(id<TPAEngine>)engine {
	if([self.delegate respondsToSelector:@selector(thirdPartAccountLoginCancelled:)]) {
		[self.delegate thirdPartAccountLoginCancelled:self];
	}
}

- (void)engine:(id<TPAEngine>)engine didFailToLoginWithError:(NSError *)error {
	if([self.delegate respondsToSelector:@selector(thirdPartAccount:didFailToLoginWithError:)]) {
		[self.delegate thirdPartAccount:self didFailToLoginWithError:error];
	}
}

- (void)engineDidLogout:(id<TPAEngine>)engine {
	if([self.delegate respondsToSelector:@selector(thirdPartAccount:didLogoutSccuess:)]) {
		[self.delegate thirdPartAccount:self didLogoutSccuess:_engineType];
	}
}

- (void)engineNotAuthorized:(id<TPAEngine>)engine {
	if([self.delegate respondsToSelector:@selector(thirdPartAccountNotAuthorized:)]) {
		[self.delegate thirdPartAccountNotAuthorized:self];
	}
}

- (void)engineAuthorizeExpired:(id<TPAEngine>)engine {
	if([self.delegate respondsToSelector:@selector(thirdPartAccountAuthorizeExpired:)]) {
		[self.delegate thirdPartAccountAuthorizeExpired:self];
	}
}

- (void)engine:(id<TPAEngine>)engine requestDidFailWithError:(NSError *)error {
//	- (void)thirdPartAccount:(ThirdPartAccount *)thirdPartAccount requestDidFailWithError:(NSError *)error;
	if([self.delegate respondsToSelector:@selector(thirdPartAccount:requestDidFailWithError:)]) {
		[self.delegate thirdPartAccount:self requestDidFailWithError:error];
	}
}

- (void)engine:(id<TPAEngine>)engine requestDidSucceedWithResult:(id)result {
//	- (void)thirdPartAccount:(ThirdPartAccount *)thirdPartAccount requestDidSucceedWithResult:(id)result;
	NSLog(@"result: %@", result);
	switch (_engineType) {
		case TPAEngineTypeSina:
		{
			if([_sinaEngine.requestMethod isEqualToString:kSina_UserInfo]) {
				if([self.delegate respondsToSelector:@selector(thirdPartAccount:userInfo:)]) {
					NSDictionary *resultDic = (NSDictionary *)result;
					NSDictionary *userInfo = resultDic;
					[self.delegate thirdPartAccount:self userInfo:userInfo];
					return;
				}
			}
		}
			break;
		case TPAEngineTypeTencent:
		{
			if([_tencentEngine.requestMethod isEqualToString:kTencent_UserInfo]) {
				if([self.delegate respondsToSelector:@selector(thirdPartAccount:userInfo:)]) {
					NSDictionary *resultDic = [(NSDictionary *)result objectForKey:@"data"];
					NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
											  [resultDic objectForKey:@"nick"], @"name",
											  [resultDic objectForKey:@"head"], @"avatar",
											  [NSString stringWithFormat:@"tenc_%@", [resultDic objectForKey:@"openid"]], @"userid",
											  nil];
					[self.delegate thirdPartAccount:self userInfo:userInfo];
					return;
					//openid = 1DD56533396C314F18CDB7C1FDE45E32;
					//
				}
			}
		}
			break;
		default:
			break;
	}

	if([self.delegate respondsToSelector:@selector(thirdPartAccount:requestDidSucceedWithResult:)]) {
		[self.delegate thirdPartAccount:self requestDidSucceedWithResult:result];
	}
}
@end
