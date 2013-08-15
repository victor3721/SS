//
//  TPASinaAuthorizeWebView.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-18.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPASinaAuthorizeWebView.h"

@implementation TPASinaAuthorizeWebView

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSRange range = [request.URL.absoluteString rangeOfString:@"code="];

	if (range.location != NSNotFound) {
		NSString *code = [request.URL.absoluteString substringFromIndex:range.location + range.length];

		if ([_delegate respondsToSelector:@selector(authorizeWebView:didReceiveAuthorizeInfo:)]) {
			[_delegate authorizeWebView:self
				didReceiveAuthorizeInfo:[NSDictionary dictionaryWithObject:code forKey:@"code"]];

			return NO;
		}
	}

	return YES;
}

@end
