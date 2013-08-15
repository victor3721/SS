//
//  IISwebview.h
//  StudentSevice
//
//  Created by victor on 13-6-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IISwebview : UIView
{
    UIWebView * _IISWebView;
    UIButton *_backBtu;
    UIButton *_stopBtu;
}

@property(nonatomic,retain)UIWebView *IISWebView;;
@property(nonatomic,retain)UIButton *backBtu;
@property(nonatomic,retain)UIButton *stopBtu;


@end
