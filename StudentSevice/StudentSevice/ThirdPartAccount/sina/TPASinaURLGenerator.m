//
//  TPASinaURLGenerator.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPASinaURLGenerator.h"
#import "TPASinaDefines.h"

BOOL SinaWeiboIsDeviceIPad()
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return YES;
    }
#endif
    return NO;
}

@implementation TPASinaURLGenerator

+ (NSString *)authorizeWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI {
	return [self authorizeWithKey:key secret:secret redirectURI:redirectURI others:nil];
}

+ (NSString *)authorizeWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI others:(NSDictionary *)others {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   key, @"client_id",
								   @"code", @"response_type",
								   redirectURI, @"redirect_uri",
								   @"true", @"forcelogin",
								   @"mobile", @"display",	// default | mobile | popup | wap1.2 | wap2.0 | js | apponweibo
								   nil];

	if(others && others.count) {
		[params addEntriesFromDictionary:others];
	}

    return [self serializeURL:kSinaAuthorizeURL params:params httpMethod:@"GET"];
}

+ (NSDictionary *)accessTokenParamsWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI code:(NSString *)code {
	return [self accessTokenParamsWithKey:key secret:secret redirectURI:redirectURI code:code others:nil];
}

+ (NSDictionary *)accessTokenParamsWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI code:(NSString *)code others:(NSDictionary *)others {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   key, @"client_id",
								   secret, @"client_secret",
								   @"authorization_code", @"grant_type",
								   redirectURI, @"redirect_uri",
								   code, @"code",
								   nil];

	if(others && others.count) {
		[params addEntriesFromDictionary:others];
	}

	return params;
}

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params accessToken:(NSString *)accessToken httpMethod:(NSString *)httpMethod {
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [mutableParams setObject:accessToken forKey:@"access_token"];
	
	return [self serializeURL:baseURL params:mutableParams httpMethod:httpMethod];
}

+ (NSString *)genSSOURL:(NSDictionary *)params {
	if (SinaWeiboIsDeviceIPad()) {
		return [self serializeURL:kSinaWeiboAppAuthURL_iPad params:params httpMethod:@"GET"];
	}

	return [self serializeURL:kSinaWeiboAppAuthURL_iPhone params:params httpMethod:@"GET"];
}

@end
