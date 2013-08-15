//
//  RateDetailView.h
//  StudentSevice
//
//  Created by victor on 13-3-27.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateDetailView : UIView
{
    NSString*_urlStr;
    UIImageView *_imageView;
    UITextView *_textView1;
}

@property(nonatomic,retain)NSString*urlStr;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UITextView *textView1;
@end
