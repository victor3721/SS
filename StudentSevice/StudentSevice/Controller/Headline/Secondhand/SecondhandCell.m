//
//  SecondhandCell.m
//  StudentSevice
//
//  Created by victor on 13-8-3.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "SecondhandCell.h"

@interface SecondhandCell ()
{
    UIImageView*_background;
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    UIImageView*_separatorLine;
    UILabel *_phoneNumberLab;
    UIButton *_callButton;
    UIButton *_sendMessageButton;
    UIImageView *_secondHandIV;
    
}

@property(nonatomic,retain)UIImageView*background;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *detailLabel;
@property(nonatomic,retain)UIImageView*separatorLine;
@property(nonatomic,retain)UILabel *phoneNumberLab;
@property(nonatomic,retain)UIButton *callButton;
@property(nonatomic,retain)UIButton *sendMessageButton;
@property(nonatomic,retain)UIImageView *secondHandIV;

@end



@implementation SecondhandCell

@synthesize background = _background;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
@synthesize separatorLine = _separatorLine;
@synthesize phoneNumberLab = _phoneNumberLab;
@synthesize callButton = _callButton;
@synthesize sendMessageButton = _sendMessageButton;
@synthesize secondHandIV = _secondHandIV;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背景图片
        self.background = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 280, 70)]autorelease];
        [self.background setImage:[[UIImage imageNamed:@"cellBack"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 144, 16,130)]];
        [self.contentView addSubview:self.background];
        
        //设置分割线
        self.separatorLine = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 31, 280, 1)]autorelease];
        self.separatorLine.image = [UIImage imageNamed:@"cell_separator"];
        [self.background addSubview:self.separatorLine];
        
        //公司名称label
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)]autorelease];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.background addSubview:self.titleLabel];
        
        
        //详细信息 这是一个富文本label
        self.detailLabel  = [[[UILabel alloc]initWithFrame:CGRectMake(10, 35,260 , 40)]autorelease];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        [self.background addSubview:self.detailLabel];
        
        //
        //设置电话的号码的label
        self.phoneNumberLab = [[[UILabel alloc]init]autorelease];
        self.phoneNumberLab.backgroundColor = [UIColor clearColor];
        self.phoneNumberLab.font = [UIFont systemFontOfSize:14];
        self.phoneNumberLab.textColor = [UIColor redColor];
        [self.background addSubview:self.phoneNumberLab];
        
        //
        //
        self.callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.background addSubview:self.callButton];
        
        //
        //
        self.sendMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.background addSubview:self.sendMessageButton];
        
        //
        //
        self.secondHandIV = [[UIImageView alloc]init];
        [self.background addSubview:self.secondHandIV];
        
        
        //设置选择背景色为透明
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.background.userInteractionEnabled = YES;
        
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.background.frame = CGRectMake(0, 0, 0, 0);
    self.titleLabel.frame = CGRectMake(0, 0, 0, 0);
    self.detailLabel.frame = CGRectMake(0, 0, 0, 0);
    self.separatorLine.frame = CGRectMake(0, 0, 0, 0);
    self.phoneNumberLab.frame = CGRectMake(0, 0, 0, 0);
    self.callButton.frame = CGRectMake(0, 0, 0, 0);
    self.sendMessageButton.frame = CGRectMake(0, 0, 0, 0);
    self.secondHandIV.frame = CGRectMake(0, 0, 0, 0);
}


-(void)dealloc
{
    self.background = nil;
    self.titleLabel = nil;
    self.detailLabel = nil;
    self.separatorLine = nil;
    self.phoneNumberLab = nil;
    self.callButton = nil;
    self.sendMessageButton = nil;
    self.secondHandIV = nil;
    [super dealloc];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
