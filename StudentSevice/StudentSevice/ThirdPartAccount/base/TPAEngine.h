//
//  TPAEngine.h
//  ThirdPartAccount
//
//  Created by Yin Martin on 12-7-16.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAURLGenerator.h"


/****************************************
 * 基础类 应该是组合模式 新浪和微信的分别
 * 位于这类下面 相当于继承本类的方法
 *
 *                                    
*****************************************/

@protocol TPAEngineDelegate;

@protocol TPAEngine <NSObject>

//
//初始化方法
//正常没有用sso认证网页认证
- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret;
//有sso认证
- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret ssoCallback:(NSString *)ssoCallback;


- (void)setDelegate:(id<TPAEngineDelegate>)delegate;

- (void)login;
- (void)logout;

- (void)refreshAuthorize;

- (BOOL)isAlreadyLogin;
- (BOOL)isAuthorizeExpired;

//
//请求数据的方法
- (void)loadRequestWithMethodName:(NSString *)methodName
                       httpMethod:(NSString *)httpMethod
                           params:(NSDictionary *)params
                     postDataType:(TPARequestPostDataType)postDataType
                 httpHeaderFields:(NSDictionary *)httpHeaderFields;

//
//对认证信息的操作保存读取和删除
- (void)saveAuthorizeDataToKeychain;
- (void)readAuthorizeDataFromKeychain;
- (void)deleteAuthorizeDataInKeychain;

//
//
- (BOOL)handleOpenURL:(NSURL *)url;
- (void)applicationDidBecomeActive;

@end

@protocol TPAEngineDelegate <NSObject>

@optional

- (void)engineAlreadyLogin:(id<TPAEngine>)engine;

- (void)engineDidLogin:(id<TPAEngine>)engine;

- (void)engineDidLoginCancelled:(id<TPAEngine>)engine;

- (void)engine:(id<TPAEngine>)engine didFailToLoginWithError:(NSError *)error;

- (void)engineDidLogout:(id<TPAEngine>)engine;

- (void)engineNotAuthorized:(id<TPAEngine>)engine;
- (void)engineAuthorizeExpired:(id<TPAEngine>)engine;

- (void)engine:(id<TPAEngine>)engine requestDidFailWithError:(NSError *)error;
- (void)engine:(id<TPAEngine>)engine requestDidSucceedWithResult:(id)result;

@end
