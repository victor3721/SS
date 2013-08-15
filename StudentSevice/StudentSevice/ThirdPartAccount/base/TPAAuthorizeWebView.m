//
//  TPAAuthorizeWebView.m
//  ThirdPartAccount
//
//  Created by Martin Yin on 12-7-18.
//  Copyright (c) 2012年 Autonavi. All rights reserved.
//

#import "TPAAuthorizeWebView.h"
#import <QuartzCore/QuartzCore.h>



@interface TPAAuthorizeWebView (Private)

- (void)bounceOutAnimationStopped;
- (void)bounceInAnimationStopped;
- (void)bounceNormalAnimationStopped;
- (void)allAnimationsStopped;

- (UIInterfaceOrientation)currentOrientation;
- (void)sizeToFitOrientation:(UIInterfaceOrientation)orientation;
- (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation;
- (BOOL)shouldRotateToOrientation:(UIInterfaceOrientation)orientation;

- (void)addObservers;
- (void)removeObservers;

@end

static NSString *_closeButtonImageFile = @"images/weiboClose.png";
@implementation TPAAuthorizeWebView
@synthesize delegate = _delegate;

+ (void)setCloseButtonImageFile:(NSString *)imageFile {
	if(_closeButtonImageFile) {
		[_closeButtonImageFile release];
	}
	
	_closeButtonImageFile = [imageFile copy];
}

#pragma mark - WBAuthorizeWebView Life Circle

- (id)init {
	self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
	if (self) {
		// background settings
		[self setBackgroundColor:[UIColor clearColor]];
		[self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
		// add the panel view
		_panelView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 300, 440)];
        //		[_panelView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.55]];
		[[_panelView layer] setMasksToBounds:NO]; // very important
		[[_panelView layer] setCornerRadius:10.0];
		[self addSubview:_panelView];
        
		// add the conainer view
		_containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 280, 390)];
		[[_containerView layer] setBorderColor:[UIColor colorWithRed:0. green:0. blue:0. alpha:0.7].CGColor];
		[[_containerView layer] setBorderWidth:1.0];
        
		// add the web view
		_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 280, 390)];
		[_webView setDelegate:self];
        //		_webView.scalesPageToFit = YES;
		[_containerView addSubview:_webView];
		
		[_panelView addSubview:_containerView];
		
		if(_closeButtonImageFile) {
			_closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
			[_closeButton setImage:[UIImage imageNamed: _closeButtonImageFile] forState:UIControlStateNormal];
			[_closeButton sizeToFit];
			[_closeButton setCenter:CGPointMake(_containerView.frame.origin.x+_containerView.frame.size.width,
												_containerView.frame.origin.y)];
			[_closeButton addTarget:self action:@selector(onCloseButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
			[_panelView addSubview:_closeButton];
		}
		
		_indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[_indicatorView setCenter:CGPointMake(160, 240)];
		[self addSubview:_indicatorView];
	}
	return self;
}


- (void)dealloc {
	[_panelView release]; _panelView = nil;
	[_containerView release]; _containerView = nil;
	[_webView release]; _webView = nil;
	[_indicatorView release]; _indicatorView = nil;
	
	[super dealloc];
}

#pragma mark Actions

- (void)onCloseButtonTouched:(id)sender {
	[self hide:YES];
}

#pragma mark Orientations

- (UIInterfaceOrientation)currentOrientation {
	return [UIApplication sharedApplication].statusBarOrientation;
}

- (void)sizeToFitOrientation:(UIInterfaceOrientation)orientation {
	[self setTransform:CGAffineTransformIdentity];
//    
//    //CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    
//    CGRect screenBounds = CGRectMake(0, 0, 512, 748);
//    
//
//    if (UIInterfaceOrientationIsLandscape(orientation))
//    {
//		[self setFrame: screenBounds];
//		[_panelView setFrame: CGRectMake(screenBounds.origin.x, screenBounds.origin.y+10, screenBounds.size.width, screenBounds.size.height+20)];
//		[_containerView setFrame: CGRectMake(0, 0, _panelView.bounds.size.width, _panelView.bounds.size.height)];
//		[_webView setFrame: CGRectMake(0, 0, 512, 748)];
//		[_indicatorView setCenter:CGPointMake(512/2, 748/2)];
//	}
//    else
//    {
//		[self setFrame: screenBounds];
//        CGFloat topMargin = 0.0f;
//        if (screenBounds.size.height > 500)
//        {
//            topMargin = 44.0f;
//        }
//		[_panelView setFrame: CGRectMake(screenBounds.origin.x, screenBounds.origin.y+10+topMargin, screenBounds.size.width, screenBounds.size.height+20-topMargin)];
//		[_containerView setFrame: CGRectMake(0, 10, _panelView.bounds.size.width, _panelView.bounds.size.height-20-50)];
//		[_webView setFrame: _containerView.bounds];
//		[_indicatorView setCenter:CGPointMake(160, 240)];
//	}
//    
//    if (_closeButtonImageFile)
//    {
//        _closeButton.center = CGPointMake(_containerView.frame.origin.x+_containerView.frame.size.width-50,
//                                          _containerView.frame.origin.y+_containerView.frame.size.height);
//    }
//	
//	[self setCenter:CGPointMake(748/2, 1024/2)];
//	[self setTransform:[self transformForOrientation:orientation]];
//	
//	_previousOrientation = orientation;
    

CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
	if (UIInterfaceOrientationIsLandscape(orientation))
    {
		[self setFrame: screenBounds];
		[_panelView setFrame: CGRectMake(screenBounds.origin.x, screenBounds.origin.y+10, screenBounds.size.width, screenBounds.size.height+20)];
		[_containerView setFrame: CGRectMake(0, 10, _panelView.bounds.size.width, _panelView.bounds.size.height-20-40)];
		[_webView setFrame: _containerView.bounds];
		[_indicatorView setCenter:CGPointMake(240, 160)];
	}
    else
    {
		[self setFrame: screenBounds];
        CGFloat topMargin = 0.0f;
        if (screenBounds.size.height > 500)
        {
            topMargin = 44.0f;
        }
		[_panelView setFrame: CGRectMake(screenBounds.origin.x, screenBounds.origin.y+10+topMargin, screenBounds.size.width, screenBounds.size.height+20-topMargin)];
		[_containerView setFrame: CGRectMake(0, 10, _panelView.bounds.size.width, _panelView.bounds.size.height-20-50)];
		[_webView setFrame: _containerView.bounds];
		[_indicatorView setCenter:CGPointMake(160, 240)];
	}
    
    if (_closeButtonImageFile)
    {
        _closeButton.center = CGPointMake(_containerView.frame.origin.x+_containerView.frame.size.width-50,
                                          _containerView.frame.origin.y+_containerView.frame.size.height);
    }
	
	[self setCenter:CGPointMake(160, 240)];
	[self setTransform:[self transformForOrientation:orientation]];
	
	_previousOrientation = orientation;

}

- (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
	if (orientation == UIInterfaceOrientationLandscapeLeft) {
		return CGAffineTransformMakeRotation(-M_PI / 2);
	} else if (orientation == UIInterfaceOrientationLandscapeRight) {
		return CGAffineTransformMakeRotation(M_PI / 2);
	} else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
		return CGAffineTransformMakeRotation(-M_PI);
	} else {
		return CGAffineTransformIdentity;
	}
}

- (BOOL)shouldRotateToOrientation:(UIInterfaceOrientation)orientation {
	if (orientation == _previousOrientation) {
		return NO;
	} else {
		return (orientation == UIInterfaceOrientationLandscapeLeft ||
				orientation == UIInterfaceOrientationLandscapeRight ||
				orientation == UIInterfaceOrientationPortrait ||
				orientation == UIInterfaceOrientationPortraitUpsideDown);
	}
	return YES;
}

#pragma mark Obeservers
- (void)addObservers {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(deviceOrientationDidChange:)
												 name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}

- (void)removeObservers {
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}


#pragma mark Animations
- (void)bounceOutAnimationStopped {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.13];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(bounceInAnimationStopped)];
	[_panelView setAlpha:0.8];
	[_panelView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)];
	[UIView commitAnimations];
}

- (void)bounceInAnimationStopped {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.13];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(bounceNormalAnimationStopped)];
	[_panelView setAlpha:1.0];
	[_panelView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
	[UIView commitAnimations];
}

- (void)bounceNormalAnimationStopped {
	[self allAnimationsStopped];
}

- (void)allAnimationsStopped {
	// nothing shall be done here
}

#pragma mark Dismiss

- (void)hideAndCleanUp {
	[_webView stopLoading];
	
	if([_delegate respondsToSelector:@selector(authorizeWebViewClosed:)]) {
		[_delegate authorizeWebViewClosed:self];
	}
	
	[self removeObservers];
	[self removeFromSuperview];
}

#pragma mark - WBAuthorizeWebView Public Methods
- (void)loadRequestWithURL:(NSURL *)url {
	NSURLRequest *request =[NSURLRequest requestWithURL:url
											cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
										timeoutInterval:60.0];
//	[_webView setScalesPageToFit:YES];
	NSInteger OSMainVersion = [[[UIDevice currentDevice] systemVersion] integerValue];
	if(OSMainVersion >= 6) {
		[_webView setSuppressesIncrementalRendering:YES];
	}

//	if(OSMainVersion >= 5) {
//		_webView.scrollView.scrollEnabled = NO;
//	}

	[_webView loadRequest:request];
}

- (void)show:(BOOL)animated {
	[self sizeToFitOrientation:[self currentOrientation]];
	
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	if (!window) {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
	[window addSubview:self];
	
	if (animated) {
		[_panelView setAlpha:0];
		CGAffineTransform transform = CGAffineTransformIdentity;
		[_panelView setTransform:CGAffineTransformScale(transform, 0.3, 0.3)];
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(bounceOutAnimationStopped)];
		[_panelView setAlpha:0.5];
		[_panelView setTransform:CGAffineTransformScale(transform, 1.1, 1.1)];
		[UIView commitAnimations];
	} else {
		[self allAnimationsStopped];
	}
	
	[self addObservers];
}

- (void)hide:(BOOL)animated {
	if (animated) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(hideAndCleanUp)];
		[self setAlpha:0];
		[UIView commitAnimations];
	} else {
		[self hideAndCleanUp];
	}
}

#pragma mark - UIDeviceOrientationDidChangeNotification Methods
- (void)deviceOrientationDidChange:(id)object {
	UIInterfaceOrientation orientation = [self currentOrientation];
	if ([self shouldRotateToOrientation:orientation]) {
		NSTimeInterval duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:duration];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[self sizeToFitOrientation:orientation];
		[UIView commitAnimations];
	}
}

#pragma mark - UIWebViewDelegate Methods
- (void)webViewDidStartLoad:(UIWebView *)aWebView {
	[_indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
	[_indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error {
	[_indicatorView stopAnimating];
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//	NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
//	
//	if (range.location != NSNotFound) {
//		NSString *code = [request.URL.absoluteString substringFromIndex:range.location + range.length];
//		
//		if ([_delegate respondsToSelector:@selector(authorizeWebView:didReceiveAuthorizeInfo:)]) {
//			[_delegate authorizeWebView:self didReceiveAuthorizeCode:code];
//			return NO;
//		}
//	}

	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
								 userInfo:nil];

	return YES;
}

@end
