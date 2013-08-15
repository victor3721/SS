//
//  MenuView.h
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "YouMiWallDelegateProtocol.h"
@interface MenuView : UITableView<UITableViewDataSource,UITableViewDelegate,YouMiWallDelegate>
{

    User *_user;
}


@property(nonatomic,retain)User *user;

-(void)loadData;
@end
