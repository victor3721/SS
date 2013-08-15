//
//  SecondHandViewController.m
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//




#import "SecondHandViewController.h"



@interface SecondHandViewController ()
{
    
    NSMutableArray *_dataArr;
    ODRefreshControl *_refresh;
    MBProgressHUD *HUD;
    NSString*_number;
    
}
@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)ODRefreshControl *refresh;
@property(nonatomic,copy)NSString*number;



@end

@implementation SecondHandViewController
@synthesize dataArr = _dataArr;
@synthesize refresh = _refresh;
@synthesize number = _number;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

        //请求数据
        [self makeData];
    }
    return self;
}

#pragma mark - 生命周期

-(void)dealloc
{
    self.dataArr =nil;
    self.refresh = nil;
    self.number = nil;
    [super dealloc];
}

-(void)loadView
{
    [super loadView];
    
    //
    //设置tableview的背景
    UIImage *backgroundImage = [UIImage imageNamed:@"klia"];
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:backgroundImage];
    self.tableView.backgroundView= backgroundImageView;
    
    //
    //分割线的颜色
    self.tableView.separatorColor = [UIColor clearColor];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    //初始话刷新的界面
    self.refresh = [[[ODRefreshControl alloc]initInScrollView:self.tableView]autorelease];
    [self.refresh addTarget:self action:@selector(getRefresh) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated
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
        [self.refresh endRefreshing];
        [HUD hide:YES];
    }];
    [manager readSecondHandInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        
    }
    
    
}

#pragma mark -
#pragma mark private method
-(void)makeData
{
    //数据的请求
    SSManager *manager = [[SSManager alloc]init];
    [manager setFinishBlock:^(id result) {
        self.dataArr = result;
        [self.tableView reloadData];
    }];
    [manager readSecondHandInfo];
}



-(void)getRefresh
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
        [self.refresh endRefreshing];
        [HUD hide:YES];
    }];
    [manager readSecondHandInfo];
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
        SS_secondHand *secondHand = [self.dataArr objectAtIndex:indexPath.row-1];
        return secondHand.height_cell;
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
        HeadLineCell *cell = [tableView dequeueReusableCellWithIdentifier:Celldentifier];
        if (cell == nil)
        {
            cell = [[[HeadLineCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celldentifier]autorelease];
        }
        cell.detailLabel.delegate = self;
        SS_secondHand *secondHand = [self.dataArr objectAtIndex:indexPath.row-1];
        [cell setSecondHand:secondHand];
        return cell;
    }

}



#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    //点进去可以查看图片等其他东西
}

#pragma mark coretext delegate
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
    NSLog(@"推出用户界面  %@",self.number);
    
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

#pragma mark huud delegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}


@end
