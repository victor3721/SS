//
//  SinaLogInViewController.m
//  StudentServices
//
//  Created by victor on 13-3-16.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import "SinaLogInViewController.h"
#import "AppDelegate.h"
@interface SinaLogInViewController ()

@end

@implementation SinaLogInViewController
@synthesize sinaWeibo = _sinaWeibo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.sinaWeibo = delegate.sinaWeibo;
    }
    return self;
}

-(void)dealloc
{
    self.sinaWeibo = nil;

    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.frame = CGRectMake(0, 0, 320, screen_height-39-22);
    
    UIImage*logoImage = [UIImage imageNamed:@"sina_logo"];
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:logoImage];
    logoImageView.frame = CGRectMake(20, 5, 45, 45);
    
    UIButton*diamissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    diamissButton.frame = CGRectMake(245, 5, 70, 40);
    [diamissButton setImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    [diamissButton addTarget:self action:@selector(dismis:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * weiBoLogbut = [UIButton buttonWithType:UIButtonTypeCustom];
    weiBoLogbut.backgroundColor = [UIColor grayColor];
    weiBoLogbut.frame = CGRectMake(0, 0, 320, 50);
    [weiBoLogbut addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
    [weiBoLogbut setTitle:@"请点击登陆新浪微博" forState:UIControlStateNormal];
    [weiBoLogbut addSubview:logoImageView];
    [weiBoLogbut addSubview:diamissButton];
    [self.view addSubview:weiBoLogbut];
    [logoImageView release];
    
    UITextView*textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 50, 320, [UIScreen mainScreen].bounds.size.height-60)];
    textView.textColor = [UIColor blackColor];
    textView.text = @"  登录微博可以获得为你提供的各种有趣的信息，同时你将有权利发送租房以及二手交易信息。\n\n  如果你已经装有微博的客户端，本程序会跳着微博客户端完成认证之后在跳转回来。\n\n  如果没有微博客户端，会弹出页面输入用户名和密码，认证全部由新浪认证，本程序不干预，认证很安全。";
    textView.editable = NO;
    textView.font = [UIFont fontWithName:@"Arial" size:18];
    [self.view addSubview:textView];
    
//    [self.sinaWeibo setDidLogInBlock:^(SinaWeibo *sinaweibo) {
//        NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
//                                  sinaweibo.accessToken,@"AccessTokenKey",
//                                  sinaweibo.expirationDate,@"ExpirationDateKey",
//                                  sinaweibo.userID,@"UserIDKey",
//                                  sinaweibo.refreshToken,@"refresh_token",
//                                  nil];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        [self dismissViewControllerAnimated:YES completion:^{}];
//    }];

}

-(void)dismis:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)tapButton
{
    [self.sinaWeibo logIn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
