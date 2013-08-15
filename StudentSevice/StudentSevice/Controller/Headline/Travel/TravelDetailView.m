//
//  TravelDetailView.m
//  StudentSevice
//
//  Created by victor on 13-3-27.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "TravelDetailView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TravelViewController.h"
@implementation TravelDetailView
@synthesize imageView = _imageView;
@synthesize urlStr = _urlStr;
@synthesize textView1 = _textView1;

-(void)dealloc
{
    self.imageView = nil;
    self.urlStr = nil;
    self.textView1 = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        
        //设置半透明黑色背景
        UIView *backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        backgroundView.backgroundColor =[UIColor blackColor];
        backgroundView.alpha = 0.8f;
        //添加手势
        UITapGestureRecognizer *tapGRer = nil;
        tapGRer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapGRer.numberOfTapsRequired = 1;
        [backgroundView addGestureRecognizer:tapGRer];
        [tapGRer release];
        [self addSubview:backgroundView];
        [backgroundView release];
        
        //添加底部黑色条
        UIView *toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, 320, 44)];
        toolBar.backgroundColor = [UIColor grayColor];
        [self addSubview:toolBar];
        [toolBar release];
        
        //添加底部button
        UIButton * largeImage = [UIButton buttonWithType:UIButtonTypeCustom];
        largeImage.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height-44, 100, 45);
        [largeImage setImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
        [largeImage addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:largeImage];
        largeImage.alpha = 1.0f;
        
        //添加图片的scrollView
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, screen_width, 150)];
        scrollView.backgroundColor = [UIColor clearColor];
        self.imageView = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 280, 120)]autorelease];
        [scrollView addSubview:self.imageView];
        [self addSubview:scrollView];
        [scrollView release];
        
        //添加底部介绍
        self.textView1 = [[[UITextView alloc]initWithFrame:CGRectMake(0, 151, 320, screen_height-44-150)]autorelease];
        self.textView1.backgroundColor = [UIColor clearColor];
        self.textView1.textColor = [UIColor whiteColor];
        self.textView1.font = TEXT_FONT;
        self.textView1.editable = NO;
        [self addSubview:self.textView1];
        
    }
    return self;
}

-(void)tap:(id)aGRer
{
    [self removeFromSuperview];
}

@end
