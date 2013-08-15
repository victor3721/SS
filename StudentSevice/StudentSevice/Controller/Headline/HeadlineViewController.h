//
//  HeadlineViewController.h
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IISViewController.h"
@class HeadlineViewController;
typedef void (^MemuBlock)(HeadlineViewController *headViewController,BOOL isMenuShow);
@interface HeadlineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView*_scrollView;
}

@property(nonatomic,copy)MemuBlock menuBlock;


-(void)setMenuBlock:(MemuBlock)menuBlock;

@end
