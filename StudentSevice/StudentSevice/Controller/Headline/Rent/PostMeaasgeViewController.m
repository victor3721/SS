//
//  PostMeaasgeViewController.m
//  StudentSevice
//
//  Created by victor on 13-3-28.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "PostMeaasgeViewController.h"
#import "SSManager.h"

@interface PostMeaasgeViewController ()

@end

@implementation PostMeaasgeViewController
@synthesize indexPath = _indexPath;
@synthesize emoticonName = _emoticonName;
@synthesize postViewTextView = _postViewTextView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    self.postViewTextView = nil;
    //self.emoticonViewController  = nil;
    self.emoticonName = nil;
    self.postViewTextView = nil;
    [super dealloc];
}

#pragma mark -Life Cycle-

-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-20)]autorelease];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    [self navigationBar];
    [self textView];
    [self comment];
    [self toolBar];
    
    self.postViewTextView.delegate = self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //textview响应第一响应者
    [self.postViewTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -Configuration Inrerface-

//配置navigationBar
-(void)navigationBar
{
    //初始化navigationBar
    UINavigationBar *navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:navigation_background]]];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(0, 0, 100, 30);
    nameLabel.center = navigationBar.center;
    nameLabel.text = @"发布消息";
    nameLabel.font = [UIFont fontWithName:@"Arial" size:20];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor =[UIColor whiteColor];
    [navigationBar addSubview:nameLabel];
    [nameLabel release];
    
    //在navigationBar上添加cancle按钮
    UIButton*cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(5, 7, 70, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"postButton"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:cancelButton];
    
    //在navigationBar添加send按钮
    UIButton *senderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [senderButton setTitle:@"发送" forState:UIControlStateNormal];
    senderButton.frame = CGRectMake(320-5-70, 7, 70, 30);
    [senderButton setBackgroundImage:[UIImage imageNamed:@"postButton"] forState:UIControlStateNormal];
    [senderButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:senderButton];
    
    //将navigationBar添加到self.view上面
    [self.view addSubview:navigationBar];
    [navigationBar release];//释放navigationBar
}

//配置textview
-(void)textView
{
    self.postViewTextView =[[[UITextView alloc]initWithFrame:CGRectMake(0, 45, 320, [UIScreen mainScreen].bounds.size.height - 226)]autorelease];
    self.postViewTextView.backgroundColor = [UIColor whiteColor];
    self.postViewTextView.font = [UIFont fontWithName:@"Arial" size:18];
    [self.view addSubview:self.postViewTextView];
}
//配置键盘后面背景
-(void)comment
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    imageView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 367, 320, 367);
    [self.view addSubview:imageView];
    [imageView release];
}

//配置工具条
-(void)toolBar
{
    //添加toolbar和toolbarButton
    UIView *toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    toolBarView.backgroundColor = [UIColor whiteColor];
    
    UIImageView* shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"postToolBar"]];
    shadowImageView.frame = CGRectMake(0, 0, 320, 30);
    [toolBarView addSubview:shadowImageView];
    [shadowImageView release];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:toolBarView.frame];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"电话书写格式（联系方式：电话号码）";
    [toolBarView addSubview:lab];
    [lab release];
    
    //把toolBar和palce按钮田间到textview上，当触发textview的时候自动为键盘上面加view
    self.postViewTextView.inputAccessoryView = toolBarView;
    [toolBarView release];
    
}


#pragma mark -Button click method-

-(void)cancle:(UIButton*)sender
{
    UIAlertView *myalert1 = [[UIAlertView alloc] initWithTitle:@"警告" message:@"取消后消息将丢失" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    myalert1.delegate = self;
    [myalert1 show];
    [myalert1 release];
    
}

-(void)lost
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)send:(UIButton*)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString*userName = [defaults objectForKey:@"screenName"];
    if (self.postViewTextView.text.length<20||userName == nil)
    {
        UIAlertView *myalert1 = [[UIAlertView alloc] initWithTitle:@"警告" message:@"信息不准确或者你没有登陆微博" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        [myalert1 show];
        [myalert1 release];
    }
    else
    {
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        [dateformatter release];
        
        NSMutableDictionary *paraDic =[NSMutableDictionary dictionary];
        [paraDic setValue:userName forKey:@"NAME"];
        [paraDic setValue:self.postViewTextView.text forKey:@"DETAIL"];
        [paraDic setValue:locationString forKey:@"DATE"];
        
        if (self.indexPath.row == 2) {
            UIApplication *application = [UIApplication sharedApplication];
            HUD = [[MBProgressHUD alloc] initWithView:[application.windows objectAtIndex:1]];
            [[application.windows objectAtIndex:1] addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
            [HUD hide:YES afterDelay:10];
            
            SSManager *sinaManager = [[SSManager alloc]init];
            [sinaManager setFinishBlock:^(id result) {
                [HUD hide:YES];
                [self lost];
            }];
            [sinaManager postSecondInfoParams:paraDic];
            [sinaManager release];
        }
        else
        {
            UIApplication *application = [UIApplication sharedApplication];
            HUD = [[MBProgressHUD alloc] initWithView:[application.windows objectAtIndex:1]];
            [[application.windows objectAtIndex:1] addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
            [HUD hide:YES afterDelay:10];

            
            SSManager *sinaManager = [[SSManager alloc]init];
            [sinaManager setFinishBlock:^(id result) {
                [HUD hide:YES];
                [self lost];
            }];
            [sinaManager postRentInfoParams:paraDic];
            [sinaManager release];
        }
        
    }
}

-(void)changeToEmot:(UIButton*)sender
{
}

-(void)chage
{
    [self.postViewTextView setText:em];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}


- (void)myTask {
	// Do something usefull in here instead of sleeping ...
	sleep(3);
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}
@end
