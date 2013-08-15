//
//  SSRequest.h
//  StudentServices
//
//  Created by victor on 13-3-18.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SSRequest;


typedef void (^ SSRequestBlock)(SSRequest * request,id obj);
@interface SSRequest : NSObject
{
    SSRequestBlock  resultBlock;
    SSRequestBlock  failBlock;
    SSRequestBlock  responseBlock;
    SSRequestBlock  rawDataBlock;
    
    NSString*url;
    NSString*httpMethod;
    NSDictionary*params;
    NSURLConnection*connection;
    NSMutableData*responseData;
}


@property(nonatomic,retain)NSMutableData * mutableData;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *httpMethod;
@property (nonatomic, retain) NSDictionary *params;
@property(nonatomic,retain) NSData *postData;
@property(nonatomic,retain)NSString*postStr;


-(void)setResponseBlock:(SSRequestBlock)block;
-(void)setFailBlock:(SSRequestBlock)block;
-(void)setRawDataBlock:(SSRequestBlock)block;
-(void)setResultBlock:(SSRequestBlock)block;


- (void)requestWithURLS:(NSString *)urls
             httpMethod:(NSString *)httpMethods
                 params:(NSDictionary *)paramss;

- (void)connect;
@end
