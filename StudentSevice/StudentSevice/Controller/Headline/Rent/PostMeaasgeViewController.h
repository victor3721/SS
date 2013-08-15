//
//  PostMeaasgeViewController.h
//  StudentSevice
//
//  Created by victor on 13-3-28.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface PostMeaasgeViewController : UIViewController<UITextViewDelegate,MBProgressHUDDelegate>
{
    int changeNumber;
    NSString *em;
    NSIndexPath *_indexPath;
    MBProgressHUD *HUD;
    UITextView *_postViewTextView;
    NSString *_emoticonName;
}
@property(nonatomic,retain)UITextView *postViewTextView;
@property(nonatomic,retain)NSIndexPath *indexPath;
@property(nonatomic,retain)NSString *emoticonName;

@end
