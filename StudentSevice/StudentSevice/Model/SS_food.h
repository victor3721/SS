//
//  SS_food.h
//  StudentServices
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SS_food : NSObject

@property(nonatomic,copy)NSString*NAME;
@property(nonatomic,copy)NSString*DETAIL;
@property(nonatomic,copy)NSString*URL;
@property(nonatomic,copy)NSString*LON;
@property(nonatomic,copy)NSString*LATI;
@property(nonatomic,copy)NSAttributedString * attText;//富文本详细信息
@property(nonatomic,copy)NSArray * images;//表情组
@property(nonatomic,assign)int height_text;
@property(nonatomic,assign)CGFloat height_cell;
@end
