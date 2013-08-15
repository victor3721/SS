//
//  WeiboCell.m
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "WeiboCell.h"
#define thumbNail_size 40
#define image_size 80
#define space 5
#define  RECT(x,y,w,h) CGRectMake(x, y, w, h) 
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomImageView.h"
#import "Reachability.h"

@implementation WeiboCell
@synthesize thumbNail = _thumbNail;
@synthesize name = _name;
@synthesize time = _time;
@synthesize text = _text;
@synthesize image = _image;
@synthesize backView = _backView;
@synthesize status = _status;
@synthesize weiBoTextLab = _weiBoTextLab;

-(void)dealloc
{
    self.thumbNail = nil;
    self.name = nil;
    self.time = nil;
    self.text = nil;
    self.image = nil;
    self.backView = nil;
    self.status = nil;
    self.weiBoTextLab = nil;
    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.backView = [[[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"weiboCellBack"]resizableImageWithCapInsets:UIEdgeInsetsMake(15, 40, 15,10)]]autorelease];
        self.backView.frame = CGRectMake(10, 20, 300, 0);
        self.backView.userInteractionEnabled = YES;
        
        self.thumbNail = [[[UIImageView alloc]initWithFrame:CGRectMake(30, 2 ,20 ,20)] autorelease];
        
        self.name = [[[UILabel alloc]initWithFrame:CGRectMake(55, 5 ,180 ,15)]autorelease];
        self.name.backgroundColor = [UIColor clearColor];
        self.name.textColor = [UIColor redColor];
        self.name.font = [UIFont fontWithName:@"Arial" size:10];
        
//        self.text = [[[OHAttributedLabel alloc]initWithFrame:RECT(5, 13, 250, 0)]autorelease];
//        self.text.delegate = self;
//        self.text.backgroundColor = [UIColor clearColor];
        
        self.weiBoTextLab = [[[UILabel alloc]initWithFrame:RECT(5, 13, 290, 0)]autorelease];
        self.weiBoTextLab.backgroundColor = [UIColor clearColor];
        self.weiBoTextLab.lineBreakMode = UILineBreakModeWordWrap;
        self.weiBoTextLab.textColor = [UIColor whiteColor];
        self.weiBoTextLab.font = [UIFont fontWithName:@"Arial" size:14];
        self.weiBoTextLab.numberOfLines = 0;
        
        self.image = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 0 ,80 ,80)]autorelease];
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        self.image.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]autorelease];
        [self.image addGestureRecognizer:tap];
        
        //设置选择背景色为透明
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.thumbNail];
        [self.contentView addSubview:self.name];
        [self.backView addSubview:self.text];
        [self.backView addSubview:self.weiBoTextLab];
        [self.backView addSubview:self.image];
        [self.contentView addSubview:self.backView];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    
}

-(void)tap
{
    if ([self isExistenceNetwork]) {
        UIResponder *a = [self nextResponder];
        while (![a isKindOfClass:[UIViewController class]]) {
            a = a.nextResponder;
        }
        CustomImageView *image = [[[CustomImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-20-44-39) WithImageStr:[self.status bigImage]]autorelease];
        [((UIViewController *)a).view addSubview:image];
        if (![[self.status bigImage] hasSuffix:@"jpg"]) {
            [image loadImageWithStr:self.status.bigImage];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(BOOL)isExistenceNetwork
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
	if (!isExistenceNetwork) {
		UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"亲！！网络不给力啊" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
		[myalert show];
		[myalert release];
	}
	return isExistenceNetwork;
}


@end
