//
//  SSManager.m
//  StudentServices
//
//  Created by victor on 13-3-19.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import "SSManager.h"
#import "SSRequest.h"
#import "SS_airport.h"
#import "SS_travel.h"
#import "SS_secondHand.h"
#import "SS_rent.h"
#import "SS_food.h"
#import "SS_rate.h"
#import "Reachability.h"

@implementation SSManager
-(void)setFinishBlock:(SSManagerBlock)block
{
    finishBlock = block;
}

-(void)postRentInfoParams:(NSMutableDictionary *)params
{
    NSString*url = @"http://www.bookgo.publicvm.com/real/postrent.php";
    SSRequest * req = [[SSRequest alloc]init];
    [req requestWithURLS:url httpMethod:@"get" params:params];
    [req setFailBlock:^(SSRequest *request, id obj) {
        
        if (finishBlock)
        {
            finishBlock(nil);
        }
    }];
    
    [req setResultBlock:^(SSRequest *request, id obj) {
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(nil);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }
    }];
}

-(void)postSecondInfoParams:(NSMutableDictionary *)params
{
    NSString*url = @"http://www.bookgo.publicvm.com/real/postsecond.php";
    SSRequest * req = [[SSRequest alloc]init];
    [req requestWithURLS:url httpMethod:@"get" params:params];
    [req setFailBlock:^(SSRequest *request, id obj) {
        
        if (finishBlock)
        {
            finishBlock(nil);
        }
    }];
    
    [req setResultBlock:^(SSRequest *request, id obj) {
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(nil);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }
    }];
}

-(void)readAirPortInfo
{
    if ([self checkNetwork])
    {
        NSString*url = @"http://www.bookgo.publicvm.com/real/airport.php";
        SSRequest * req = [[SSRequest alloc]init];
        [req requestWithURLS:url httpMethod:@"get" params:nil];
        [req setFailBlock:^(SSRequest *request, id obj) {
            if (finishBlock)
            {
                finishBlock(nil);
            }
        }];
        [req setResultBlock:^(SSRequest *request, id obj) {
            
            
            NSLog(@"%@",obj);
            
            
            if ([obj isKindOfClass:[NSArray class]]) {
                NSArray*arr = obj;
                [arr writeToFile:[self filePath:@"airport"] atomically:YES];
                NSMutableArray *endArr = [NSMutableArray array];
                for (int i = 0; i<arr.count; i++) {
                    SS_airport*airport = [[SS_airport alloc]init];
                    airport.companyName = [[arr objectAtIndex:i]valueForKey:@"COMPANYNAME"];
                    airport.detail = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
                    NSLog(@"ari %@  %@",airport.companyName,airport.detail);
                    [endArr addObject:airport];
                }
                
                if (finishBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        finishBlock(endArr);
                    });
                }
                else
                {
                    NSLog(@"获取数据有问题");
                }
            }
            
        }];
    }
    else
    {
        NSArray*arr = [NSArray arrayWithContentsOfFile:[self filePath:@"airport"]];
        NSMutableArray *endArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            SS_airport*airport = [[SS_airport alloc]init];
            airport.companyName = [[arr objectAtIndex:i]valueForKey:@"COMPANYNAME"];
            airport.detail = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
            NSLog(@"ari %@  %@",airport.companyName,airport.detail);
            [endArr addObject:airport];
        }
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(endArr);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }

    }
    
}

-(void)readTravelInfo
{
    if ([self checkNetwork])
    {
    NSString*url = @"http://www.bookgo.publicvm.com/real/travel.php";
    SSRequest * req = [[SSRequest alloc]init];
    [req requestWithURLS:url httpMethod:@"get" params:nil];
    [req setFailBlock:^(SSRequest *request, id obj) {
        if (finishBlock)
        {
            finishBlock(nil);
        }
    }];
    [req setResultBlock:^(SSRequest *request, id obj) {
        
        if ([obj isKindOfClass:[NSArray class]]) {
        
        NSArray*arr = obj;
        [arr writeToFile:[self filePath:@"travel"] atomically:YES];
        NSMutableArray *endArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            
            SS_travel*travel = [[SS_travel alloc]init];
            travel.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
            travel.PRICE = [[arr objectAtIndex:i]valueForKey:@"PRICE"];
            travel.INTRODUCE = [[arr objectAtIndex:i]valueForKey:@"INTRODUCE"];
            travel.DETAIL = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
            travel.PHONENO = [[arr objectAtIndex:i]valueForKey:@"PHONENO"];
            travel.PICURL = [[arr objectAtIndex:i]valueForKey:@"PICURL"];
            travel.COMPANYURL = [[arr objectAtIndex:i]valueForKey:@"COMPANYURL"];

            NSLog(@"ari %@  %@",travel.NAME,travel.PHONENO);
            [endArr addObject:travel];
        }
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(endArr);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }
        }
    }];
    }
    else
    {
        NSArray*arr = [NSArray arrayWithContentsOfFile:[self filePath:@"travel"]];
        NSMutableArray *endArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            
            SS_travel*travel = [[SS_travel alloc]init];
            travel.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
            travel.PRICE = [[arr objectAtIndex:i]valueForKey:@"PRICE"];
            travel.INTRODUCE = [[arr objectAtIndex:i]valueForKey:@"INTRODUCE"];
            travel.DETAIL = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
            travel.PHONENO = [[arr objectAtIndex:i]valueForKey:@"PHONENO"];
            travel.PICURL = [[arr objectAtIndex:i]valueForKey:@"PICURL"];
            travel.COMPANYURL = [[arr objectAtIndex:i]valueForKey:@"COMPANYURL"];
            
            NSLog(@"ari %@  %@",travel.NAME,travel.PHONENO);
            [endArr addObject:travel];
        }
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(endArr);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }
    }
}

-(void)readSecondHandInfo
{
    if ([self checkNetwork])
    {
        NSString*url = @"http://www.bookgo.publicvm.com/real/secondHand.php";
        SSRequest * req = [[SSRequest alloc]init];
        [req requestWithURLS:url httpMethod:@"get" params:nil];
        [req setFailBlock:^(SSRequest *request, id obj) {
            if (finishBlock)
            {
                finishBlock(nil);
            }
        }];
        [req setResultBlock:^(SSRequest *request, id obj) {
            
            if ([obj isKindOfClass:[NSArray class]]) {
            
            NSArray*arr = obj;
            [arr writeToFile:[self filePath:@"secondHand"] atomically:YES];
            NSMutableArray *endArr = [NSMutableArray array];
            for (int i = 0; i<arr.count; i++) {
                
                SS_secondHand*second = [[SS_secondHand alloc]init];
                second.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
                second.DATE = [[arr objectAtIndex:i]valueForKey:@"DATE"];
                second.DETAIL = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
                
                NSLog(@"ari %@",second.NAME);
                [endArr addObject:second];
            }
            
            if (finishBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    finishBlock(endArr);
                });
            }
            else
            {
                NSLog(@"获取数据有问题");
            }
            }
        }];
    }
    else
    {
        NSArray*arr = [NSArray arrayWithContentsOfFile:[self filePath:@"secondHand"]];
        NSMutableArray *endArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            
            SS_secondHand*second = [[SS_secondHand alloc]init];
            second.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
            second.DATE = [[arr objectAtIndex:i]valueForKey:@"DATE"];
            second.DETAIL = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
            
            NSLog(@"ari %@",second.NAME);
            [endArr addObject:second];
        }
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(endArr);
            });
    }
    }
}

-(void)readRentInfo
{
    if ([self checkNetwork])
    {
        NSString*url = @"http://www.bookgo.publicvm.com/real/rent.php";
        SSRequest * req = [[SSRequest alloc]init];
        [req requestWithURLS:url httpMethod:@"get" params:nil];
        [req setFailBlock:^(SSRequest *request, id obj) {
            if (finishBlock)
            {
                finishBlock(nil);
            }
        }];
        [req setResultBlock:^(SSRequest *request, id obj) {
            
            if ([obj isKindOfClass:[NSArray class]]) {
            
            NSArray*arr = obj;
            [arr writeToFile:[self filePath:@"rent"] atomically:YES];
            NSMutableArray *endArr = [NSMutableArray array];
            for (int i = 0; i<arr.count; i++) {
                
                SS_rent*rent = [[SS_rent alloc]init];
                rent.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
                rent.DATE = [[arr objectAtIndex:i]valueForKey:@"DATE"];
                rent.DETAIL = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
                rent.URL = [[arr objectAtIndex:i]valueForKey:@"URL"];
                
                NSLog(@"ari %@",rent.NAME);
                [endArr addObject:rent];
            }
            
            if (finishBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    finishBlock(endArr);
                });
            }
            else
            {
                NSLog(@"获取数据有问题");
            }
            }
        }];
    }
    else
    {
        
        NSArray*arr = [NSArray arrayWithContentsOfFile:[self filePath:@"rent"]];
        [arr writeToFile:[self filePath:@"rent"] atomically:YES];
        NSMutableArray *endArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            
            SS_rent*rent = [[SS_rent alloc]init];
            rent.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
            rent.DATE = [[arr objectAtIndex:i]valueForKey:@"DATE"];
            rent.DETAIL = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
            rent.URL = [[arr objectAtIndex:i]valueForKey:@"URL"];
            
            NSLog(@"ari %@",rent.NAME);
            [endArr addObject:rent];
        }
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(endArr);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }
        
    }
    
}

-(void)readFoodInfo
{
    if ([self checkNetwork])
    {
        NSString*url = @"http://www.bookgo.publicvm.com/real/food.php";
        SSRequest * req = [[SSRequest alloc]init];
        [req requestWithURLS:url httpMethod:@"get" params:nil];
        [req setFailBlock:^(SSRequest *request, id obj) {
            if (finishBlock)
            {
                finishBlock(nil);
            }
        }];
        [req setResultBlock:^(SSRequest *request, id obj) {
            
            if ([obj isKindOfClass:[NSArray class]]) {
            
            NSArray*arr = obj;
            [arr writeToFile:[self filePath:@"food"] atomically:YES];
            NSMutableArray *endArr = [NSMutableArray array];
            for (int i = 0; i<arr.count; i++) {
                
                SS_food*food = [[SS_food alloc]init];
                food.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
                food.DETAIL = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
                food.URL = [[arr objectAtIndex:i]valueForKey:@"URL"];
                food.LON = [[arr objectAtIndex:i]valueForKey:@"LON"];
                food.LATI = [[arr objectAtIndex:i]valueForKey:@"LATI"];
                
                NSLog(@"ari %@",food.NAME);
                [endArr addObject:food];
            }
            
            if (finishBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    finishBlock(endArr);
                });
            }
            else
            {
                NSLog(@"获取数据有问题");
            }
            }
        }];
    }
    else
    {
        NSArray*arr = [NSArray arrayWithContentsOfFile:[self filePath:@"food"]];
        NSMutableArray *endArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            
            SS_food*food = [[SS_food alloc]init];
            food.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
            food.DETAIL = [[arr objectAtIndex:i]valueForKey:@"DETAIL"];
            food.URL = [[arr objectAtIndex:i]valueForKey:@"URL"];
            food.LON = [[arr objectAtIndex:i]valueForKey:@"LON"];
            food.LATI = [[arr objectAtIndex:i]valueForKey:@"LATI"];
            
            NSLog(@"ari %@",food.NAME);
            [endArr addObject:food];
        }
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(endArr);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }
        
    }
    
}

-(void)readRateComInfo
{
    if ([self checkNetwork])
    {
        NSString*url = @"http://www.bookgo.publicvm.com/real/rateCom.php";
        SSRequest * req = [[SSRequest alloc]init];
        [req requestWithURLS:url httpMethod:@"get" params:nil];
        [req setFailBlock:^(SSRequest *request, id obj) {
            if (finishBlock)
            {
                finishBlock(nil);
            }
        }];
        [req setResultBlock:^(SSRequest *request, id obj) {
            
            if ([obj isKindOfClass:[NSArray class]]) {
            
            NSArray*arr = obj;
            [arr writeToFile:[self filePath:@"rateCom"] atomically:YES];
            rateComArr = [NSMutableArray array];
            for (int i = 0; i<arr.count; i++) {
                
                NSString*ID = [[arr objectAtIndex:i]valueForKey:@"COMPANYID"];
                
                NSLog(@"ari %@",ID);
                [rateComArr addObject:ID];
            }
            
            if (finishBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    finishBlock(nil);
                });
            }
            else
            {
                NSLog(@"获取数据有问题");
            }
            }
        }];
    }
    else
    {
        NSArray*arr = [NSArray arrayWithContentsOfFile:[self filePath:@"rateCom"]];
        rateComArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            
            NSString*ID = [[arr objectAtIndex:i]valueForKey:@"COMPANYID"];
            
            NSLog(@"ari %@",ID);
            [rateComArr addObject:ID];
        }
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(nil);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }
        
    }
}

-(void)readRateInfo
{
    if ([self checkNetwork])
    {
        NSString*url = @"http://www.bookgo.publicvm.com/real/rate.php";
        SSRequest * req = [[SSRequest alloc]init];
        [req requestWithURLS:url httpMethod:@"get" params:nil];
        [req setFailBlock:^(SSRequest *request, id obj) {
            if (finishBlock)
            {
                finishBlock(nil);
            }
        }];
        [req setResultBlock:^(SSRequest *request, id obj) {
            
            if ([obj isKindOfClass:[NSArray class]]) {
            
            NSLog(@"%@",rateComArr);
            NSArray*arr = obj;
            [arr writeToFile:[self filePath:@"rate"] atomically:YES];
            NSMutableArray *endArr = [NSMutableArray array];
            
            for (int j = 0; j<rateComArr.count; j++) {
                NSMutableArray*ratearr = [NSMutableArray array];
                NSString*comID = [rateComArr objectAtIndex:j];
                for (int i = 0; i<arr.count; i++) {
                    SS_rate*rate= [[SS_rate alloc]init];
                    rate.COMPANYID = [[arr objectAtIndex:i]valueForKey:@"COMPANYID"];
                    rate.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
                    rate.RATE = [[arr objectAtIndex:i]valueForKey:@"RATE"];
                    rate.DATE = [[arr objectAtIndex:i]valueForKey:@"DATE"];
                    if ([comID isEqualToString: rate.COMPANYID]) {
                        [ratearr addObject:rate];
                    }
                }
                [endArr addObject:ratearr];
            }
            
            if (finishBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    finishBlock(endArr);
                });
            }
            else
            {
                NSLog(@"获取数据有问题");
            }
            }
        }];

    }
    else
    {
        NSLog(@"%@",rateComArr);
        NSArray*arr = [NSArray arrayWithContentsOfFile:[self filePath:@"rate"]];
        NSMutableArray *endArr = [NSMutableArray array];
        
        for (int j = 0; j<rateComArr.count; j++) {
            NSMutableArray*ratearr = [NSMutableArray array];
            NSString*comID = [rateComArr objectAtIndex:j];
            for (int i = 0; i<arr.count; i++) {
                SS_rate*rate= [[SS_rate alloc]init];
                rate.COMPANYID = [[arr objectAtIndex:i]valueForKey:@"COMPANYID"];
                rate.NAME = [[arr objectAtIndex:i]valueForKey:@"NAME"];
                rate.RATE = [[arr objectAtIndex:i]valueForKey:@"RATE"];
                rate.DATE = [[arr objectAtIndex:i]valueForKey:@"DATE"];
                if ([comID isEqualToString: rate.COMPANYID]) {
                    [ratearr addObject:rate];
                }
            }
            [endArr addObject:ratearr];
        }
        
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(endArr);
            });
        }
        else
        {
            NSLog(@"获取数据有问题");
        }
        
    }
}

-(NSString *)filePath:(NSString*)name
{
    NSString *homeDic = NSHomeDirectory();
    NSString *libDic = [homeDic stringByAppendingPathComponent:@"Library"];
    NSString *cahPath = [libDic stringByAppendingPathComponent:@"Caches"];
    NSString *filePath = [cahPath stringByAppendingPathComponent:name];
    return filePath;
}

-(BOOL)checkNetwork
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;
            break;
    }
	return isExistenceNetwork;
}
    @end
