//
//  TravelViewController.h
//  StudentSevice
//
//  Created by victor on 13-3-20.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSManager.h"
#import "SS_travel.h"
#import "TravelDetailView.h"
#import "MBProgressHUD.h"
#import "OHAttributedLabel.h"

typedef void (^TravelDetailBlock)(id result);
@interface TravelViewController : UITableViewController<NSCoding,MBProgressHUDDelegate,OHAttributedLabelDelegate>
{
    NSMutableArray *_dataArr;
    MBProgressHUD *HUD;
    NSString*_number;
    
}
@property(nonatomic,retain)NSMutableArray *dataArr;

@property(nonatomic,copy)NSString*number;

@property(nonatomic,assign)BOOL openMenu;
@end
