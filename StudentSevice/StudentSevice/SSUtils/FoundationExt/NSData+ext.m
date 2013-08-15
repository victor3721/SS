//
//  NSData+ext.m
//  MFUtils
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "NSData+ext.h"
#import "GTMBase64.h"
#else
#import "NSData+ext.h"
#import "GTMBase64.h"
#endif
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

//Functions for Encoding Data.
@implementation NSData (EncodeExt)

- (NSString *)md5 {
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5([self bytes], [self length], result);
	
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSData *)HMACSHA1EncodeDataWithKey:(NSString *)key {
	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    void *buffer = malloc(CC_SHA1_DIGEST_LENGTH);
    CCHmac(kCCHmacAlgSHA1, [keyData bytes], [keyData length], [self bytes], [self length], buffer);
	
	NSData *encodedData = [NSData dataWithBytesNoCopy:buffer length:CC_SHA1_DIGEST_LENGTH freeWhenDone:YES];
    return encodedData;
}

- (NSString *)base64 {
	return [GTMBase64 stringByEncodingData:self];
}

@end
