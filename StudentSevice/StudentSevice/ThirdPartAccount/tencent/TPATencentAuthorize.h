//
//  TPATencentAuthorize.h
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAAuthorize.h"
#import "TPATencentAuthorizeWebView.h"
#import "TPATencentRequest.h"

@interface TPATencentAuthorize : NSObject <TPAAuthorize, TPAAuthorizeWebViewDelegate, TPARequestDelegate> {
	TPATencentAuthorizeWebView		*_webView;
	TPATencentRequest				*_request;
}

@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *redirectURI;
@property (strong, nonatomic) NSString *openID;
@property (strong, nonatomic) NSString *openKey;
@property (assign, nonatomic) id<TPAAuthorizeDelegate> delegate;

- (void)refreshAuthorize:(NSString *)refreshToken;

@end
