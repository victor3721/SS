//
//  RecommendViewController.m
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "RecommendViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ADsCell.h"
#import "YouMiConfig.h"
@implementation RecommendViewController
@synthesize youMiAppArray = _youMiAppArray;
@synthesize youMiTableView = _youMiTableView;
@synthesize wall = _wall;
@synthesize activityView = _activityView;
#pragma mark - 生命周期
 
-(void)dealloc
{
    self.youMiTableView = nil;
    self.youMiAppArray = nil;
    self.activityView = nil;
    self.wall = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"推荐应用";
    
    //配置有米广告的参数
    [self makeYouMi];
    
    //设置tableView
    self.youMiTableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-44-39-20)]autorelease];
    self.youMiTableView.delegate = self;
    self.youMiTableView.dataSource =self;
    
    UIButton*footBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtu.backgroundColor = [UIColor grayColor];
    footBtu.frame = CGRectMake(0, 0, 320, 44);
    UILabel *footLab = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 150, 44)];
    footLab.text = @"点击加载更多";
    footLab.textColor = [UIColor blackColor];
    footLab.backgroundColor = [UIColor clearColor];
    [footBtu addSubview:footLab];
    [footLab release];
    self.activityView=[[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(80, 7, 30, 30)]autorelease];
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.activityView.hidesWhenStopped = YES;
    [footBtu addSubview:self.activityView];
    [footBtu addTarget:self action:@selector(getMore:) forControlEvents:UIControlEventTouchUpInside];
    self.youMiTableView.tableFooterView = footBtu;
    
    
    [self.view addSubview:self.youMiTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark  - tableView的代理方法



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.youMiAppArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Celldentifier= @"Cell";
    ADsCell *cell = [tableView dequeueReusableCellWithIdentifier:Celldentifier];
    if (cell == nil)
    {
        cell = [[[ADsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celldentifier]autorelease];
    }
    YouMiWallAppModel *youMiModel = [self.youMiAppArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = youMiModel.name;
    cell.detailLabel.text = youMiModel.desc;
    [cell.picView setImageWithURL:[NSURL URLWithString:youMiModel.smallIconURL]];
    [cell.downLoadBtu addTarget:self action:@selector(pushToItunes:) forControlEvents:UIControlEventTouchUpInside];
    cell.downLoadBtu.tag = 3000+indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)getMore:(UIButton*)sender
{
    [self.activityView startAnimating];
    [self.wall requestMoreOffersAppData];
    
}

#pragma mark  - 有米广告的代理方法
- (void)didReceiveOffersAppData:(YouMiWall *)adWall offersApp:(NSArray *)apps
{
    //self.youMiAppArray = apps;
    self.youMiAppArray = [[[NSMutableArray alloc]initWithArray:apps]autorelease];
    [self.youMiTableView reloadData];
}

- (void)didReceiveMoreOffersAppData:(YouMiWall *)adWall offersApp:(NSArray *)apps
{
    [self.youMiAppArray addObjectsFromArray:apps];
    [self.youMiTableView reloadData];
    [self.activityView stopAnimating];
}

- (void)didFailToReceiveOffersAppData:(YouMiWall *)adWall error:(NSError *)error
{
    
}

- (void)didFailToReceiveMoreOffersAppData:(YouMiWall *)adWall error:(NSError *)error
{
    
}

- (void)didReceiveOffers:(YouMiWall *)adWall
{
    
}

- (void)didFailToReceiveOffers:(YouMiWall *)adWall error:(NSError *)error
{
    
}

#pragma mark  - Screen View Notification Methods

- (void)didShowWallView:(YouMiWall *)adWall
{
    
}

- (void)didDismissWallView:(YouMiWall *)adWall
{
    
}

#pragma mark  - button点击方法
-(void)pushToItunes:(UIButton*)sender
{
    YouMiWallAppModel *youMiModel = [self.youMiAppArray objectAtIndex:sender.tag-3000];
    [self.wall userInstallOffersApp:youMiModel];
}

#pragma mark  - 界面的配置
-(void)makeYouMi
{
    
    [YouMiConfig launchWithAppID:@"d842d978580d8711" appSecret:@"ec4c15ee4c6ed6d9"];
    [YouMiConfig setIsTesting:NO];
    [YouMiConfig setUseInAppStore:YES];
    self.wall = [[[YouMiWall alloc]init]autorelease];
    self.wall.delegate = self;
    [self.wall requestOffersAppData:NO];
    
    
}
@end
