//
//  HeadLineCell.h
//  StudentSevice
//
//  Created by victor on 13-3-22.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SS_airport.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "RegexKitLite.h"
#import "MarkupParser.h"
#import "SS_secondHand.h"
#import "SS_rent.h"

@interface HeadLineCell : UITableViewCell<OHAttributedLabelDelegate>
{
    UIImageView*_background;
    UILabel *_titleLabel;
    OHAttributedLabel *_detailLabel;
    UIImageView*_separatorLine;
    UILabel*_dateLabel;
}

@property(nonatomic,retain)UIImageView*background;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)OHAttributedLabel *detailLabel;
@property(nonatomic,retain)UIImageView*separatorLine;
@property(nonatomic,retain)UILabel*dateLabel;

-(void)setAirPort:(SS_airport *)airport;
-(void)setSecondHand:(SS_secondHand *)secondHand;
-(void)setRent:(SS_rent *)rent;
@end
