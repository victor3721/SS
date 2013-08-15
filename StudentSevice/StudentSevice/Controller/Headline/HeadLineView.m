//
//  HeadLineView.m
//  StudentSevice
//
//  Created by victor on 13-4-29.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "HeadLineView.h"
#import "AppDelegate.h"
#import "RentViewController.h"
#import "IISViewController.h"
#import "TravelViewController.h"
#import "FoodViewController.h"
#import "AirportViewController.h"
#import "HeadLineCell.h"
#import "RateViewController.h"
#import "SecondHandViewController.h"
#import "PostMeaasgeViewController.h"

@interface HeadLineView ()
{
    AirportViewController*_air;
    TravelViewController *_travel;
    RateViewController*_rate;
    FoodViewController*_food;
    IISViewController *_iis;
    RentViewController*_rent;
    SecondHandViewController*_secondHand;

}
@end

@implementation HeadLineView
@synthesize scrollView = _scrollView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //配置scrollView
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        
        //初始化各个viewController
        _air = [[AirportViewController alloc]init];//机场接送
        _travel = [[TravelViewController alloc]init];//旅游
        _rate = [[RateViewController alloc]init];//汇率查询
        _food = [[FoodViewController alloc]init];//吃喝玩乐
        _iis = [[IISViewController alloc]init];//学生登陆系统
        _rent = [[RentViewController alloc]init];//房屋出租
        _secondHand = [[SecondHandViewController alloc]init];//二手交易
        
        //把view添加到scrollView上面
        [_scrollView addSubview:_air.view];
        [_scrollView addSubview:_travel.view];
        [_scrollView addSubview:_rate.view];
        [_scrollView addSubview:_food.view];
        [_scrollView addSubview:_iis.view];
        [_scrollView addSubview:_rent.view];
        [_scrollView addSubview:_secondHand.view];
        
        //把scroller添加到view上面
        [self addSubview:_scrollView];
                
    }
    return self;
}

-(void)dealloc
{
    [_scrollView release];
    _scrollView = nil;
    
    [_air release];
    _air = nil;
    
    [_travel release];
    _travel = nil;
    
    [_rate release];
    _rate = nil;
    
    [_food release];
    _food  = nil;

    [_iis release];
    _iis = nil;

    [_rent release];
    _rent = nil;
    
    [_secondHand release];
    _secondHand = nil;

    [super dealloc];
}

-(void)layoutSubviews
{
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(screen_width*7, self.bounds.size.height);
    _travel.view.frame = CGRectMake(0, 0, screen_width, self.bounds.size.height);
}


@end
