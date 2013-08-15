//
//  TravelDetailView.h
//  StudentSevice
//
//  Created by victor on 13-3-27.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelDetailView : UIView
{
    UITextView *_textView1;
    UIImageView *_imageView;
    NSString*_urlStr;
}
@property(nonatomic,copy)NSString*urlStr;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UITextView *textView1;
@end
