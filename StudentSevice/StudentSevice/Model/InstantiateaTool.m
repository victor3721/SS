//
//  InstantiateaTool.m
//  数据实体化
//
//  Created by Ibokan on 13-3-12.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "InstantiateaTool.h"

@implementation InstantiateaTool
+(id)getInstanceWithClassName:(NSString *)className JsonDic:(NSDictionary *)dic
{
    Class class = NSClassFromString(className);
    id instance = [[[class alloc]init ]autorelease];
    for (NSString *key in [dic allKeys]) {
        id value = [dic valueForKey:key];//取出key对应的值
        //把key的首字母大写
        char first = [key characterAtIndex:0]-32;
        NSRange range = {0,1};
        key = [key stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",first]];
        if ([value isKindOfClass:[NSString class]]) {//如果value为字符串，则为实体字符串型属性
            NSString *selStr = [NSString stringWithFormat:@"set%@:",key];
            [instance performSelector:NSSelectorFromString(selStr) withObject:value];
        }
        else if ([value isKindOfClass:[NSDictionary class]])//如果为字典，则为实体型属性
        {
            NSString *selStr = [NSString stringWithFormat:@"set%@:",key];

            if ([key isEqualToString:@"Retweeted_status"]) {
                key = @"Status";
            }
            id sub =[self getInstanceWithClassName:key JsonDic:value];
      
            [instance performSelector:NSSelectorFromString(selStr) withObject:sub];
        }
    }
    return instance;
}
+(id)getInstanceWithClassName:(NSString *)className XmlDic:(NSDictionary *)dic
{
    Class class = NSClassFromString(className);
    id instance = [[[class alloc]init]autorelease];
    for (NSString *key in [dic allKeys]) {
        if (![key isEqualToString:@"text"])//跳过key为text的键值对
        {
            NSString *value =[self removeSpaceAndReturnWithStr:[[dic valueForKey:key]valueForKey:@"text"]];
            //把key的首字母大写
            char first = [key characterAtIndex:0]-32;
            NSRange range = {0,1};
            key = [key stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",first]];
            
            if (value) {//如果value存在，说明为本实例字符串型属性
                key = [key stringByReplacingOccurrencesOfString:@"-" withString:@"_"];//属性命名中不允许‘-’出现，用‘_’代替
                NSString *selStr = [NSString stringWithFormat:@"set%@:",key];
                SEL sel = NSSelectorFromString(selStr);
                [instance performSelector:sel withObject:value];
            }
            else{//否则，该属性为另一个实体实例
                id sub = [self getInstanceWithClassName:key XmlDic:[dic valueForKey:key]];
                NSString *selStr = [NSString stringWithFormat:@"set%@:",key];
                SEL sel = NSSelectorFromString(selStr);
                [instance performSelector:sel withObject:sub];
            }
        }
    }
    return instance;
}

+(NSString *)removeSpaceAndReturnWithStr:(NSString *)str
{
    str  = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}

@end
