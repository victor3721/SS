//
//  TPATencentAuthorizeWebView.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-18.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPATencentAuthorizeWebView.h"

@implementation TPATencentAuthorizeWebView

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSRange range = [request.URL.absoluteString rangeOfString:@"code="];

	if (range.location != NSNotFound) {
//		NSLog(@"query:          %@", request.URL.query);
//		code=cd996dbfeb5c3228307cc59f1dd26873&openid=1DD56533396C314F18CDB7C1FDE45E32&openkey=294CBABDC7766D8C0433B8E8A9811C1B
		NSArray *queryParts = [request.URL.query componentsSeparatedByString:@"&"];
		NSMutableDictionary *infos = [NSMutableDictionary dictionaryWithCapacity:queryParts.count];
		for(NSString *queryPart in queryParts) {
			NSArray *p = [queryPart componentsSeparatedByString:@"="];
			[infos setObject:[p objectAtIndex:1] forKey:[p objectAtIndex:0]];
		}

		if ([_delegate respondsToSelector:@selector(authorizeWebView:didReceiveAuthorizeInfo:)]) {
			[_delegate authorizeWebView:self didReceiveAuthorizeInfo:infos];

			return NO;
		}
	}

	return YES;
}

@end
