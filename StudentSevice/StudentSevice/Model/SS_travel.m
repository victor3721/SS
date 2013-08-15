//
//  SS_travel.m
//  StudentServices
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import "SS_travel.h"
#import "OHLableSingleton.h"
@implementation SS_travel
-(CGFloat)height_cell
{
    return self.height_text+80;
}

-(NSDictionary *)countTextHeigh:(NSString *)text withFont:(UIFont *)font Width:(int)width
{
    //计算text在规定字体和宽度下的高度
    OHLableSingleton * ohl = [OHLableSingleton shareOH];
    NSDictionary * dic = [ohl transformString:text Width:width Font:font];
    return dic;
}
-(void)setPHONENO:(NSString *)PHONENO
{
    _PHONENO = PHONENO;
    //通过原始文本信息，计算出需要的参数
    NSDictionary * dic = [self countTextHeigh:PHONENO withFont:TEXT_FONT Width:TEXT_WIDTH];
    //高度自适应的参数
    self.height_text = [[dic valueForKey:TEXT_HEIGHT] intValue];
    //图文混排的参数
    self.attText = [dic valueForKey:STRING];
    self.images = [dic valueForKey:TOPICS];
}
@end