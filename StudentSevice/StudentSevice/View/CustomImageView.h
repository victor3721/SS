//
//  CustomImageView.h
//  StudentSevice
//
//  Created by Liu on 13-3-22.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface CustomImageView : UIView<MBProgressHUDDelegate,UIWebViewDelegate>
{
    MBProgressHUD *HUD;
    UIWebView *imageWebView;
    UIImageView *imageView;
}

- (id)initWithFrame:(CGRect)frame WithImageStr:(NSString *)str;
- (void)loadImageWithStr:(NSString *)str;

@end
