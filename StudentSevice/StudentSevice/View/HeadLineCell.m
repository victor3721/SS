
//
//  HeadLineCell.m
//  StudentSevice
//
//  Created by victor on 13-3-22.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "HeadLineCell.h"

@implementation HeadLineCell
@synthesize background = _background;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
@synthesize separatorLine = _separatorLine;
@synthesize dateLabel = _dateLabel;

-(void)dealloc
{
    self.background = nil;
    self.titleLabel = nil;
    self.detailLabel = nil;
    self.separatorLine = nil;
    self.dateLabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背景图片
        self.background = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 280, 70)]autorelease];
        [self.background setImage:[[UIImage imageNamed:@"cellBack"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 144, 16,130)]];
        
        //设置分割线
        self.separatorLine = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 31, 280, 1)]autorelease];
        self.separatorLine.image = [UIImage imageNamed:@"cell_separator"];
        
        //公司名称label
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)]autorelease];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        //时间的label
        self.dateLabel = [[[UILabel alloc]initWithFrame:CGRectMake(160, 5, 120, 20)]autorelease];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        
        //详细信息 这是一个富文本label
        self.detailLabel  = [[[OHAttributedLabel alloc]initWithFrame:CGRectMake(10, 35,260 , 40)]autorelease];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.delegate = self;
        
        //设置选择背景色为透明
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.background.userInteractionEnabled = YES;
        
        [self.background addSubview:self.titleLabel];
        [self.background addSubview:self.detailLabel];
        [self.contentView addSubview:self.background];
        [self.background addSubview:self.separatorLine];
        [self.background addSubview:self.dateLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

//机场接送的设置
-(void)setAirPort:(SS_airport *)airport
{
    /*------------------------------------------给cell上控件的属性赋值--------------------------------------*/

    self.titleLabel.text = airport.companyName;
    [self.detailLabel setAttributedText:airport.attText];
    
    /*-----------------------------------------------自使用高度-------------------------------------------*/
    //计算label的高度
    CGRect frame = self.detailLabel.frame;
    frame.size.height = airport.height_text;
    self.detailLabel.frame = frame;
    
    //设置背景大小
    frame = self.background.frame;
    frame.size.height = airport.height_cell-20;
    self.background.frame = frame;
    
    //设置的整体的大小
    frame = self.frame;
    frame.size.height = airport.height_cell;
    self.frame = frame;
    
    
    /*-----------------------------------------添加点击链接--------------------------------------------------*/
    NSString *string = airport.attText.string;
    //添加点击事件(块方法快速枚举数组元素)
    if ([airport.images count])
    {
        for (NSString *user in airport.images)
        {
            [self.detailLabel addCustomLink:[NSURL URLWithString:user] inRange:[string rangeOfString:user]];
        }
    }
}

//机场接送的设置
-(void)setSecondHand:(SS_secondHand *)secondHand
{
    /*------------------------------------------给cell上控件的属性赋值--------------------------------------*/
    
    self.titleLabel.text = secondHand.NAME;
    [self.detailLabel setAttributedText:secondHand.attText];
    self.dateLabel.text = secondHand.DATE;
    
    /*-----------------------------------------------自使用高度-------------------------------------------*/
    //计算label的高度
    CGRect frame = self.detailLabel.frame;
    frame.size.height = secondHand.height_text;
    self.detailLabel.frame = frame;
    
    //设置背景大小
    frame = self.background.frame;
    frame.size.height = secondHand.height_cell-20;
    self.background.frame = frame;
    
    //设置的整体的大小
    frame = self.frame;
    frame.size.height = secondHand.height_cell;
    self.frame = frame;
    
    
    /*-----------------------------------------添加点击链接--------------------------------------------------*/
    NSString *string = secondHand.attText.string;
    //添加点击事件(块方法快速枚举数组元素)
    if ([secondHand.images count])
    {
        for (NSString *user in secondHand.images)
        {
            [self.detailLabel addCustomLink:[NSURL URLWithString:user] inRange:[string rangeOfString:user]];
        }
    }

}

-(void)setRent:(SS_rent *)rent
{
    /*------------------------------------------给cell上控件的属性赋值--------------------------------------*/
    
    self.titleLabel.text = rent.NAME;
    [self.detailLabel setAttributedText:rent.attText];
    self.dateLabel.text = rent.DATE;
    
    /*-----------------------------------------------自使用高度-------------------------------------------*/
    //计算label的高度
    CGRect frame = self.detailLabel.frame;
    frame.size.height = rent.height_text;
    self.detailLabel.frame = frame;
    
    //设置背景大小
    frame = self.background.frame;
    frame.size.height = rent.height_cell-20;
    self.background.frame = frame;
    
    //设置的整体的大小
    frame = self.frame;
    frame.size.height = rent.height_cell;
    self.frame = frame;
    
    
    /*-----------------------------------------添加点击链接--------------------------------------------------*/
    NSString *string = rent.attText.string;
    //添加点击事件(块方法快速枚举数组元素)
    if ([rent.images count])
    {
        for (NSString *user in rent.images)
        {
            [self.detailLabel addCustomLink:[NSURL URLWithString:user] inRange:[string rangeOfString:user]];
        }
    }
}




@end
