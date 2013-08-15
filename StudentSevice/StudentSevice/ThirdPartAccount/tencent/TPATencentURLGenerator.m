//
//  TPATencentURLGenerator.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPATencentURLGenerator.h"
#import "TPATencentDefines.h"

@implementation TPATencentURLGenerator

+ (NSString *)authorizeWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI {
	return [self authorizeWithKey:key secret:secret redirectURI:redirectURI others:nil];
}

+ (NSString *)authorizeWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI others:(NSDictionary *)others {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   key, @"client_id",
								   @"code", @"response_type",
								   redirectURI, @"redirect_uri",
								   @"2", @"wap",
								   nil];

	if(others && others.count) {
		[params addEntriesFromDictionary:others];
	}

    return [self serializeURL:kTencentAuthorizeURL params:params httpMethod:@"GET"];
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

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params appKey:(NSString *)appKey accessToken:(NSString *)accessToken openID:(NSString *)openID httpMethod:(NSString *)httpMethod {
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
	[mutableParams setObject:appKey forKey:@"oauth_consumer_key"];
    [mutableParams setObject:accessToken forKey:@"access_token"];
    [mutableParams setObject:openID forKey:@"openid"];
	[mutableParams setObject:@"2.a" forKey:@"oauth_version"];
	[mutableParams setObject:@"all" forKey:@"scope"];
	[mutableParams setObject:@"json" forKey:@"format"];

	return [self serializeURL:baseURL params:mutableParams httpMethod:httpMethod];
}

@end
