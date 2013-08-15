//
//  IISViewController.m
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "IISViewController.h"
#import "IISwebview.h"

@interface IISViewController ()
{
//    UIWebView*_webview;
    NSURL *_url;
    MBProgressHUD *HUD;
    IISwebview *_webview;
}
@property(nonatomic,strong)IISwebview*webview;
@property(nonatomic,strong)NSURL *url;
@end

@implementation IISViewController
@synthesize webview = _webview;
@synthesize url = _url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 生命周期



-(void)loadView
{
    [super loadView];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.webview = [[[IISwebview alloc]initWithFrame:CGRectMake(0, 40.0, screen_width, screen_height-40)]autorelease];
    self.webview.IISWebView.delegate = self;
    [self.webview.backBtu addTarget:self action:@selector(gotoBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.webview.stopBtu addTarget:self action:@selector(gotoStop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.webview];
    
    
//    //配置webview
//	self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-44-39-20)];
//    self.url =[NSURL URLWithString:IIS_url];
//    NSURLRequest *request =[NSURLRequest requestWithURL:self.url];
//    [self.webview loadRequest:request];
//    self.webview.delegate = self;
//    self.webview.scalesPageToFit = YES;
//    [self.view addSubview:self.webview];
//    
//    //
//    //配置后退button
//    UIButton*backBtu = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtu.frame = CGRectMake(10, screen_height-20-45-44-39, 44, 44);
//    [backBtu setImage:[UIImage imageNamed:@"webview_backbutton"] forState:UIControlStateNormal];
//    [backBtu addTarget:self action:@selector(gotoBack:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBtu];
//    
//    //
//    //配置停止button
//    UIButton*stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    stopButton.frame = CGRectMake(screen_width-10-44, screen_height-20-45-44-39, 44, 44);
//    [stopButton setImage:[UIImage imageNamed:@"webview_stopbutton"] forState:UIControlStateNormal];
//    [stopButton addTarget:self action:@selector(gotoStop:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:stopButton];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        //
        //当界面不在显示的时候释放掉内存
    }
    
    
}

-(void)dealloc
{
   self.webview = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark private method

-(void)gotoBack:(id)sender
{
    if (self.webview.IISWebView.canGoBack) {
        [self.webview.IISWebView goBack];
    }

}

-(void)gotoStop:(UIButton*)sender
{
    [self.webview.IISWebView stopLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


#pragma mark -
#pragma mark webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}




@end
