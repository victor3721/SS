//
//  AppDelegate.m
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "AppDelegate.h"
#import "CheckNetwork.h"
#import "RentViewController.h"
#import "IISViewController.h"
#import "TravelViewController.h"
#import "SecondHandViewController.h"
#import "RateViewController.h"
#import "FoodViewController.h"
#import "AirportViewController.h"


#ifndef kAppKey
#define kAppKey @"4039624193"
#endif

#ifndef kAppSecret
#define kAppSecret @"efe9ad60e845ec07db05af37023c8eae"
#endif

#ifndef kAppURL
#define kAppURL @"http://www.baidu.com"
#endif

#define TEXTFOUNT @"Helvetica-Light"

#define MENUVIEWIDTH 270

@interface AppDelegate ()
{
    UITabBarController *tab;
    MenuView *_menuView;
    NSNotificationCenter *_notificationCenter;//通知中心
    UILabel *_titleLab;
    NSArray *_titleArr;
}
@property(nonatomic,retain)MenuView *menuView;
@end


@implementation AppDelegate
@synthesize sinaWeibo;
@synthesize menuView = _menuView;
@synthesize isShowMenuView = _isShowMenuView;
- (void)dealloc
{
    self.sinaWeibo = nil;
    self.menuView = nil;
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //
    //状态栏是黑色的
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    //
    //初始化menuview
    [self loadMenuView];
    
    //
    //底部的选项卡
    self.window.rootViewController = [self returnTabBar];
    
    //
    //通知事件用来改变title
    _notificationCenter = [NSNotificationCenter defaultCenter];
    [_notificationCenter addObserver:self selector:@selector(changeTitle:) name:ChangeTitleNotification object:nil];
    
    //
    //初始化naviagationBar(自定义的)
    [self loadNavigationBar];
    
    
    return YES;
}

//
//新浪微博
-(void)makeSinaWeibo
{
    //初始化新浪微博
    sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppURL andDelegate:nil];
    
    //从userdefaults中读取weibo的appID以及其他信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:SinaWeiboAuthData];
    if ([sinaweiboInfo objectForKey:AccessTokenKey] && [sinaweiboInfo objectForKey:ExpirationDateKey] && [sinaweiboInfo objectForKey:UserIDKey])
    {
        sinaWeibo.accessToken = [sinaweiboInfo objectForKey:AccessTokenKey];
        sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:ExpirationDateKey];
        sinaWeibo.userID = [sinaweiboInfo objectForKey:UserIDKey];
    }
}

//
//自定义的navigationBar
-(void)loadNavigationBar
{
    
    UIButton * _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.frame = CGRectMake(0, 0, 40, 40);
    [_menuButton setImage:[UIImage imageNamed:menuButtonBg_unselect] forState:UIControlStateNormal];
    [_menuButton setImage:[UIImage imageNamed:menuButtonBg_select] forState:UIControlStateSelected];
    [_menuButton addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    _titleLab.text = @"旅游";
    _titleLab.center = CGPointMake(160, 20);
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font = [UIFont fontWithName:TEXTFOUNT size:20];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    UIView *backgroundImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    backgroundImage.backgroundColor = [UIColor blackColor];
    backgroundImage.alpha = 0.7;
    [view addSubview:backgroundImage];
    [view addSubview:_menuButton];
    [view addSubview:_titleLab];
    [backgroundImage release];
    [tab.view addSubview:view];
    [view release];
    
    
    view.layer.cornerRadius = 5;//设置那个圆角的有多圆
    view.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
    view.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
    view.layer.masksToBounds = YES;
    
    
    
}


//设置左侧按钮方法
-(void)menuAction:(UIButton *)button
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.isShowMenuView == YES) {
        delegate.isShowMenuView = NO;
    }
    else
    {
        delegate.isShowMenuView = YES;
    }
}


//
//menuview的初始化
-(void)loadMenuView
{
    //初始化头条页面的菜单栏
    self.menuView = [[[MenuView alloc]initWithFrame:CGRectMake(-MENUVIEWIDTH, 20, MENUVIEWIDTH, screen_height) style:UITableViewStylePlain]autorelease];
    [self.menuView loadData];
    [self.window addSubview:self.menuView];
}

//
//初始化选显卡view
-(UITabBarController*)returnTabBar
{
        
    //初始化tabBarController并的设置tabBar的高度
    tab = [[[UITabBarController alloc]init]autorelease];
    for (UIView *view in [tab.view subviews]) {
        if ([view isKindOfClass:[UITabBar class]]) {
            view.frame = CGRectMake(0, screen_height, screen_width, 39);
        }
        else{
            view.frame = CGRectMake(0, 0, screen_width, screen_height);
        }
    }
    
    //
    //旅游页面controller
    TravelViewController *travel = [[TravelViewController alloc]init];
    UINavigationController *travelNavigation = [[UINavigationController alloc]initWithRootViewController:travel];
    travelNavigation.navigationBarHidden = YES;
    [travel release];
    
    //
    //机场接送页面的controller
    AirportViewController *airport = [[AirportViewController alloc]init];
    UINavigationController *airportNavigation = [[UINavigationController alloc]initWithRootViewController:airport];
    airportNavigation.navigationBarHidden = YES;
    [airport release];
    
    //
    //二手交易页面的controller
    SecondHandViewController *secondHand = [[SecondHandViewController alloc]init];
    UINavigationController *secondHandNavigation = [[UINavigationController alloc]initWithRootViewController:secondHand];
    secondHandNavigation.navigationBarHidden = YES;
    [secondHand release];
    
    //
    //房屋出租页面的controller
    RentViewController *rent = [[RentViewController alloc]init];
    UINavigationController *rentNavigation = [[UINavigationController alloc]initWithRootViewController:rent];
    rentNavigation.navigationBarHidden = YES;
    [rent release];
    
    //
    //汇率查询页面的controller
    RateViewController *rate = [[RateViewController alloc]init];
    UINavigationController *rateNavigation = [[UINavigationController alloc]initWithRootViewController:rate];
    rateNavigation.navigationBarHidden = YES;
    [rate release];
    
    //
    //美食页面的controller
    FoodViewController *food = [[FoodViewController alloc]init];
    UINavigationController *foodNavigation = [[UINavigationController alloc]initWithRootViewController:food];
    foodNavigation.navigationBarHidden = YES;
    [food release];
    
    //
    //学生登陆系统的contoller
    IISViewController *iis = [[IISViewController alloc]init];
    UINavigationController *iisNavigation = [[UINavigationController alloc]initWithRootViewController:iis];
    iisNavigation.navigationBarHidden = YES;
    [iis release];
    

    //
    //新鲜事的controller
    FreshNewsViewController *fresh = [[FreshNewsViewController alloc]init];
    UINavigationController *freshNavigation = [[UINavigationController alloc]initWithRootViewController:fresh];
    freshNavigation.navigationBarHidden = YES;
    [fresh release];

    
    //
    //设置界面的controller
    MoreViewController *more = [[MoreViewController alloc]init];
    UINavigationController *moreNavigation = [[UINavigationController alloc]initWithRootViewController:more];
    moreNavigation.navigationBarHidden = YES;
    [more release];
    
    
    //
    //添加tabbar的子viewcontroller
    tab.viewControllers = [NSArray arrayWithObjects:travelNavigation,airportNavigation,secondHandNavigation,rentNavigation,rateNavigation,foodNavigation,iisNavigation,freshNavigation,moreNavigation, nil];
    //
    //隐藏tabbar
    tab.tabBar.hidden = YES;
    
    [travelNavigation release];
    [airportNavigation release];
    [secondHandNavigation release];
    [rentNavigation release];
    [rateNavigation release];
    [foodNavigation release];
    [iisNavigation release];
    [freshNavigation release];
    [moreNavigation release];

    return tab;
}

//
//显示menuview
-(void)setIsShowMenuView:(BOOL)isShowMenuView
{
    if (_isShowMenuView == isShowMenuView) {
        return;
    }
    
    _isShowMenuView = isShowMenuView;
    
    if (_isShowMenuView) {
        [UIView animateWithDuration:0.25 animations:^{
            tab.view.frame = CGRectMake(MENUVIEWIDTH, 0, screen_width, screen_height);
            self.menuView.frame = CGRectMake(0, 20, MENUVIEWIDTH, screen_height);
        }];
    }
    else{
        [UIView animateWithDuration:0.25 animations:^{
            tab.view.frame = CGRectMake(0, 0, screen_width, screen_height);
            self.menuView.frame = CGRectMake(-MENUVIEWIDTH, 20, MENUVIEWIDTH, screen_height);
        }];
    }
}


//通知改变选项卡的页面
-(void)changeTitle:(NSNotification *)notification
{
    NSIndexPath *_indexPath = [[[notification valueForKey:@"userInfo"]valueForKey:@"indexPath"]retain];
    tab.selectedIndex = _indexPath.row;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.isShowMenuView = NO;
    _titleArr = [NSArray arrayWithObjects:@"旅游",@"机场接送",@"二手交易",@"房屋出租",@"汇率查询",@"吃喝玩乐",@"IIS" ,nil];
    _titleLab.text = [_titleArr objectAtIndex:_indexPath.row];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.sinaWeibo applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self.sinaWeibo handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.sinaWeibo handleOpenURL:url];
}

@end
