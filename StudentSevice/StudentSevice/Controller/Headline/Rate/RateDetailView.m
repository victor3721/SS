//
//  RateDetailView.m
//  StudentSevice
//
//  Created by victor on 13-3-27.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "RateDetailView.h"

@implementation RateDetailView
@synthesize urlStr = _urlStr;
@synthesize imageView = _imageView;
@synthesize textView1 = _textView1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        
        UIView *backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        backgroundView.backgroundColor =[UIColor blackColor];
        backgroundView.alpha = 0.8f;
        
        UITapGestureRecognizer *tapGRer = nil;
        tapGRer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapGRer.numberOfTapsRequired = 1;
        [backgroundView addGestureRecognizer:tapGRer];
        [tapGRer release];
        
        [self addSubview:backgroundView];
        [backgroundView release];
        
        UIView *toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, 320, 44)];
        toolBar.backgroundColor = [UIColor blackColor];
        [self addSubview:toolBar];
        [toolBar release];
        
        UIButton * largeImage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        largeImage.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height-44, 100, 30);
        [largeImage setTitle:@"largetImage" forState:UIControlStateNormal];
        [largeImage addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:largeImage];
        largeImage.alpha = 1.0f;
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, screen_width, 150)];
        scrollView.backgroundColor = [UIColor clearColor];
        self.imageView = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 280, 120)]autorelease];
        [scrollView addSubview:self.imageView];
        [self addSubview:scrollView];
        [scrollView release];
        
        self.textView1 = [[[UITextView alloc]initWithFrame:CGRectMake(0, 151, 320, screen_height-44-150)]autorelease];
        self.textView1.backgroundColor = [UIColor clearColor];
        self.textView1.textColor = [UIColor whiteColor];
        [self addSubview:self.textView1];
        
    }
    return self;
}

-(void)tap:(id)aGRer
{
    [self removeFromSuperview];
}

-(void)dealloc
{
    self.urlStr = nil;
    self.imageView = nil;
    self.textView1 = nil;
    [super dealloc];
}

@end
