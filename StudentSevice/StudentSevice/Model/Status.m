//
//  Status.m
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "Status.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "RegexKitLite.h"
#import "MarkupParser.h"
@implementation Status
-(BOOL)haveImage
{
    if (self.thumbnail_pic) {
        return YES;
    }
    else if (self.retweeted_status.thumbnail_pic)
    {
        return YES;
    }
    else
        return NO;
}
-(CGFloat)height_text
{
    if (self.retweeted_status) {
        return [self getHeightwithString:self.retweeted_status.text];
    }else{
        return [self getHeightwithString:self.text];
    }
}

-(NSString *)bigImage
{
    if (self.retweeted_status) {
        if (self.retweeted_status.original_pic) {
            return self.retweeted_status.original_pic;
        }
        else{
            return self.retweeted_status.bmiddle_pic;
        }
    }
    else{
        if (self.original_pic) {
            return self.original_pic;
        }
        else{
            return self.bmiddle_pic;
        }
    }
}
-(CGFloat)height_cell
{
    //计算cell的高度
    if (self.haveImage) {
        return 55+80 + self.height_text ;
    }
    else{
        return 50+self.height_text;
    }
}
-(CGFloat)getHeightwithString:(NSString *)str
{
    //计算文字的高度
    OHAttributedLabel *oh = [[OHAttributedLabel alloc]initWithFrame:CGRectMake(0, 0, 240, 0)];
    [self creatAttributedLabel:str Label:oh];
    return oh.frame.size.height;

}
-(void)creatAttributedLabel:(NSString *)o_text Label:(OHAttributedLabel *)label
{
    //进行表情的html转化
    NSString *text = o_text;
    //进行html样式转化为AttributedString
    MarkupParser* p = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [p attrStringFromMarkup:text];
    
    //深复制，防止之前的内容变动影响后面的字符串
    attString = [NSMutableAttributedString attributedStringWithAttributedString:attString];
    //设置字体字号
    [attString setFont:[UIFont fontWithName:@"Arial" size:16]];
    //将配置好的AttributedString添加到label中
    [label setAttString:attString withImages:p.images];
    
    //自适应高度
    CGRect labelRect = label.frame;
    CGSize size = [label sizeThatFits:CGSizeMake(290, CGFLOAT_MAX)];
    labelRect.size = size;
    label.frame = labelRect;
}



@end
