//
//  IISwebview.m
//  StudentSevice
//
//  Created by victor on 13-6-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "IISwebview.h"

@interface IISwebview()
{
    NSURL *_url;
}

@property(nonatomic,retain)NSURL *url;


@end


@implementation IISwebview
@synthesize stopBtu = _stopBtu;
@synthesize backBtu = _backBtu;
@synthesize IISWebView = _IISWebView;
@synthesize url = _url;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //配置webview
        self.IISWebView = [[UIWebView alloc]init];
        self.url =[NSURL URLWithString:IIS_url];
        NSURLRequest *request =[NSURLRequest requestWithURL:self.url];
        [self.IISWebView loadRequest:request];
        [self addSubview:self.IISWebView];
        
        //
        //配置后退button
        self.backBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backBtu setImage:[UIImage imageNamed:@"webview_backbutton"] forState:UIControlStateNormal];
        [self.backBtu addTarget:self action:@selector(gotoBack:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backBtu];
        
        //
        //配置停止button
        self.stopBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.stopBtu setImage:[UIImage imageNamed:@"webview_stopbutton"] forState:UIControlStateNormal];
        [self.stopBtu addTarget:self action:@selector(gotoStop:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.stopBtu];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.IISWebView.frame = self.bounds;
    self.backBtu.frame = CGRectMake(10, screen_height-20-45-44-39, 44, 44);
    self.stopBtu.frame = CGRectMake(screen_width-10-44, screen_height-20-45-44-39, 44, 44);
}

-(void)dealloc
{
    [super dealloc];
    self.url = nil;
    self.backBtu = nil;
    self.stopBtu = nil;
}

@end
