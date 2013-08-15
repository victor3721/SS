//
//  FreshNewsViewController.m
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "FreshNewsViewController.h"
#import "InstantiateaTool.h"
#import "WeiboCell.h"
#import "Status.h"
#import "SinaManager.h"
#import "Status.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CellFrameSingleton.h"
#import "AppDelegate.h"
#define  RECT(x,y,w,h) CGRectMake(x, y, w, h)

@interface FreshNewsViewController ()
{
    UIButton*_footBtu;
    
    UIActivityIndicatorView *_activityView;
}
@property(nonatomic,retain)UIButton*footBtu;
@property(nonatomic,retain)UIActivityIndicatorView *activityView;

@end




@implementation FreshNewsViewController
@synthesize myWeibo =  _myWeibo;
@synthesize tableView = _tableView;
@synthesize weiboDataArr =  _weiboDataArr;
@synthesize refresh =  _refresh;
@synthesize userDataArr = _userDataArr;
@synthesize activityView = _activityView;
@synthesize loginView = _loginView;
@synthesize logInBtu = _logInBtu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.myWeibo = delegate.sinaWeibo;
    }
    return self;
}

#pragma mark - 生命周期


-(void)loadView
{
    [super loadView];
    
    checkNumber = 1;
    
    //配置title
    self.navigationItem.title = @"新鲜事";
    
    
    
    //配置底部按钮
    _footBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _footBtu.backgroundColor = [UIColor whiteColor];
    _footBtu.frame = CGRectMake(0, 0, 320, 44);
    UILabel *footLab = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 150, 44)];
    footLab.text = @"点击加载更多";
    footLab.textColor = [UIColor blackColor];
    footLab.backgroundColor = [UIColor clearColor];
    [_footBtu addSubview:footLab];
    [footLab release];
    _activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(80, 7, 30, 30)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped = YES;
    [_footBtu addSubview:self.activityView];
    [_footBtu addTarget:self action:@selector(weiboMore:) forControlEvents:UIControlEventTouchUpInside];

    
    
    //配置tableview
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-44-39-20)] autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.tableFooterView = _footBtu;
    [self.view addSubview:self.tableView];
    
    
    //添加重新登陆按钮
    self.logInBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logInBtu.frame = CGRectMake(0, 0, 320, 44);
    UILabel *logInLab = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 150, 44)];
    logInLab.text = @"点击重新登录";
    logInLab.textColor = [UIColor blackColor];
    logInLab.backgroundColor = [UIColor grayColor];
    [self.logInBtu addSubview:logInLab];
    [logInLab release];
    [self.logInBtu addTarget:self action:@selector(loginSina:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if (sinaweiboInfo == nil) {
        [self.view addSubview:self.logInBtu];
        self.loginView = [[[SinaLogInViewController alloc]init]autorelease];
        [self presentViewController:self.loginView animated:YES completion:^{}];
        checkNumber = 0;
    }
    else
    {
        //刷新数据
        [self loadData];
        [self loadUserInfo];
    }
    
    //添加下拉刷新
    self.refresh = [[[ODRefreshControl alloc]initInScrollView:self.tableView]autorelease];
    [self.refresh addTarget:self action:@selector(getRefresh) forControlEvents:UIControlEventValueChanged];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    }

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if (sinaweiboInfo != nil&&checkNumber == 0) {
        [self loadData];
        checkNumber = 1;
        [self.logInBtu removeFromSuperview];
    }
}


-(void)dealloc
{
    self.myWeibo = nil;
    self.tableView = nil;
    self.weiboDataArr = nil;
    self.refresh = nil;
    self.userDataArr = nil;
    self.activityView = nil;
    self.loginView = nil;
    self.logInBtu = nil;
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self.view window]==nil) {
        self.view = nil;
    }
    
}


#pragma mark -
#pragma mark public method

#pragma mark -
#pragma mark private method

#pragma mark Button Action

//获取更多的微博
-(void)weiboMore:(UIButton*)sender
{
    [self.activityView startAnimating];
    Status *status = [self.weiboDataArr lastObject];
    NSString *max_id = status.idstr;
    NSMutableDictionary *paraDic =[NSMutableDictionary dictionary];
    [paraDic setValue:WEIBONAME forKey:@"screen_name"];
    [paraDic setValue:max_id forKey:@"max_id"];
    [paraDic setValue:WEIBOCOUNT forKey:@"count"];
    
    SinaManager *sinaManager = [[SinaManager alloc]init];
    [sinaManager readStatusesWithURL:request_url Params:paraDic];
    [sinaManager setFinishBlock:^(id result) {
        NSMutableArray *newAdditions = result;
        [self.weiboDataArr removeObjectAtIndex:self.weiboDataArr.count-1];//移除重复的微博条目
        [self.weiboDataArr addObjectsFromArray:newAdditions];//为数组中增加新的对象
        [self.tableView reloadData];
        [self.activityView stopAnimating];
    }];
    [sinaManager release];
}

//微博下拉刷新
-(void)getRefresh
{
    NSMutableDictionary *paraDic =[NSMutableDictionary dictionary];
    [paraDic setValue:WEIBONAME forKey:@"screen_name"];
    [paraDic setValue:WEIBOCOUNT forKey:@"count"];
    
    SinaManager *sinaManager = [[SinaManager alloc]init];
    [sinaManager readStatusesWithURL:request_url Params:paraDic];
    [sinaManager setFinishBlock:^(id result) {
        self.weiboDataArr = result;
        [self.tableView reloadData];
        [self.refresh endRefreshing];
    }];
    [sinaManager release];
}

//最初加载的微博
-(void)loadData
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
    
    SinaManager *sinaManager = [[SinaManager alloc]init];
    [sinaManager setFinishBlock:^(id result) {
        self.weiboDataArr = result;
        [self.tableView reloadData];
        [HUD hide:YES];
    }];
    [sinaManager readStatuses];
    [sinaManager release];
}

-(void)loadUserInfo
{
    SinaManager *sinaManager = [[SinaManager alloc]init];
    [sinaManager setFinishBlock:^(id result) {
        self.userDataArr = result;
        Status *statu = [self.userDataArr objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:statu.user.screen_name forKey:@"screenName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:statu.user.profile_image_url forKey:@"userImage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }];
    
    [sinaManager readUserWithURL:request_url Params:nil];
    [sinaManager release];
}

-(void)loginSina:(UIButton*)sender
{
    [self.refresh endRefreshing];
    self.loginView = [[[SinaLogInViewController alloc]init]autorelease];
    [self presentViewController:self.loginView animated:YES completion:^{
        
    }];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}



#pragma mark -
#pragma mark table view datasouce
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboDataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *status = [self.weiboDataArr objectAtIndex:indexPath.row];
    return status.height_cell;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *status = [self.weiboDataArr objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"weibocell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[WeiboCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.status = status;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CellFrameSingleton shareCellFrame]changeFrameWithCell:cell];
    });
    return cell;
}


#pragma mark -
#pragma mark table view delegate



@end
