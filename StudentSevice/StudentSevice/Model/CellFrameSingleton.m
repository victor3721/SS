//
//  CellFrameSingleton.m
//  StudentSevice
//
//  Created by victor on 13-3-29.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#import "CellFrameSingleton.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define  RECT(x,y,w,h) CGRectMake(x, y, w, h)
static CellFrameSingleton *cellFrameSingleton;
@implementation CellFrameSingleton


+(CellFrameSingleton*)shareCellFrame
{
    if (cellFrameSingleton == nil) {
        cellFrameSingleton = [[CellFrameSingleton alloc]init];
    }
    return cellFrameSingleton;
}

-(void)changeFrameWithCell:(WeiboCell*)cell
{

        CGRect rect = cell.backView.frame;
        rect.size.height = cell.status.height_cell-20;
        cell.backView.frame = rect;


        CGRect rect1 = cell.weiBoTextLab.frame;
        rect1.size.height = cell.status.height_text;
        cell.weiBoTextLab.frame = rect1;

    
    
    //是否是转发微博
    if (cell.status.retweeted_status)
    {
        cell.weiBoTextLab.text = cell.status.retweeted_status.text;
    }
    else
    {
        cell.weiBoTextLab.text = cell.status.text;
    }
    
    
    
    //是否有图片
    if (cell.status.haveImage)
    {
        CGRect rect = cell.image.frame;
        rect.origin.y = 20+cell.status.height_text;
        cell.image.frame = rect;
        
        if (cell.status.retweeted_status)
        {
            [cell.image setImageWithURL:[NSURL URLWithString:cell.status.retweeted_status.thumbnail_pic] placeholderImage:[UIImage imageNamed:PlaceHolder_image]];
        }
        else
        {
            [cell.image setImageWithURL:[NSURL URLWithString:cell.status.thumbnail_pic] placeholderImage:[UIImage imageNamed:PlaceHolder_image]];
        }
    }
    
    
    
    if (cell.status.retweeted_status.user.name)
    {
        cell.name.text = [NSString stringWithFormat:@"%@%@",@"来自",cell.status.retweeted_status.user.name];
    }
    else
    {
        cell.name.text = [NSString stringWithFormat:@"%@%@",@"来自",cell.status.user.name];
    }
    
    [cell.thumbNail setImageWithURL:[NSURL URLWithString:cell.status.user.profile_image_url] placeholderImage:[UIImage imageNamed:PlaceHolder_photo]];
    }

@end
