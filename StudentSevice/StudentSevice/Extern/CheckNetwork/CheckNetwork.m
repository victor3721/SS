//
//  CheckNetwork.m
//  iphone.network1
//
//  Created by wangjun on 10-12-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CheckNetwork.h"
#import "Reachability.h"
@implementation CheckNetwork
+(BOOL)isExistenceNetwork
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
         //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您现在正在使用3G网络,请注意流量" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            [myalert show];
            [myalert release];
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;
            UIAlertView *myalert1 = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您现在正在使用3G网络,请注意流量" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            [myalert1 show];
            [myalert1 release];
            break;
    }
	if (!isExistenceNetwork) {
		UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"亲！！网络不给力啊" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
		[myalert show];
		[myalert release];
	}
	return isExistenceNetwork;
}
@end
