//
//  AirportViewController.h
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"

@interface AirportViewController : UITableViewController<OHAttributedLabelDelegate>
{
    NSString*_number;
    NSMutableArray *_dataArr;
}
@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,copy)NSString*number;
@end
