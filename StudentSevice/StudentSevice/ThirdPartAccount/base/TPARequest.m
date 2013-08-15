//
//  TPARequest.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-17.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPARequest.h"

#define kSinaRequestTimeOutInterval	8.0f

@implementation TPARequest
@synthesize url = _url;
@synthesize httpMethod = _httpMethod;
@synthesize params = _params;
@synthesize postDataType = _postDataType;
@synthesize httpHeaderFields = _httpHeaderFields;
@synthesize delegate = _delegate;

- (id)initWithURL:(NSString *)url delegate:(id<TPARequestDelegate>)delegate {
	return [self initWithURL:url delegate:delegate httpMethod:@"GET" params:nil postDataType:kTPARequestPostDataTypeNone httpHeaderFields:nil];
}

- (id)initWithURL:(NSString *)url
		 delegate:(id<TPARequestDelegate>)delegate
	   httpMethod:(NSString *)httpMethod
		   params:(NSDictionary *)params
	 postDataType:(TPARequestPostDataType)postDataType {
	return [self initWithURL:url delegate:delegate httpMethod:httpMethod params:params postDataType:postDataType httpHeaderFields:nil];
}

- (id)initWithURL:(NSString *)url
		 delegate:(id<TPARequestDelegate>)delegate
	   httpMethod:(NSString *)httpMethod
		   params:(NSDictionary *)params
	 postDataType:(TPARequestPostDataType)postDataType
 httpHeaderFields:(NSDictionary *)httpHeaderFields {
	self = [super init];
	if(self) {
		self.url = url;
		self.delegate = delegate;
		self.httpMethod = httpMethod;
		self.params = params;
		self.postDataType = postDataType;
		self.httpHeaderFields = httpHeaderFields;
	}
	
	return self;
}

- (void)dealloc {
	_delegate = nil;
	[_connection cancel];
	
	[_url release]; _url = nil;
	[_httpMethod release]; _httpMethod = nil;
	[_params release]; _params = nil;
	[_httpHeaderFields release]; _httpHeaderFields = nil;

	[_responseData release]; _responseData = nil;

	[_connection release]; _connection = nil;

	[super dealloc];
}

- (void)connect {
	NSString *urlString = _url;
	if(_params)
		urlString = [TPAURLGenerator serializeURL:_url params:_params httpMethod:_httpMethod];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
														   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
													   timeoutInterval:kSinaRequestTimeOutInterval];
	[request setHTTPMethod:_httpMethod];
	
	if ([_httpMethod isEqualToString:@"POST"]) {
		if (_postDataType == kTPARequestPostDataTypeMultipart) {
			NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", kTPARequestStringBoundary];
			[request setValue:contentType forHTTPHeaderField:@"Content-Type"];
		}
		
		[request setHTTPBody:[TPAURLGenerator postBodyFromParams:_params postDataType:_postDataType]];
	}
	
	for (NSString *key in [_httpHeaderFields keyEnumerator]) {
		[request setValue:[_httpHeaderFields objectForKey:key] forHTTPHeaderField:key];
	}
	
	_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)disconnect {
    [_connection cancel];

    [_responseData release]; _responseData = nil;
    
    [_connection release]; _connection = nil;
}

- (void)handleResponseData {
	[NSException raise:NSInternalInconsistencyException
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)failedWithError:(NSError *)error {
	[NSException raise:NSInternalInconsistencyException
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
								 userInfo:nil];
	return nil;
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	_responseData = [[NSMutableData alloc] init];
	
	if([_delegate respondsToSelector:@selector(request:didReceiveResponse:)]) {
		[_delegate request:self didReceiveResponse:response];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
	[self handleResponseData];
	
	[self disconnect];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
	[self failedWithError:error];
	
	[self disconnect];
}

@end
