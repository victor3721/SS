//
//  RateViewController.m
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "RateViewController.h"
#import "SSManager.h"
#import "SS_rate.h"

@interface RateViewController ()
{
    NSMutableArray *_dataArr;
}
@property(nonatomic,retain)NSMutableArray *dataArr;

-(void)loadData;
@end

@implementation RateViewController
@synthesize dataArr = _dataArr;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
     //   [self loadData];
    }
    return self;
}

#pragma mark - 生命周期


-(void)loadView
{
    [super loadView];
    //
    //设置tableview的背景
    UIImage *backgroundImage = [UIImage imageNamed:@"rate"];
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:backgroundImage];
    self.tableView.backgroundView= backgroundImageView;
    
    //
    //分割线的颜色
    self.tableView.separatorColor = [UIColor clearColor];
    //
    //隐藏navigationBar
    self.navigationController.navigationBarHidden = YES;
    [self loadData];

    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil) {
        
    }

}

-(void)dealloc
{
    self.dataArr =nil;
    [super dealloc];
}


#pragma mark -
#pragma mark private method
-(void)loadData
{
    //数据的请求
    SSManager *manager = [[SSManager alloc]init];
    [manager setFinishBlock:^(id result) {
        [manager setFinishBlock:^(id result) {
            self.dataArr = result;
            [self.tableView reloadData];
        }];
        [manager readRateInfo];
    }];
    [manager readRateComInfo];
}


#pragma mark -
#pragma mark Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return 40.0;
    }
    else
    {
        return 200;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *Celldentifier= @"CellNUll";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Celldentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celldentifier]autorelease];
        }
        return cell;
    }
    else
    {
        static NSString *Celldentifier= @"Cell";
        RateCell *cell = [tableView dequeueReusableCellWithIdentifier:Celldentifier];
        if (cell == nil)
        {
            cell = [[[RateCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celldentifier]autorelease];
        }
        
        NSMutableArray*comArr = [self.dataArr objectAtIndex:indexPath.row-1];
        SS_rate *rate = [comArr objectAtIndex:0];
//        cell.titleLabel.text = rate.NAME;
//        cell.dateLabel.text = rate.DATE;
//        cell.rateLabel.text = rate.RATE;
//        [cell.more removeFromSuperview];
        return cell;
    }
}


#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，你还要等一下啊，正在建设中" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//    [myalert show];
//    [myalert release];
}


@end
