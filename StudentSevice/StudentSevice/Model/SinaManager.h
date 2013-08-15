//
//  SinaManager.h
//  Sina
//
//  Created by victor on 13-1-17.
//  Copyright (c) 2013年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"
#import "Status.h"
typedef void (^SinaManagerBlock)(id result);
@interface SinaManager : NSObject
{
    SinaManagerBlock finishBlock;
    SinaWeibo * _sinaWeibo;
}

@property(nonatomic,retain)SinaWeibo * sinaWeibo;

-(void)setFinishBlock:(SinaManagerBlock)block;

//读取相关微博
-(void)readStatusesWithURL:(NSString *)url Params:(NSMutableDictionary*)params;
-(void)readUserWithURL:(NSString *)url Params:(NSMutableDictionary *)params;

-(void)readStatuses;


@end
