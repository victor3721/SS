//
//  Status.h
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Status : NSObject
@property(nonatomic,copy)NSString *visible;
@property(nonatomic,copy)NSString *original_pic;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *truncated;
@property(nonatomic,copy)NSString *reposts_count;
@property(nonatomic,copy)NSString *bmiddle_pic;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,retain)User *user;
@property(nonatomic,copy)NSString *geo;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *attitudes_count;
@property(nonatomic,copy)NSString *in_reply_to_screen_name;
@property(nonatomic,copy)NSString *favorited;
@property(nonatomic,copy)NSString *in_reply_to_status_id;
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,copy)NSString *comments_count;
@property(nonatomic,copy)NSString *thumbnail_pic;
@property(nonatomic,copy)NSString *in_reply_to_user_id;
@property(nonatomic,copy)NSString *mlevel;
@property(nonatomic,retain)Status *retweeted_status;
@property(nonatomic,copy)NSString *deleted;

@property(nonatomic,assign)BOOL haveImage;
@property(nonatomic,assign)CGFloat height_text;
@property(nonatomic,assign)CGFloat height_cell;

-(NSString *)bigImage;
@end
