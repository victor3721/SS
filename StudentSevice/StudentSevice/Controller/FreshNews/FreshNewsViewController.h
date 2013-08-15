//
//  FreshNewsViewController.h
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaLogInViewController.h"
#import "ODRefreshControl.h"
#import "MBProgressHUD.h"
@interface FreshNewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
{
    SinaWeibo *_myWeibo;
    UITableView *_tableView;
    NSMutableArray *_weiboDataArr;
    ODRefreshControl *_refresh;
    NSMutableArray *_userDataArr;
    
    SinaLogInViewController*_loginView;
    MBProgressHUD *HUD;
    UIButton*_logInBtu;
    int checkNumber;
}
@property(nonatomic,retain)SinaWeibo *myWeibo;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *weiboDataArr;
@property(nonatomic,retain)NSMutableArray *userDataArr;
@property(nonatomic,retain)ODRefreshControl *refresh;

@property(nonatomic,retain)SinaLogInViewController*loginView;
@property(nonatomic,retain)UIButton*logInBtu;

-(void)loadData;
@end
