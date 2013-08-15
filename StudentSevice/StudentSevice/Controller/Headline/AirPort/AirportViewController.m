//
//  AirportViewController.m
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "AirportViewController.h"
#import "SSManager.h"
#import "HeadLineCell.h"
#import "SS_airport.h"
#import "AppDelegate.h"
#import "AirPortCell.h"

@implementation AirportViewController
@synthesize dataArr = _dataArr;
@synthesize number = _number;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //
        //请求数据
        [self loadData];
    }
    return self;
}

#pragma mark - 生命周期

-(void)loadView
{
    [super loadView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    //设置tableview的背景
    UIImage *backgroundImage = [UIImage imageNamed:@"klia"];
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:backgroundImage];
    self.tableView.backgroundView= backgroundImageView;

    self.tableView.separatorColor = [UIColor clearColor];//分割线的颜色
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    self.dataArr = nil;
    self.number = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark private method

//数据请求
-(void)loadData
{
    //数据的请求
    SSManager *manager = [[SSManager alloc]init];
    [manager setFinishBlock:^(id result) {
        self.dataArr = result;
        [self.tableView reloadData];
    }];
    [manager readAirPortInfo];
}


#pragma mark -
#pragma mark Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return 40.0f;
    }
    else
    {
        SS_airport *air = [self.dataArr objectAtIndex:indexPath.row -1];
        return air.height_cell;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count + 1;
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
        HeadLineCell *cell = [tableView dequeueReusableCellWithIdentifier:Celldentifier];
        if (cell == nil)
        {
            cell = [[[HeadLineCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celldentifier]autorelease];
        }
        cell.detailLabel.delegate = self;
        SS_airport *air = [self.dataArr objectAtIndex:indexPath.row-1];
        [cell setAirPort:air];
        
        return cell;

    }
}


#pragma mark core data delegate
//为所有的链接添加点击
-(UIColor *)colorForLink:(NSTextCheckingResult *)linkInfo underlineStyle:(int32_t *)underlineStyle
{
    //设置链接颜色
    return [UIColor redColor];
}

-(BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    //点击的链接的位置
    NSRange range = linkInfo.range;
    //获取整个字符串的信息
    NSString * text = attributedLabel.attributedText.string;
    //用位置信息，找到点击的 文字信息
    NSString * regexString = [text substringWithRange:range];
    
    //根据不同的前缀进行不同的操作
    self.number = [regexString substringFromIndex:0];
    
    UIAlertView *myalert1 = [[UIAlertView alloc] initWithTitle:@"操作" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打电话",@"发送短信",nil];
    myalert1.delegate = self;
    [myalert1 show];
    [myalert1 release];

    //如果返回yes 打开系统的浏览器
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"tel://",self.number]]];
    }
    if (buttonIndex == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"sms://",self.number]]];
    }
}
@end
