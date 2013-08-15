//
//  HeadLineView.h
//  StudentSevice
//
//  Created by victor on 13-4-29.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadLineView : UIView
{
    UIScrollView*_scrollView;//存储各个controller的scrollView
}
@property(nonatomic,retain)UIScrollView*scrollView;//存储各个controller的scrollView

@end
