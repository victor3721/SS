//
//  TPATencentEngine.h
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAEngine.h"
#import "TPATencentAuthorize.h"
#import "TPATencentRequest.h"

@interface TPATencentEngine : NSObject <TPAEngine, TPAAuthorizeDelegate, TPARequestDelegate>

@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *accessToken;
@property (assign, nonatomic) NSTimeInterval expireTime;
@property (strong, nonatomic) NSString *refreshToken;
@property (strong, nonatomic) NSString *openID;
@property (strong, nonatomic) NSString *openKey;
@property (strong, nonatomic) NSString *redirectURI;
//@property (nonatomic, assign) BOOL isUserExclusive;
@property (strong, nonatomic) NSString *requestMethod;
@property (strong, nonatomic) TPATencentRequest *request;
@property (strong, nonatomic) TPATencentAuthorize *authorize;
@property (assign, nonatomic) id<TPAEngineDelegate> delegate;
//@property (nonatomic, assign) UIViewController *rootViewController;

@end
