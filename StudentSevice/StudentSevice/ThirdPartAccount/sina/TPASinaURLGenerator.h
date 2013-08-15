//
//  TPASinaURLGenerator.h
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPAURLGenerator.h"

@interface TPASinaURLGenerator : TPAURLGenerator

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params accessToken:(NSString *)accessToken httpMethod:(NSString *)httpMethod;

+ (NSString *)genSSOURL:(NSDictionary *)params;

@end
