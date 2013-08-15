//
//  RecommendViewController.h
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouMiWall.h"
#import "YouMiWallBanner.h"
#import <QuartzCore/QuartzCore.h>
#import "YouMiWallAppModel.h"
#import "YouMiWallDelegateProtocol.h"
@interface RecommendViewController : UIViewController<YouMiWallDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray*_youMiAppArray;
    UITableView*_youMiTableView;
    YouMiWall*_wall;
    UIActivityIndicatorView *_activityView;
}
@property(nonatomic,retain)NSMutableArray*youMiAppArray;
@property(nonatomic,retain)UITableView*youMiTableView;
@property(nonatomic,retain)YouMiWall*wall;
@property(nonatomic,retain)UIActivityIndicatorView *activityView;

@end
