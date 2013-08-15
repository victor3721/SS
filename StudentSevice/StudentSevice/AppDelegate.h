//
//  AppDelegate.h
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "FreshNewsViewController.h"
#import "RecommendViewController.h"
#import "MoreViewController.h"
#import "MenuView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SinaWeibo *sinaWeibo;

    
    BOOL _isShowMenuView;
    
}

@property(strong, nonatomic) UIWindow *window;

@property(retain,nonatomic)SinaWeibo *sinaWeibo;
@property(assign,nonatomic)BOOL isShowMenuView;
@end
