//
//  SS_secondHand.h
//  StudentServices
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SS_secondHand : NSObject
@property(nonatomic,copy)NSString*DETAIL;
@property(nonatomic,copy)NSString*NAME;
@property(nonatomic,copy)NSString*DATE;
@property(nonatomic,copy)NSAttributedString * attText;//富文本详细信息
@property(nonatomic,copy)NSArray * images;//表情组
@property(nonatomic,assign)int height_text;
@property(nonatomic,assign)CGFloat height_cell;
@end
