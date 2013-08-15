//
//  TravelCell.m
//  StudentSevice
//
//  Created by victor on 13-3-24.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "TravelCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>


@interface TravelCell ()
{
    UIView *_backgroundImageView;
}

@property(nonatomic,retain)UIView *backgroundImageView;

@end


@implementation TravelCell
@synthesize backgroundImageView = _backgroundImageView;
@synthesize background = _background;
@synthesize more = _more;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
@synthesize separatorLine = _separatorLine;
@synthesize companyImg = _companyImg;

-(void)dealloc
{
    self.background = nil;
    self.more = nil;
    self.titleLabel = nil;
    self.detailLabel = nil;
    self.separatorLine = nil;
    self.companyImg = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //设置背景图片
        self.background = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 280, 70)]autorelease];
//        [self.background setImage:[[UIImage imageNamed:@"cellBack"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 144, 16,130)]];
        
        
        self.backgroundImageView = [[[UIView alloc]initWithFrame:self.background.bounds]autorelease];
        self.backgroundImageView.backgroundColor = [UIColor blackColor];
        self.backgroundImageView.alpha = 0.4f;
        self.backgroundImageView.layer.cornerRadius = 5;//设置那个圆角的有多圆
        self.backgroundImageView.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
        self.backgroundImageView.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
        self.backgroundImageView.layer.masksToBounds = YES;
        
        
        
        
        self.more = [[[UIImageView alloc]initWithFrame:CGRectMake(230, 0, 50, 50)]autorelease];;
        [self.more setImage:[UIImage imageNamed:@"more"]];
        
        //公司的图标
        self.companyImg = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)]autorelease];
        
        //旅游景点名称label
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 220, 20)]autorelease];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        
        //设置分割线
        self.separatorLine = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 51, 280, 1)]autorelease];
        self.separatorLine.image = [UIImage imageNamed:@"cell_separator"];
        
        //详细信息 这是一个富文本label
        self.detailLabel  = [[[OHAttributedLabel alloc]initWithFrame:CGRectMake(10, 55,260 , 40)]autorelease];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.delegate = self;
        self.detailLabel.textColor = [UIColor blueColor];
        
        //设置选择背景色为透明
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.background.userInteractionEnabled = YES;
        
        [self.background addSubview:self.backgroundImageView];
        [self.background addSubview:self.titleLabel];
        [self.background addSubview:self.detailLabel];
        [self.contentView addSubview:self.background];
        [self.background addSubview:self.separatorLine];
        [self.background addSubview:self.companyImg];
        [self.background addSubview:self.more];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTravel:(SS_travel *)travel
{
    /*------------------------------------------给cell上控件的属性赋值--------------------------------------*/
    
    self.titleLabel.text = travel.NAME;
    [self.detailLabel setAttString:travel.attText withImages:nil];
    self.detailLabel.textColor = [UIColor whiteColor];
    [self.companyImg setImageWithURL:[NSURL URLWithString:travel.COMPANYURL] placeholderImage:nil];
    
    /*-----------------------------------------------自使用高度-------------------------------------------*/
    //计算label的高度
    CGRect frame = self.detailLabel.frame;
    frame.size.height = travel.height_text;
    self.detailLabel.frame = frame;
    
    //设置背景大小
    frame = self.background.frame;
    frame.size.height = travel.height_cell-20;
    self.background.frame = frame;
    
    
    frame = self.backgroundImageView.frame;
    frame.size.height = travel.height_cell-20;
    self.backgroundImageView.frame = frame;
    
    
    frame = self.more.frame;
    frame.origin.y = travel.height_cell-20-50;
    self.more.frame = frame;
    
    //设置的整体的大小
    frame = self.frame;
    frame.size.height = travel.height_cell;
    self.frame = frame;
    
    
    /*-----------------------------------------添加点击链接--------------------------------------------------*/
    NSString *string = travel.attText.string;
    //添加点击事件(块方法快速枚举数组元素)
    if ([travel.images count])
    {
        for (NSString *user in travel.images)
        {
            [self.detailLabel addCustomLink:[NSURL URLWithString:user] inRange:[string rangeOfString:user]];
        }
    }
}

-(void)setFood:(SS_food *)food
{
    /*------------------------------------------给cell上控件的属性赋值--------------------------------------*/
    
    self.titleLabel.text = food.NAME;
    [self.detailLabel setAttributedText:food.attText];
    //[self.companyImg setImageWithURL:[NSURL URLWithString:food.COMPANYURL] placeholderImage:nil];
    
    /*-----------------------------------------------自使用高度-------------------------------------------*/
    //计算label的高度
    CGRect frame = self.detailLabel.frame;
    frame.size.height = food.height_text;
    self.detailLabel.frame = frame;
    
    //设置背景大小
    frame = self.background.frame;
    frame.size.height = food.height_cell-20;
    self.background.frame = frame;
    
    frame = self.more.frame;
    frame.origin.y = food.height_cell-20-50;
    self.more.frame = frame;
    
    //设置的整体的大小
    frame = self.frame;
    frame.size.height = food.height_cell;
    self.frame = frame;
    
    
    /*-----------------------------------------添加点击链接--------------------------------------------------*/
    NSString *string = food.attText.string;
    //添加点击事件(块方法快速枚举数组元素)
    if ([food.images count])
    {
        for (NSString *user in food.images)
        {
            [self.detailLabel addCustomLink:[NSURL URLWithString:user] inRange:[string rangeOfString:user]];
        }
    }
}

@end
