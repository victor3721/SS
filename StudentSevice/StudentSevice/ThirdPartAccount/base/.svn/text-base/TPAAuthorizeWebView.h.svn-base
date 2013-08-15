//
//  TPAAuthorizeWebView.h
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-18.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPAAuthorizeWebView;

@protocol TPAAuthorizeWebViewDelegate <NSObject>

- (void)authorizeWebView:(TPAAuthorizeWebView *)webView didReceiveAuthorizeInfo:(NSDictionary *)info;
- (void)authorizeWebViewClosed:(TPAAuthorizeWebView *)webView;

@end

@interface TPAAuthorizeWebView : UIView <UIWebViewDelegate> {
	UIView							*_panelView;
	UIView							*_containerView;
	UIActivityIndicatorView			*_indicatorView;
	UIWebView						*_webView;
	UIButton						*_closeButton;

	UIInterfaceOrientation			_previousOrientation;

	id<TPAAuthorizeWebViewDelegate>	_delegate;
}

@property (assign, nonatomic) id<TPAAuthorizeWebViewDelegate> delegate;

+ (void)setCloseButtonImageFile:(NSString *)imageFile;

- (void)loadRequestWithURL:(NSURL *)url;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;

@end
