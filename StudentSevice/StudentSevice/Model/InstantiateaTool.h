//
//  InstantiateaTool.h
//  数据实体化
//
//  Created by Ibokan on 13-3-12.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstantiateaTool : NSObject
+(id)getInstanceWithClassName:(NSString *)className XmlDic:(NSDictionary *)dic;
+(id)getInstanceWithClassName:(NSString *)className JsonDic:(NSDictionary *)dic;
@end
