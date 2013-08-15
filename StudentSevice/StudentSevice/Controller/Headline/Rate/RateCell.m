//
//  RateCell.m
//  StudentSevice
//
//  Created by victor on 13-3-24.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "RateCell.h"

@interface RateCell ()

{
    UIImageView*_background;
    UILabel *_titleLabel;
    UILabel *_dateLabel;
    UIImageView*_separatorLine;
    UILabel *_rateTitleLabel;
    UILabel *_rateLabel;
    UIImageView*_more;
}
@property(nonatomic,retain)UIImageView*background;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *dateLabel;
@property(nonatomic,retain)UIImageView*separatorLine;
@property(nonatomic,retain)UILabel *rateTitleLabel;
@property(nonatomic,retain)UILabel *rateLabel;
@property(nonatomic,retain)UIImageView*more;



@end



@implementation RateCell

@synthesize background = _background;
@synthesize titleLabel  =_titleLabel;
@synthesize dateLabel = _dateLabel;
@synthesize separatorLine = _separatorLine;
@synthesize rateTitleLabel = _rateTitleLabel;
@synthesize rateLabel = _rateLabel;
@synthesize more = _more;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背景图片
        self.background = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 280, 180)]autorelease];
        [self.background setImage:[[UIImage imageNamed:@"cellBack"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 144, 16,130)]];
        
        //
        //显示有更多的image
        self.more = [[[UIImageView alloc]initWithFrame:CGRectMake(230, 130, 50, 50)]autorelease];;
        [self.more setImage:[UIImage imageNamed:@"more"]];
        
        //公司名称label
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 130, 20)]autorelease];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        //公司名称label
        self.dateLabel = [[[UILabel alloc]initWithFrame:CGRectMake(140, 15, 130, 20)]autorelease];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        
        //设置分割线
        self.separatorLine = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 51, 280, 1)]autorelease];
        self.separatorLine.image = [UIImage imageNamed:@"cell_separator"];
        
        //汇率开头label
        self.rateTitleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(50, 70, 180, 40)]autorelease];
        self.rateTitleLabel.backgroundColor = [UIColor clearColor];
        self.rateTitleLabel.text = @"今日汇率";
        self.rateTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.rateTitleLabel.font = [UIFont fontWithName:@"Arial" size:20];
        
        //汇率label
        self.rateLabel = [[[UILabel alloc]initWithFrame:CGRectMake(50, 130, 180, 40)]autorelease];
        self.rateLabel.backgroundColor = [UIColor clearColor];
        self.rateLabel.textColor = [UIColor redColor];
        self.rateLabel.textAlignment = NSTextAlignmentCenter;
        self.rateLabel.font = [UIFont fontWithName:@"Arial" size:35];
        
        //设置选择背景色为透明
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.background.userInteractionEnabled = YES;
        
        [self.background addSubview:self.more];
        [self.background addSubview:self.titleLabel];
        [self.background addSubview:self.dateLabel];
        [self.background addSubview:self.separatorLine];
        [self.background addSubview:self.rateTitleLabel];
        [self.background addSubview:self.rateLabel];
        [self.contentView addSubview:self.background];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.background.frame = CGRectMake(0, 0, 0, 0);
    self.titleLabel.frame = CGRectMake(0, 0, 0, 0);
    self.dateLabel.frame = CGRectMake(0, 0, 0, 0);
    self.separatorLine.frame = CGRectMake(0, 0, 0, 0);
    self.rateLabel.frame = CGRectMake(0, 0, 0, 0);
    self.rateTitleLabel.frame = CGRectMake(0, 0, 0, 0);
    self.more.frame = CGRectMake(0, 0, 0, 0);

    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)dealloc
{
    self.background = nil;
    self.titleLabel = nil;
    self.dateLabel = nil;
    self.separatorLine = nil;
    self.rateLabel = nil;
    self.rateTitleLabel = nil;
    self.more = nil;
    [super dealloc];
}


@end
