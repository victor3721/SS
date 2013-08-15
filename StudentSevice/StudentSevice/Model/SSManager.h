//
//  SSManager.h
//  StudentServices
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SSManagerBlock)(id result);
@interface SSManager : NSObject
{
    SSManagerBlock finishBlock;
    NSMutableArray*rateComArr;
}

-(void)setFinishBlock:(SSManagerBlock)block;

-(void)readAirPortInfo;
-(void)readTravelInfo;
-(void)readSecondHandInfo;
-(void)readRentInfo;
-(void)readFoodInfo;
-(void)readRateInfo;
-(void)readRateComInfo;
-(void)postRentInfoParams:(NSMutableDictionary *)params;
-(void)postSecondInfoParams:(NSMutableDictionary *)params;
@end
