//
//  TravelViewControllerCell.m
//  StudentSevice
//
//  Created by victor on 13-7-30.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "TravelViewControllerCell.h"

@interface TravelViewControllerCell()
{
    
    UIImageView *_backgroundImageView;
    UILabel *_detailLabel;
    UIImageView *_separatorImageView;

}

@property(nonatomic,retain)UIImageView *backgroundImageView;
@property(nonatomic,retain)UILabel *detailLabel;
@property(nonatomic,retain)UIImageView *separatorImageView;

@end



@implementation TravelViewControllerCell

@synthesize placeNameLabel = _placeNameLabel;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize detailLabel = _detailLabel;
@synthesize separatorImageView = _separatorImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundImageView = [[[UIImageView alloc]init]autorelease];
        self.backgroundImageView.image = [UIImage imageNamed:@""];
        [self addSubview:self.backgroundImageView];
        
        
        self.placeNameLabel = [[[UILabel alloc]init]autorelease];
        self.placeNameLabel.backgroundColor = [UIColor clearColor];
        self.placeNameLabel.font = [UIFont systemFontOfSize:20];
        self.placeNameLabel.textColor = [UIColor whiteColor];
        self.placeNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.placeNameLabel];
        
        
        self.detailLabel = [[[UILabel alloc]init]autorelease];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.font = [UIFont systemFontOfSize:20];
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.textAlignment = NSTextAlignmentLeft;
        self.detailLabel.text = @"查看详细信息";
        [self addSubview:self.detailLabel];
        
        
        
        self.separatorImageView = [[[UIImageView alloc]init]autorelease];
        self.separatorImageView.image = [UIImage imageNamed:@""];
        [self addSubview:self.separatorImageView];
        
    
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundImageView.frame = CGRectMake(0, 0, 0, 0);
    self.placeNameLabel.frame = CGRectMake(0, 0, 0, 0);
    self.detailLabel.frame = CGRectMake(0, 0, 0, 0);;
    self.separatorImageView.frame = CGRectMake(0, 0, 0, 0);
}




-(void)dealloc
{
    
    [super dealloc];
    
    self.placeNameLabel = nil;
    self.backgroundImageView = nil;
    self.detailLabel = nil;
    self.separatorImageView = nil;
    
    
    
    
}

#pragma mark -
#pragma mark private method

#pragma mark setter&&getter
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
