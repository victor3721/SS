//
//  NSString+md5.m
//  MFUtils
//
//  Created by Martin Yin on 7/17/12.
//  Copyright (c) 2012 Autonavi. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "NSString+ext.h"
#import "NSData+ext.h"
#import "GTMBase64.h"
#else
#import "NSString+ext.h"
#import "NSData+ext.h"
#import "GTMBase64.h"
#endif
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

#pragma mark - NSString (EncodeExt)
@implementation NSString (EncodeExt)

- (NSString *)md5 {
	return [[self dataUsingEncoding:NSUTF8StringEncoding] md5];
}

- (NSData *)HMACSHA1EncodeDataWithKey:(NSString *)key {
	return [[self dataUsingEncoding:NSUTF8StringEncoding] HMACSHA1EncodeDataWithKey:key];
}

- (NSString *)base64 {
	return [[self dataUsingEncoding:NSUTF8StringEncoding] base64];
}

- (NSString *)urlEncode {
	return [self urlEncodeWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (NSString *)urlEncodeWithCFStringEncoding:(CFStringEncoding)encoding {
	return [(NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[[self mutableCopy] autorelease], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding) autorelease];
}

@end

#pragma mark - NSString (UtilExt)
@implementation NSString (UtilExt)

+ (NSString *)GUIDString {
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return [(NSString *)string autorelease];
}

- (NSString *)firstChar {
	NSInteger first = [self characterAtIndex:0];
	char str[2] = {'#', 0};
	if(first >= 'A' && first <= 'Z') {
		str[0] = first;
	} else if(first >= 'a' && first <= 'z') {
		str[0] = first-0x20;
	}

	return [NSString stringWithUTF8String:str];
}

@end
