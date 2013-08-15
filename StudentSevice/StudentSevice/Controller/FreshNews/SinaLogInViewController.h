//
//  SinaLogInViewController.h
//  StudentServices
//
//  Created by victor on 13-3-16.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface SinaLogInViewController : UIViewController
{
    SinaWeibo*_sinaWeibo;
}
@property(nonatomic,retain)SinaWeibo*sinaWeibo;

@end
