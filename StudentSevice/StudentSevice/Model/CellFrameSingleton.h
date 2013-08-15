//
//  CellFrameSingleton.h
//  StudentSevice
//
//  Created by victor on 13-3-29.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboCell.h"

@interface CellFrameSingleton : NSObject
+(CellFrameSingleton*)shareCellFrame;
-(void)changeFrameWithCell:(WeiboCell*)cell;
@end
