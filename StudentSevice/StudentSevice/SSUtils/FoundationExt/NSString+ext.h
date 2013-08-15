//
//  NSString+md5.h
//  MFUtils
//
//  Created by Martin Yin on 7/17/12.
//  Copyright (c) 2012 Autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EncodeExt)

- (NSString *)md5;
- (NSData *)HMACSHA1EncodeDataWithKey:(NSString *)key;
- (NSString *)base64;
- (NSString *)urlEncode;
- (NSString *)urlEncodeWithCFStringEncoding:(CFStringEncoding)encoding;

@end

@interface NSString (UtilExt)

+ (NSString *)GUIDString;
- (NSString *)firstChar;

@end

