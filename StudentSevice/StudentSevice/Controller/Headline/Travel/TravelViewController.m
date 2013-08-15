//
//  TravelViewController.m
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "TravelViewController.h"
#import "TravelCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"
@interface TravelViewController ()
{
    TravelDetailView*_detailView;
}


@property(nonatomic,retain)TravelDetailView*detailView;

@end

@implementation TravelViewController
@synthesize dataArr = _dataArr;
@synthesize detailView = _detailView;
@synthesize number = _number;


#pragma mark - 生命周期

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        //请求数据
        [self makeData];
        
    }
    return self;
}


-(void)dealloc
{
    self.dataArr = nil;
    self.detailView = nil;
    self.number = nil;
    [super dealloc];
}

-(void)loadView
{
    [super loadView];
    
    self.navigationItem.title = @"旅游";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //
    //设置tableview的背景
    UIImage *backgroundImage = [UIImage imageNamed:@"kl"];
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:backgroundImage];
    self.tableView.backgroundView= backgroundImageView;
    
    //
    //设置分割线的颜色为
    self.tableView.separatorColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - tableview的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
    }
    else
    {
        SS_travel *travel = [self.dataArr objectAtIndex:indexPath.row-1];
        return travel.height_cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count+1;
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
        TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:Celldentifier];
        if (cell == nil)
        {
            cell = [[[TravelCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celldentifier]autorelease];
        }
        cell.detailLabel.delegate = self;
        SS_travel *travel = [self.dataArr objectAtIndex:indexPath.row-1];
        [cell setTravel:travel];
        
        return cell;
        
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当点击cell的时候初始化travelDetailView 
    SS_travel *travel = [self.dataArr objectAtIndex:indexPath.row];
    self.detailView = [[[TravelDetailView alloc]initWithFrame:CGRectMake(0, -screen_height, screen_width, screen_height)]autorelease];
    UIActivityIndicatorView *activityView=[[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(120, 45, 30, 30)]autorelease];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityView.hidesWhenStopped = YES;
    [activityView startAnimating];
    [self.detailView.imageView addSubview:activityView];
    [self.detailView.imageView setImageWithURL:[NSURL URLWithString:travel.PICURL]success:^(UIImage *image, BOOL cached)
     {
         [activityView stopAnimating];
    } failure:^(NSError *error)
     {
        
    }];
    self.detailView.textView1.text =    [NSString stringWithFormat:@"%@%@%@",travel.INTRODUCE,@"\n\n",travel.DETAIL];
    
    //travelDetailView出现的动画
    [[UIApplication sharedApplication].keyWindow addSubview:self.detailView];
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    self.detailView.frame = CGRectMake(0, 0, screen_width, screen_height);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}

#pragma mark - 数据请求
-(void)makeData
{
    //数据的请求
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
    
    SSManager *manager = [[SSManager alloc]init];
    [manager setFinishBlock:^(id result) {
        self.dataArr = result;
        [self.tableView reloadData];
        [HUD hide:YES];
    }];
    [manager readTravelInfo];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

#pragma mark - Click Link
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
        NSLog(@"%@",self.number);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"sms://",self.number]]];
    }
}
@end
