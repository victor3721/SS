//
//  ThirdPartAccount.h
//  ThirdPartAccount
//
//  Created by Yin Martin on 12-7-16.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAEngine.h"
#import "TPASinaEngine.h"
#import "TPATencentEngine.h"

/**************************
 
 集成新浪和微信的两种登陆的方式，
 并在登陆之后获取用户信息存储到本地，
 
 
 
 
 
 **************************/



//
//两种登陆类型 新浪和微信
typedef enum {
	TPAEngineTypeNone = 0,
	TPAEngineTypeSina,
	TPAEngineTypeTencent,
} TPAEngineType;

@class ThirdPartAccount;

@protocol ThirdPartAccountDelegate <NSObject>
@optional

//
//方法：没有设置用哪一种方式登陆
- (void)thirdPartAccountNotSetEngineType:(ThirdPartAccount *)thirdPartAccount;

//
//
- (void)thirdPartAccount:(ThirdPartAccount *)thirdPartAccount didLoginSccuess:(TPAEngineType)type;

//
//
- (void)thirdPartAccountLoginCancelled:(ThirdPartAccount *)thirdPartAccount;

//
//
- (void)thirdPartAccount:(ThirdPartAccount *)thirdPartAccount didFailToLoginWithError:(NSError *)error;

//
//
- (void)thirdPartAccount:(ThirdPartAccount *)thirdPartAccount didLogoutSccuess:(TPAEngineType)type;

//
//
- (void)thirdPartAccountNotAuthorized:(ThirdPartAccount *)thirdPartAccount;
- (void)thirdPartAccountAuthorizeExpired:(ThirdPartAccount *)thirdPartAccount;

//
//
- (void)thirdPartAccount:(ThirdPartAccount *)thirdPartAccount requestDidFailWithError:(NSError *)error;
- (void)thirdPartAccount:(ThirdPartAccount *)thirdPartAccount requestDidSucceedWithResult:(id)result;

//
//
- (void)thirdPartAccount:(ThirdPartAccount *)thirdPartAccount userInfo:(NSDictionary *)userInfo; //key: name/avatar

@end

@interface ThirdPartAccount : NSObject <TPAEngineDelegate>

@property (assign, nonatomic) id<ThirdPartAccountDelegate> delegate;
@property (strong, nonatomic) NSString *ssoCallback;
@property (assign, nonatomic) TPAEngineType engineType;

//
//静态类方法
+ (id)standardTPA;

//
//现在选在那种登陆的类型 
- (id<TPAEngine>)currentEngine;

//
//登陆和退出的方法
- (void)login;
- (void)logout;

- (void)getUserInfo;

- (void)applicationDidBecomeActive;
- (BOOL)handleOpenURL:(NSURL *)url;

@end
