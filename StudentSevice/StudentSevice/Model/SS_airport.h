//
//  SS_airport.h
//  StudentServices
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SS_airport : NSObject

@property(nonatomic,copy)NSString*companyName;
@property(nonatomic,copy)NSString*detail;
@property(nonatomic,copy)NSString*phoneNumber;
@property(nonatomic,copy)NSString*otherContact;
@property(nonatomic,assign)CGFloat height_cell;







@property(nonatomic,copy)NSAttributedString * attText;//富文本详细信息
@property(nonatomic,copy)NSArray * images;//表情组
@property(nonatomic,assign)int height_text;

@end
