//
//  SS_travel.h
//  StudentServices
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SS_travel : NSObject

@property(nonatomic,copy)NSString*NAME;
@property(nonatomic,copy)NSString*PRICE;
@property(nonatomic,copy)NSString*INTRODUCE;
@property(nonatomic,copy)NSString*DETAIL;
@property(nonatomic,copy)NSString*PHONENO;
@property(nonatomic,copy)NSString*COMPANYNAME;
@property(nonatomic,copy)NSString*PICURL;
@property(nonatomic,copy)NSString*COMPANYURL;
@property(nonatomic,copy)NSAttributedString * attText;//富文本详细信息
@property(nonatomic,assign)int height_text;
@property(nonatomic,retain)NSArray * images;//表情组
@property(nonatomic,assign)CGFloat height_cell;

@end
