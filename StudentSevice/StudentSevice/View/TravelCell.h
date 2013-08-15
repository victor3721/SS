//
//  TravelCell.h
//  StudentSevice
//
//  Created by victor on 13-3-24.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "RegexKitLite.h"
#import "MarkupParser.h"
#import "SS_travel.h"

#import "SS_food.h"
@interface TravelCell : UITableViewCell<OHAttributedLabelDelegate>
{
    UIImageView*_background;
    UIImageView*_more;
    UILabel *_titleLabel;
    OHAttributedLabel *_detailLabel;
    UIImageView*_separatorLine;
    UIImageView*_companyImg;
}
@property(nonatomic,retain)UIImageView*background;
@property(nonatomic,retain)UIImageView*more;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)OHAttributedLabel *detailLabel;
@property(nonatomic,retain)UIImageView*separatorLine;
@property(nonatomic,retain)UIImageView*companyImg;
-(void)setTravel:(SS_travel *)travel;
-(void)setFood:(SS_food *)food;
@end
