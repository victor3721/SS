//
//  TPAURLGenerator.h
//  ThirdPartAccount
//
//  Created by Yin Martin on 12-7-16.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kTPARequestPostDataTypeNone,
	kTPARequestPostDataTypeNormal,			// for normal data post, such as "user=name&password=psd"
	kTPARequestPostDataTypeMultipart,        // for uploading images and files.
} TPARequestPostDataType;

#define kTPARequestStringBoundary    @"293iosfksdfkiowjksdf31jsiuwq003s02dsaffafass3qw"

@interface TPAURLGenerator : NSObject

+ (NSString *)authorizeWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI;

+ (NSString *)authorizeWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI others:(NSDictionary *)others;

+ (NSDictionary *)accessTokenParamsWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI code:(NSString *)code;

+ (NSDictionary *)accessTokenParamsWithKey:(NSString *)key secret:(NSString *)secret redirectURI:(NSString *)redirectURI code:(NSString *)code others:(NSDictionary *)others;

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params httpMethod:(NSString *)httpMethod;

+ (NSString *)stringFromDictionary:(NSDictionary *)dict;

+ (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString;

+ (NSMutableData *)postBodyFromParams:(NSDictionary *)params postDataType:(TPARequestPostDataType)postDataType;

@end
