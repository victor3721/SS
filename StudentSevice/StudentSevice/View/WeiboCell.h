//
//  WeiboCell.h
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"

#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "RegexKitLite.h"
#import "MarkupParser.h"
@interface WeiboCell : UITableViewCell<OHAttributedLabelDelegate>
{
    UIImageView *_thumbNail;//头像图片
    UILabel *_name;//用户名称
    UILabel *_time;//发布时间
    OHAttributedLabel *_text;//微博的正文
    UIImageView *_image;//微博的配图
    UIImageView*_backView;//cell的头部背景
    Status *_status;
    UILabel*_weiBoTextLab;
}

@property(nonatomic,retain)UIImageView *thumbNail;//头像图片
@property(nonatomic,retain)UILabel *name;//用户名称
@property(nonatomic,retain)UILabel *time;//发布时间
@property(nonatomic,retain)OHAttributedLabel *text;//微博的正文
@property(nonatomic,retain)UIImageView *image;//微博的配图
@property(nonatomic,retain)UIImageView*backView;//cell的头部背景
@property(nonatomic,retain)UILabel*weiBoTextLab;//cell的头部背景
@property(nonatomic,retain)Status *status;

@end
