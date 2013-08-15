//
//  AboutController.m
//  StudentSevice
//
//  Created by victor on 13-3-31.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

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
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"关于我们";
    
    UIView*view1 = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 280, 100)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.5;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 80, 80)];
    imageView.image = [UIImage imageNamed:@"icon"];
    
    UILabel *emailLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 35, 240, 70)];
    emailLab.textColor = [UIColor whiteColor];
    emailLab.text = @"wismart.ss@gmail.com";
    emailLab.backgroundColor = [UIColor clearColor];
    
    UIView*view2 = [[UIView alloc]initWithFrame:CGRectMake(20, 130, 280, 250)];
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.5;
    
    UILabel*titleLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, 270, 30)];
    titleLab.text = @"关于我们";
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = [UIColor whiteColor];
    
    UITextView* textview = [[UITextView alloc]initWithFrame:CGRectMake(35, 170, 250,210)];
    textview.font = [UIFont fontWithName:@"Arial" size:16];
    textview.text = @"本软件由wismart团队研发为马来西亚学生提供手机平台的信息交互。我们竭诚为大家提供更好的服务，如果在使用中有任何的建议请联系我们，感谢你的使用.Copyright:WISMART";
    textview.editable = NO;
    textview.textColor = [UIColor whiteColor];
    textview.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:view1];
    [self.view addSubview:imageView];
    [self.view addSubview:emailLab];
    [self.view addSubview:view2];
    [self.view addSubview:titleLab];
    [self.view addSubview:textview];
    [view1 release];
    [view2 release];
    [emailLab release];
    [titleLab release];
    [textview release];
    [textview release];
    [self changeBackButton];
}


-(void)changeBackButton
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"navigationbarback"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"navigationbarback"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton release];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
}
-(void)leftAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
