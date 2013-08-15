//
//  MenuView.m
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "MenuView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "YouMiWall.h"
#import "YouMiWallBanner.h"
#import <QuartzCore/QuartzCore.h>
#import "YouMiWallAppModel.h"
#import "ADsCell.h"

#define CELLWIDTH 280.0
#define CELLHEADERHIGHT 30.0
#define CELLHIGHT 45.0
#define HEADERLABFOUNT @"Helvetica-Light"
@interface MenuView ()
{
    NSArray *_freshNewsArr;
    NSArray *_functionArr;
    NSArray *_toolArr;
    
    
    NSMutableArray*_youMiAppArray;
    YouMiWall*_wall;

}

@property(nonatomic,retain)NSMutableArray*youMiAppArray;
@property(nonatomic,retain)YouMiWall*wall;
@property(nonatomic,retain)NSArray *functionArr;
@property(nonatomic,retain)NSArray *freshNewsArr;
@property(nonatomic,retain)NSArray *toolArr;
@end


@implementation MenuView
@synthesize functionArr = _functionArr;
@synthesize user = _user;
@synthesize freshNewsArr = _freshNewsArr;
@synthesize toolArr = _toolArr;
@synthesize youMiAppArray = _youMiAppArray;
@synthesize wall = _wall;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

}

- (void)dealloc
{
    self.functionArr = nil;
    self.user = nil;
    self.freshNewsArr = nil;
    self.toolArr = nil;
    self.youMiAppArray = nil;
    self.wall = nil;
    
    [super dealloc];
}


#pragma mark 
#pragma mark - private method

//
//信息section下面的cell
-(UITableViewCell *)loadfuncationCell:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell.textLabel.text = [self.functionArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]]];
    image.frame = CGRectMake(0, 5, 10, 35);
    cell.textLabel.font = [UIFont fontWithName:HEADERLABFOUNT size:20];
    [cell addSubview:image];
    [image release];
    return cell;
}

//
//段子section下面的cell
-(UITableViewCell *)loadfreshNewsCell:(NSIndexPath*)indexPath
{
    
    UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell.textLabel.text = [self.freshNewsArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]]];
    image.frame = CGRectMake(0, 5, 10, 35);
    cell.textLabel.font = [UIFont fontWithName:HEADERLABFOUNT size:20];
    [cell addSubview:image];
    [image release];
    return cell;
    
}

//
//有米广告section的cell
-(UITableViewCell*)loadYouMiAPP:(NSIndexPath*)indexPath
{
    ADsCell *cell = [[[ADsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    YouMiWallAppModel *youMiModel = [self.youMiAppArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = youMiModel.name;
    cell.detailLabel.text = youMiModel.desc;
    [cell.picView setImageWithURL:[NSURL URLWithString:youMiModel.smallIconURL]];
    [cell.downLoadBtu addTarget:self action:@selector(pushToItunes:) forControlEvents:UIControlEventTouchUpInside];
    cell.downLoadBtu.tag = 3000+indexPath.row;
    return cell;
}


//
//段子section下面的cell
-(UITableViewCell *)loadToolsCell:(NSIndexPath*)indexPath
{
    
    UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell.textLabel.text = [self.toolArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]]];
    image.frame = CGRectMake(0, 5, 10, 35);
    cell.textLabel.font = [UIFont fontWithName:HEADERLABFOUNT size:20];
    [cell addSubview:image];
    [image release];
    return cell;
    
}


#pragma mark  - button action
-(void)pushToItunes:(UIButton*)sender
{
    YouMiWallAppModel *youMiModel = [self.youMiAppArray objectAtIndex:sender.tag-3000];
    [self.wall userInstallOffersApp:youMiModel];
}


#pragma mark 
#pragma mark - public method

//
//刷新数据
-(void)loadData
{
    //
    //基本属性
    self.backgroundView = [[[UIView alloc]initWithFrame:self.bounds]autorelease];
    self.backgroundColor = [UIColor colorWithRed:24.0/255 green:24.0/255 blue:26.0/255 alpha:1.0];
    [self setSeparatorColor:[UIColor blackColor]];
    self.functionArr = [NSArray arrayWithObjects:@"  旅游",@"  机场接送",@"  二手交易",@"  房屋出租",@"  汇率查询",@"  吃喝玩乐",@"  IIS", nil];
    self.freshNewsArr = [NSArray arrayWithObject:@"  小段子"];
    self.toolArr = [NSArray arrayWithObjects:@"  设置",@"  反馈",@"  给应用打分", nil];
    self.delegate= self;
    self.dataSource = self;
    [self reloadData];

    
    //
    //配置有米广告的东西
    [YouMiConfig launchWithAppID:@"d842d978580d8711" appSecret:@"ec4c15ee4c6ed6d9"];
    [YouMiConfig setIsTesting:NO];
    [YouMiConfig setUseInAppStore:YES];
    self.wall = [[[YouMiWall alloc]init]autorelease];
    self.wall.delegate = self;
    [self.wall requestOffersAppData:NO];
}


#pragma mark
#pragma mark - tabelVIewDelgate


#pragma mark - tableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.functionArr.count;
            break;
        case 1:
            return self.freshNewsArr.count;
            break;
        case 2:
            return self.youMiAppArray.count;
            break;
        case 3:
            return self.toolArr.count;
            break;
        default:
            break;
    }
    return self.functionArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, CELLWIDTH, CELLHEADERHIGHT)]autorelease];
    UILabel *titleLabel = [[[UILabel alloc]initWithFrame:view.frame]autorelease];
    [view addSubview:titleLabel];
    
    view.backgroundColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:HEADERLABFOUNT size:16];
    titleLabel.textColor = [UIColor whiteColor];
    
    switch (section) {
        case 0:
            titleLabel.text = @"    信息";
            break;
        case 1:
            titleLabel.text = @"    段子";
            break;
        case 2:
            titleLabel.text = @"    免费应用";
            break;
        case 3:
            titleLabel.text = @"    工具";
            break;
        default:
            break;
    }
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [self loadfuncationCell:indexPath];
            break;
        case 1:
            return [self loadfreshNewsCell:indexPath];
            break;
        case 2:
            return [self loadYouMiAPP:indexPath];
            break;
        case 3:
            return [self loadToolsCell:indexPath];
            break;
        default:
            return nil;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeTitleNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:indexPath,@"indexPath", nil]];
    
}


#pragma mark youmidelegate
- (void)didReceiveOffersAppData:(YouMiWall *)adWall offersApp:(NSArray *)apps
{
    self.youMiAppArray = [[[NSMutableArray alloc]initWithArray:apps]autorelease];
    [self reloadData];
}


























//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)]autorelease];
//    UIImageView *photo = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 40, 40)]autorelease];
//    UIImageView *photoCorner = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 40, 40)]autorelease];
//    photoCorner.image = [UIImage imageNamed:@"user_corner"];
//    
//    view.backgroundColor = [UIColor blackColor];
//    UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(60, 20, 150, 50)]autorelease];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor whiteColor];
//
//    
//    [view addSubview:label];
//    [view addSubview:photo];
//    [view addSubview:photoCorner];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString*imageUrl = [defaults objectForKey:@"userImage"];
//    NSString*userName = [defaults objectForKey:@"screenName"];
//    
//    if (userName) {
//        label.text = userName;
//        [photo setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:photoPlaceHolder]];
//    }
//    else{
//        photo.image = [UIImage imageNamed:photoPlaceHolder];
//        label.text = @"登陆微博获得用户名";
//    }
//    
//    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, CELLWIDTH, CELLHEADERHIGHT)]autorelease];
//    UILabel *titleLabel = [[[UILabel alloc]initWithFrame:view.frame]autorelease];
//    [view addSubview:titleLabel];
//    return view;
//}


@end
