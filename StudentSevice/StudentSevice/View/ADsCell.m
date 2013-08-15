//
//  ADsCell.m
//  StudentSevice
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "ADsCell.h"

#define TITLELABELFROUT @"Helvetica-Light"

@implementation ADsCell
@synthesize picView = _picView;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
@synthesize downLoadBtu = _downLoadBtu;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.picView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,0 , 0)]autorelease];
        
        
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)]autorelease];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:TITLELABELFROUT size:16];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        
        self.downLoadBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        self.downLoadBtu.frame = CGRectMake(0, 0, 0, 0);
        [self.downLoadBtu setImage:[UIImage imageNamed:@"Recommend_download_btu"] forState:UIControlStateNormal];
        
        
        [self.contentView addSubview:self.picView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.downLoadBtu];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.picView.frame = CGRectMake(10, 5, 35, 35);
    self.titleLabel.frame = CGRectMake(55, 10, 200, 20);
    self.downLoadBtu.frame =CGRectMake(200, 7, 50, 30);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

-(void)dealloc
{
    self.picView = nil;
    self.titleLabel = nil;
    self.downLoadBtu = nil;
    [super dealloc];
}
@end
