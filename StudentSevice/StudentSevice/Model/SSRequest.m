//
//  SSRequest.m
//  StudentServices
//
//  Created by victor on 13-3-18.
//  Copyright (c) 2013年 SS. All rights reserved.
//

#import "SSRequest.h"
#import "URLEncode.h"
#define SSRequestTimeOutInterval   180.0
#define SSRequestStringBoundary    @"293iosfksdfkiowjksdf31jsiuwq003s02dsaffafass3qw"
@implementation SSRequest
@synthesize params =params;
@synthesize httpMethod = httpMethod;
@synthesize url = url;

//设置块
-(void)setResultBlock:(SSRequestBlock)block
{
    [resultBlock release];
    resultBlock = [block copy];
}
-(void)setFailBlock:(SSRequestBlock)block
{
    [failBlock release];
    failBlock = [block copy];
}
-(void)setRawDataBlock:(SSRequestBlock)block
{
    [rawDataBlock release];
    rawDataBlock = [block copy];
}
-(void)setResponseBlock:(SSRequestBlock)block
{
    [responseBlock release];
    responseBlock = [block copy];
}

//实例化方法
- (void)requestWithURLS:(NSString *)urls
             httpMethod:(NSString *)httpMethods
                 params:(NSDictionary *)paramss
{
    self.url = urls;
    self.httpMethod = httpMethods;
    self.params = paramss;
    
    if ([self.httpMethod isEqualToString:@"post"]) {
        [self connectWithPost];
    }
    else
    {
        [self connect];
    }
}


//自定义get链接方法
- (void)connect
{
    self.url = [URLEncode serializeURL:self.url params:self.params httpMethod:self.httpMethod];
    NSLog(@"%@",self.url);
    NSMutableURLRequest* request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]
                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                        timeoutInterval:SSRequestTimeOutInterval];
    
    [request setHTTPMethod:self.httpMethod];
    if ([self.httpMethod isEqualToString: @"POST"])
    {
        BOOL hasRawData = NO;
        [request setHTTPBody:[self postBodyHasRawData:&hasRawData]];
        
        if (hasRawData)
        {
            NSString* contentType = [NSString
                                     stringWithFormat:@"multipart/form-data; boundary=%@", SSRequestStringBoundary];
            [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        }
    }
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

//自定义post链接方法
- (void)connectWithPost
{
//    self.postStr = [URLEncode serializeParams:self.params httpMethod:self.httpMethod];
//    self.postData = [self.postStr dataUsingEncoding:4];
//    
//    NSString * md5 = [self getMD5String:self.url];
//    self.url = [self.url stringByAppendingFormat:@"%@",md5];
    
    NSLog(@"%@",self.url);
    NSLog(@"%@",self.postStr);
    NSMutableURLRequest* request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]
                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                        timeoutInterval:SSRequestTimeOutInterval];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:self.postData];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)disconnect
{
    [responseData release];
	responseData = nil;
    
    [connection cancel];
    [connection release], connection = nil;
}

#pragma mark - 网络链接的代理方法
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc] init];
    if (responseBlock)
    {
        responseBlock(self,response);
    }
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
	return nil;
}

-(void) connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    
    [self handleResponseData:responseData];
    
	[responseData release];
	responseData = nil;
    
    [connection cancel];
	[connection release];
	connection = nil;
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	[self failedWithError:error];
	
	[responseData release];
	responseData = nil;
    
    [connection cancel];
	[connection release];
	connection = nil;
}

//数据请求完毕调用此方法
- (void)handleResponseData:(NSData *)data
{
    if (rawDataBlock)
    {
        rawDataBlock(self,data);
    }
	
	NSError *error = nil;
    id result =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
	
	if (error)
	{
		[self failedWithError:error];
	}
	else
	{
        NSInteger error_code = 0;
        if([result isKindOfClass:[NSDictionary class]])
        {
            [[result objectForKey:@"error_code"] intValue];
        }
        
        if (error_code != 0)
        {
        }
        else
        {
            if (resultBlock)
            {
                resultBlock(self,(result == nil ? data : result));
            }
        }
	}
}

- (void)failedWithError:(NSError *)error
{
    if (failBlock)
    {
        failBlock(self,error);
    }
}



- (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString
{
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
}
- (NSMutableData *)postBodyHasRawData:(BOOL*)hasRawData
{
    NSString *bodyPrefixString = [NSString stringWithFormat:@"--%@\r\n", SSRequestStringBoundary];
    NSString *bodySuffixString = [NSString stringWithFormat:@"\r\n--%@--\r\n", SSRequestStringBoundary];
    
    NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionary];
    
    NSMutableData *body = [NSMutableData data];
    [self appendUTF8Body:body dataString:bodyPrefixString];
    
    for (id key in [params keyEnumerator])
    {
        if (([[params valueForKey:key] isKindOfClass:[UIImage class]]) || ([[params valueForKey:key] isKindOfClass:[NSData class]]))
        {
            [dataDictionary setObject:[params valueForKey:key] forKey:key];
            continue;
        }
        
        [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", key, [params valueForKey:key]]];
        [self appendUTF8Body:body dataString:bodyPrefixString];
    }
    
    if ([dataDictionary count] > 0)
    {
        *hasRawData = YES;
        for (id key in dataDictionary)
        {
            NSObject *dataParam = [dataDictionary valueForKey:key];
            
            if ([dataParam isKindOfClass:[UIImage class]])
            {
                NSData* imageData = UIImagePNGRepresentation((UIImage *)dataParam);
                [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"file\"\r\n", key]];
                [self appendUTF8Body:body dataString:@"Content-Type: image/png\r\nContent-Transfer-Encoding: binary\r\n\r\n"];
                [body appendData:imageData];
            }
            else if ([dataParam isKindOfClass:[NSData class]])
            {
                [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"file\"\r\n", key]];
                [self appendUTF8Body:body dataString:@"Content-Type: content/unknown\r\nContent-Transfer-Encoding: binary\r\n\r\n"];
                [body appendData:(NSData*)dataParam];
            }
            [self appendUTF8Body:body dataString:bodySuffixString];
        }
    }
    
    return body;
}
@end
