//
//  PointOutLoginView.m
//  StudentSevice
//
//  Created by victor on 13-5-5.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "PointOutLoginView.h"


@interface PointOutLoginView ()
{
    
    UIImageView *_backgroudImageview;
    UIButton *_loginButton;
    UILabel *_nameLable;
}
@property(nonatomic,retain)UIImageView *backgroudImageview;
@property(nonatomic,retain)UIButton *loginButton;
@property(nonatomic,retain)UILabel *nameLable;

@end


@implementation PointOutLoginView
@synthesize isLogin  = _isLogin;
@synthesize backgroudImageview = _backgroudImageview;
@synthesize loginButton = _loginButton;
@synthesize nameLable = _nameLable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _backgroudImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        [self addSubview:_backgroudImageview];
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:_loginButton];
        
        _nameLable = [[UILabel alloc]init];
        _nameLable.backgroundColor = [UIColor clearColor];
        _nameLable.text = @"登陆微博";
        [_loginButton addSubview:_nameLable];
        
        

    }
    return self;
}

-(void)dealloc
{
    self.backgroudImageview = nil;
    self.loginButton = nil;
    self.nameLable = nil;
    [super dealloc];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = CGRectMake(10, 10, 300, 44);
    _loginButton.frame = CGRectMake(0, 0, 0, 0);
    _backgroudImageview.frame = CGRectMake(0, 0, 0, 0);
    _nameLable.frame = CGRectMake(0, 0, 0, 0);
    
}


#pragma mark -
#pragma mark public method


#pragma mark -
#pragma mark private method
#pragma geter & setter method
-(void)setIsLogin:(BOOL)isLogin
{
    if (_isLogin == isLogin) {
        return;
    }
    
    _isLogin = isLogin;
    
}




@end
