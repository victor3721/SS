//
//  FoodViewController.h
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SS_food.h"
#import "TravelCell.h"
#import "SSManager.h"
#import "OHAttributedLabel.h"
@interface FoodViewController : UITableViewController<OHAttributedLabelDelegate>
{
    NSMutableArray *_dataArr;
    NSString*_number;
}
@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,copy)NSString*number;
@end
