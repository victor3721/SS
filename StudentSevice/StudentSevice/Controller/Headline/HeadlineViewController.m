//
//  HeadlineViewController.m
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "HeadlineViewController.h"
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

#import "HeadLineView.h"

@interface HeadlineViewController ()
{
    NSArray *_titleArr;//标题的title
    UIButton *_menuButton;//菜单按钮
    UIButton *_rightButton;//打开发送按钮
    HeadLineView *_headLineView;//
    NSIndexPath *_indexPath;//选中条目的index
    NSNotificationCenter *_notificationCenter;//通知中心
}
@end



@implementation HeadlineViewController

#pragma mark - life cycle

//-(void)menuButton
//{
//    UIButton * _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _menuButton.frame = CGRectMake(0, 0, 33, 31);
//    [_menuButton setImage:[UIImage imageNamed:menuButtonBg_unselect] forState:UIControlStateNormal];
//    [_menuButton setImage:[UIImage imageNamed:menuButtonBg_select] forState:UIControlStateSelected];
//    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:_menuButton]autorelease];
//    self.navigationItem.title = @"旅游";
//    [_menuButton addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
//}


-(void)loadView
{
    [super loadView];
    
    //
    
    //设置title的名字
    _titleArr = [[NSArray arrayWithObjects:@"旅游",@"机场接送",@"二手交易",@"房屋出租",@"汇率查询",@"吃喝玩乐",@"IIS",@"留学", nil]retain];
    
    //打开菜单栏按钮
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.frame = CGRectMake(0, 0, 33, 31);
    [_menuButton setImage:[UIImage imageNamed:menuButtonBg_unselect] forState:UIControlStateNormal];
    [_menuButton setImage:[UIImage imageNamed:menuButtonBg_select] forState:UIControlStateSelected];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:_menuButton]autorelease];
    self.navigationItem.title = @"旅游";
    
    //发送信息按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 33, 31);
    [_rightButton setImage:[UIImage imageNamed:@"writeMessage"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"writeMessage"] forState:UIControlStateSelected];
    _rightButton.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:_rightButton]autorelease];
    
    
    //板块scrollerView
    _headLineView = [[HeadLineView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-44-39-20)];
    [self.view addSubview:_headLineView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //打开菜单栏的事件
    [_menuButton addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //发送信息事件
    [_rightButton addTarget:self action:@selector(postAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //通知事件用来改变title
    _notificationCenter = [NSNotificationCenter defaultCenter];
    [_notificationCenter addObserver:self selector:@selector(changeTitle:) name:ChangeTitleNotification object:nil];
}

-(void)dealloc
{
    [_titleArr release];
    _titleArr = nil;
    
    [_notificationCenter removeObserver:self];
    [_notificationCenter release];
    _notificationCenter = nil;
    
    [_headLineView release];
    _headLineView = nil;
    
    [_indexPath release];
    _indexPath = nil;
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self.view window]==nil) {
        _headLineView = nil;
        self.view = nil;
    }
}

#pragma mark - 
#pragma mark - private method

//通知
-(void)changeTitle:(NSNotification *)notification
{
//    _indexPath = [[[notification valueForKey:@"userInfo"]valueForKey:@"indexPath"]retain];
//    self.navigationItem.title = [_titleArr objectAtIndex:_indexPath.row] ;
//    if (_indexPath.row ==2||_indexPath.row == 3)
//    {
//        _rightButton.hidden = NO;
//    }
//    else
//    {
//        _rightButton.hidden = YES;
//    }
//    _menuButton.selected = NO;
//    _headLineView.scrollView.contentOffset = CGPointMake(320*_indexPath.row, 0);
//    self.menuBlock(self,NO);
    

    
    _indexPath = [[[notification valueForKey:@"userInfo"]valueForKey:@"indexPath"]retain];
    self.navigationItem.title = [_titleArr objectAtIndex:_indexPath.row] ;
    self.tabBarController.selectedIndex = _indexPath.row;
    
    
    
}


#pragma mark - button action
//设置左侧按钮方法
-(void)menuAction:(UIButton *)button
{
    button.selected = !button.selected;
    self.menuBlock(self,button.selected);
}

-(void)postAction:(UIButton *)button
{
    PostMeaasgeViewController *post = [[PostMeaasgeViewController alloc]init];
    post.indexPath = _indexPath;
    [self presentViewController:post animated:YES completion:^{}];
}

@end
