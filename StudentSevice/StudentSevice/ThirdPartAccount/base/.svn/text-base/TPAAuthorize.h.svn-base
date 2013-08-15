//
//  TPAAuthorize.h
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol TPAAuthorize <NSObject>
- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI;

- (void)startAuthorize;

- (void)refreshAuthorize;

@end

@protocol TPAAuthorizeDelegate <NSObject>
@required

- (void)authorize:(id<TPAAuthorize>)authorize didSucceedWithAccessToken:(NSString *)accessToken userID:(NSString *)userID expiresIn:(NSInteger)seconds otherInfos:(NSDictionary *)otherInfos;

- (void)authorize:(id<TPAAuthorize>)authorize didFailWithError:(NSError *)error;

@optional
- (void)authorizeCancelled:(id<TPAAuthorize>)authorize;

@end
