//
//  OHLableSingleton.m
//  Sina
//
//  Created by victor on 13-1-22.
//  Copyright (c) 2013年 victor. All rights reserved.
//

#import "OHLableSingleton.h"

static OHLableSingleton*ohl = nil;

@implementation OHLableSingleton


+(OHLableSingleton *)shareOH
{
    if (ohl == nil) {
        ohl = [[OHLableSingleton alloc]init];
        ohl.OHLabel = [[[OHAttributedLabel alloc]initWithFrame:CGRectZero] autorelease];
    }
    return ohl;
}

-(NSDictionary *)transformString:(NSString*)texts Width:(int)width Font:(UIFont *)font
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:5];
    
    //进行表情的html转化
    NSString *text = [self transformString:texts];
    
    //设置字体的html格式颜色
    text = [NSString stringWithFormat:@"<font color='black'>%@",text];
    
    //进行html样式转化为AttributedString
    MarkupParser* p = [[[MarkupParser alloc] init] autorelease];
    NSMutableAttributedString* attString = [p attrStringFromMarkup:text];
    
    //深复制，防止之前的内容变动影响后面的字符串
    attString = [NSMutableAttributedString attributedStringWithAttributedString:attString];
    
    //设置字体字号
    [attString setFont:font];
    
    //将配置好的AttributedString添加到label中
    [self.OHLabel setAttributedText:attString];
    
    [dic setObject:attString forKey:STRING];
    [dic setObject:p.images forKey:IMAGES];
    
    NSString *string = attString.string;
    NSArray * topics = [self regexTopics:string];
    [dic setObject:topics forKey:TOPICS];
    
    //高度自适应
    CGSize size = [self.OHLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    [dic setObject:[NSNumber numberWithFloat:size.height] forKey:TEXT_HEIGHT];
    
    return dic;
}

- (NSString *)transformString:(NSString *)originalStr
{
    //正则匹配 [**] 表情
    NSString *text = originalStr;
//    NSString *regex_emoji = @"^0\\d{10}$";
//    NSArray *array_emoji = [text componentsMatchedByRegex:regex_emoji];
    return text;
}

-(NSArray *)regexTopics:(NSString *)o_text
{
    //@"#([^\#|.]+)\#"
    //正则匹配话题 ##
    NSString *text = o_text;
    NSString *regex_topic = @"[0-9]{9,}";
    NSArray *array_topic = [text componentsMatchedByRegex:regex_topic];
    return array_topic;
}

@end
