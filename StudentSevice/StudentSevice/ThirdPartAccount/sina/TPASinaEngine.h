//
//  TPASinaEngine.h
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAEngine.h"
#import "TPASinaAuthorize.h"
#import "TPASinaRequest.h"

@interface TPASinaEngine : NSObject <TPAEngine, TPAAuthorizeDelegate, TPARequestDelegate>

@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *accessToken;
@property (assign, nonatomic) NSTimeInterval expireTime;
@property (strong, nonatomic) NSString *redirectURI;
@property (strong, nonatomic) NSString *ssoCallbackScheme;
//@property (nonatomic, assign) BOOL isUserExclusive;
@property (strong, nonatomic) NSString *requestMethod;
@property (strong, nonatomic) TPASinaRequest *request;
@property (strong, nonatomic) TPASinaAuthorize *authorize;
@property (assign, nonatomic) id<TPAEngineDelegate> delegate;
//@property (nonatomic, assign) UIViewController *rootViewController;

@end
