//
//  FoodViewController.m
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "FoodViewController.h"

@interface FoodViewController ()

@end

@implementation FoodViewController
@synthesize dataArr = _dataArr;
@synthesize number = _number;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

#pragma mark - 生命周期

-(void)loadView
{
    [super loadView];
    
    //
    //tableview的背景颜色
    UIImage *backgroundImage = [UIImage imageNamed:@"rate"];
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:backgroundImage];
    self.tableView.backgroundView= backgroundImageView;
    
    //
    //分割线的颜色
    self.tableView.separatorColor = [UIColor clearColor];
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
    self.number = _number;
    [super dealloc];
}

#pragma mark -
#pragma mark private method
-(void)loadData
{
    //数据的请求
    SSManager *manager = [[SSManager alloc]init];
    [manager setFinishBlock:^(id result) {
        self.dataArr = result;
        [self.tableView reloadData];
    }];
    [manager readFoodInfo];
}


#pragma mark -
#pragma mark Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SS_food *food = [self.dataArr objectAtIndex:indexPath.row];
    return food.height_cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Celldentifier= @"Cell";
    TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:Celldentifier];
    if (cell == nil)
    {
        cell = [[[TravelCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celldentifier]autorelease];
    }
    cell.detailLabel.delegate = self;
    SS_food *food = [self.dataArr objectAtIndex:indexPath.row];
    [cell setFood:food];
    [cell.more removeFromSuperview];
    return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，你还要等一下啊，正在建设中" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//    [myalert show];
//    [myalert release];
}




#pragma mark core text delegate
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
@end
