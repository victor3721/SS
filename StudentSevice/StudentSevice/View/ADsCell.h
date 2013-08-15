//
//  ADsCell.h
//  StudentSevice
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADsCell : UITableViewCell
{
    UIImageView*_picView;
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    UIButton *_downLoadBtu;
}
@property(nonatomic,retain)UIImageView*picView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *detailLabel;
@property(nonatomic,retain)UIButton *downLoadBtu;
@end
