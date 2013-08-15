//
//  TPARequest.h
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAURLGenerator.h"

@class TPARequest;

@protocol TPARequestDelegate <NSObject>

@optional
- (void)request:(TPARequest *)request didReceiveResponse:(NSURLResponse *)response;
- (void)request:(TPARequest *)request didReceiveRawData:(NSData *)data;
- (void)request:(TPARequest *)request didFailWithError:(NSError *)error;
- (void)request:(TPARequest *)request didFinishLoadingWithResult:(id)result;

@end

@interface TPARequest : NSObject {
    NSURLConnection         *_connection;
    NSMutableData           *_responseData;
}

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *httpMethod;
@property (strong, nonatomic) NSDictionary *params;
@property (assign, nonatomic) TPARequestPostDataType postDataType;
@property (strong, nonatomic) NSDictionary *httpHeaderFields;
@property (assign, nonatomic) id<TPARequestDelegate> delegate;

- (id)initWithURL:(NSString *)url delegate:(id<TPARequestDelegate>)delegate;

- (id)initWithURL:(NSString *)url
		 delegate:(id<TPARequestDelegate>)delegate
	   httpMethod:(NSString *)httpMethod
		   params:(NSDictionary *)params
	 postDataType:(TPARequestPostDataType)postDataType;

- (id)initWithURL:(NSString *)url
		 delegate:(id<TPARequestDelegate>)delegate
	   httpMethod:(NSString *)httpMethod
		   params:(NSDictionary *)params
	 postDataType:(TPARequestPostDataType)postDataType
 httpHeaderFields:(NSDictionary *)httpHeaderFields;

- (void)connect;
- (void)disconnect;

- (void)handleResponseData;
- (void)failedWithError:(NSError *)error;

- (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo;

@end
