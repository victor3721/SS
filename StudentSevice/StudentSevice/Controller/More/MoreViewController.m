//
//  MoreViewController.m
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutController.h"
#import <SDWebImage/SDImageCache.h>

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UITableView *_tableview;//配置tableView
    
    MBProgressHUD *_HUD;//提示菊花，是菊花奥

}

@property(nonatomic,retain)UITableView *tableview;
@property(nonatomic,retain)MBProgressHUD *HUD;

@end


@implementation MoreViewController
@synthesize tableview = _tableview;

#pragma mark -
#pragma mark life style
-(void)loadView
{
    [super loadView];
    
    //
    //设置title
    self.navigationItem.title = @"更多";
    

    //
    //添加tableView
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-20-44) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tableview];
    
    //
    //设置tableview的背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:_tableview.frame];
    backgroundView.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    _tableview.backgroundView = backgroundView;
    [backgroundView release];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)dealloc
{
    
    self.tableview = nil;
    
    [super dealloc];
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

#pragma mark -
#pragma mark public method

#pragma mark -
#pragma mark private method


//
//判断缓存文件的大小
-(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

#pragma mark button action

//
//清理缓存文件的事件
-(void)clean:(UIButton*)sender
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	_HUD.mode = MBProgressHUDModeCustomView;
	_HUD.delegate = self;
	_HUD.labelText = @"清理完毕";
	[_HUD show:YES];
	[_HUD hide:YES afterDelay:3];
    [[SDImageCache sharedImageCache] clearDisk];
}


#pragma mark -
#pragma mark tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"weibocell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"清除系统缓存";
            NSString *homeDic = NSHomeDirectory();
            NSString *libDic = [homeDic stringByAppendingPathComponent:@"Library"];
            NSString *filePath = [libDic stringByAppendingPathComponent:@"Caches"];
            
            NSString *str = [NSString stringWithFormat:@"%lld",[self fileSizeAtPath:filePath]/20];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(230, 5, 80, 34)];
            label.backgroundColor = [UIColor clearColor];
            label.text = [NSString stringWithFormat:@"%@%@",str,@"MB"];
            [label release];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"cleanButton"] forState:UIControlStateNormal];
            button.frame = CGRectMake(210, 6, 80, 34);
            [button addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            break;
        case 1:
            cell.textLabel.text = @"关于我们";
            break;
        case 2:
            cell.textLabel.text = @"微博登陆设置";
            break;
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        AboutController*about = [[AboutController alloc]init];
        [self.navigationController pushViewController:about animated:YES];
    }
}


#pragma mark -
#pragma mark MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[_HUD removeFromSuperview];
	[_HUD release];
	_HUD = nil;
}



@end
