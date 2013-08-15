//
//  SinaManager.m
//  Sina
//
//  Created by victor on 13-1-17.
//  Copyright (c) 2013年 victor. All rights reserved.
//

#import "SinaManager.h"
#import "InstantiateaTool.h"
#import "Reachability.h"
#import "AppDelegate.h"
@implementation SinaManager
@synthesize sinaWeibo = _sinaWeibo;

-(id)init
{
    self = [super init];
    if (self)
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.sinaWeibo = delegate.sinaWeibo;
    }
    return self;
}


-(void)setFinishBlock:(SinaManagerBlock)block
{
    finishBlock = block;
}

//判断本地是否又缓存，有先从本地获得，没有走另一个方法
-(void)readStatuses
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[self filePath]])
    {
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
        //进行数据分析和处理，提取有用信息
        NSData *rData=[[NSData alloc] initWithContentsOfFile:[self filePath]];
        NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:rData];
        NSArray *statuses=[unarchiver decodeObjectForKey:@"bowen"];
        
        NSLog(@"%@",statuses);
        
        for (NSDictionary * sta in statuses)
        {
            Status *status = [InstantiateaTool getInstanceWithClassName:@"Status" JsonDic:sta];
            [arr addObject:status];
        }
        if (finishBlock)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(arr);
            });
        }
        else
        {
            NSLog(@"获取微博相关数据有问题");
        }
    }
    else
    {
        NSMutableDictionary *paraDic =[NSMutableDictionary dictionary];
        [paraDic setValue:WEIBONAME forKey:@"screen_name"];
        [paraDic setValue:WEIBOCOUNT forKey:@"count"];
        [self readStatusesWithURL:request_url Params:paraDic];
    }
    
}

//没有缓存的时候或者是加载更多的时候走此方法以及下拉刷新的时候
-(void)readStatusesWithURL:(NSString *)url Params:(NSMutableDictionary *)params
{
    
    
    SinaWeiboRequest * req = [self.sinaWeibo requestWithURL:url params:params httpMethod:@"GET" delegate:nil];
    
    [req setFailBlock:^(SinaWeiboRequest *request, id obj) {
        if (finishBlock)
        {
            finishBlock(nil);
        }
    }];
    [req setResultBlock:^(SinaWeiboRequest *request, id obj) {

        NSLog(@"%@",obj);
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
        //进行数据分析和处理，提取有用信息
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSArray * statuses = [obj valueForKey:@"statuses"];
            
            NSMutableData *data=[[NSMutableData alloc] init];
            NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
            [archiver encodeObject:statuses forKey:@"bowen"];
            [archiver finishEncoding];
            [data writeToFile:[self filePath] atomically:YES];

            for (NSDictionary * sta in statuses)
            {
                Status *status = [InstantiateaTool getInstanceWithClassName:@"Status" JsonDic:sta];
                [arr addObject:status];
            }
            
            if (finishBlock)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    finishBlock(arr);
                });
            }
            
        }
        else
        {
            NSLog(@"获取微博相关数据有问题");
        }
        
    }];
    [req connect];
}

-(void)readUserWithURL:(NSString *)url Params:(NSMutableDictionary *)params
{
    SinaWeiboRequest * req = [self.sinaWeibo requestWithURL:url params:params httpMethod:@"GET" delegate:nil];
    [req setFailBlock:^(SinaWeiboRequest *request, id obj) {
        if (finishBlock)
        {
            finishBlock(nil);
        }
    }];
    [req setResultBlock:^(SinaWeiboRequest *request, id obj) {
        
        NSLog(@"%@",obj);
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
        //进行数据分析和处理，提取有用信息
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSArray * statuses = [obj valueForKey:@"statuses"];
            
            for (NSDictionary * sta in statuses)
            {
                Status *status = [InstantiateaTool getInstanceWithClassName:@"Status" JsonDic:sta];
                [arr addObject:status];
            }
            
            if (finishBlock)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    finishBlock(arr);
                });
            }
            
        }
        else
        {
            NSLog(@"获取微博相关数据有问题");
        }
        
    }];
    [req connect];
}

-(NSString *)filePath
{
    NSString *homeDic = NSHomeDirectory();
    NSString *libDic = [homeDic stringByAppendingPathComponent:@"Library"];
    NSString *cahPath = [libDic stringByAppendingPathComponent:@"Caches"];
    NSString *filePath = [cahPath stringByAppendingPathComponent:@"weibo"];
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
