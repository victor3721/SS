//
//  CustomImageView.m
//  StudentSevice
//
//  Created by Liu on 13-3-22.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "CustomImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation CustomImageView

- (id)initWithFrame:(CGRect)frame WithImageStr:(NSString *)str
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[[UIView alloc]initWithFrame:self.bounds]autorelease];
        [self addSubview:backView];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 0, 260, screen_height-20-44-39)];
        if ([str hasSuffix:@"jpg"]||[str hasSuffix:@"png"]) {
            imageView = [[[UIImageView alloc]init]autorelease];
            HUD = [[MBProgressHUD alloc] initWithView:self];
            [self addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
            [imageView setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:PlaceHolder_image]success:^(UIImage *image, BOOL cached)
            {
                UIImage * scaleImage = [self scaleImage:image];
                imageView.frame = CGRectMake(0,0, scaleImage.size.width, scaleImage.size.height);
                if (scaleImage.size.height<screen_height-20-44-39) {
                    imageView.center = CGPointMake(130, (screen_height-20-44-39)/2);
                }
                scrollView.contentSize = CGSizeMake(260, scaleImage.size.height);
                [scrollView addSubview:imageView];
                [self addSubview:scrollView];
                [HUD hide:YES];
            } failure:^(NSError *error)
            {
                
            }];
            
        }

        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)]autorelease];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)loadImageWithStr:(NSString *)str
{
    imageWebView = [[UIWebView alloc]init];
    imageWebView.delegate = self;
    HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageWebView.frame = CGRectMake(0, 0,image.size.width, image.size.height);
            imageWebView.center = self.center;
            [imageWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        });
    });
    [self addSubview:imageWebView];
    [imageWebView release];
}
-(void)tapAction
{
    HUD = nil;
    [imageWebView stopLoading];
    imageWebView = nil;
    imageView = nil;
    [self removeFromSuperview];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    webView = nil;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [HUD hide:YES];
}

- (UIImage *)scaleImage:(UIImage *)image
{
    float width = image.size.width;
    float height = image.size.height;
    float scaleRange  = 260/width;
    if (image.size.width>260) {
        CGSize size = CGSizeMake(260, height*scaleRange);
        //绘制这个大小的图片
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0,0, size.width, size.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSLog(@"scaledImage=====w==%f\n--------scaledImage==%f\n\n",scaledImage.size.width,scaledImage.size.height);
        return scaledImage;
    }
    else
    {
        return image;
    }
}

#pragma mark -
#pragma mark HUD delegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

@end
