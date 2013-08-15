//
//  Global.h
//  StudentSevice
//
//  Created by Liu on 13-3-18.
//  Copyright (c) 2013年 Sign. All rights reserved.
//

#ifndef StudentSevice_Global_h
#define StudentSevice_Global_h

//图片的define
#define tabFresh @"tabbar_funny_select"
#define tabFresh_unselect @"tabbar_funny_unselect"
#define tabHeadline @"tabbar_firstnews_select"
#define tabHeadline_unselect @"tabbar_firstnews_unselect"
#define tabRecommend @"tabbar_app_select"
#define tabRecommend_unselect @"tabbar_app_unselect"
#define tabMore @"tabbar_more_select"
#define tabMore_unselect @"tabbar_more_unselect"
#define navigation_background @"navigation_background"
#define photoPlaceHolder @"settings_accounts_icon"
#define menuButtonBg_select @"top_moreBtu_selected"
#define menuButtonBg_unselect @"top_moreBtu_unselected"
#define ChangeTitleNotification @"ChangeTitleNotification"
#define adCellBtuImg @"contentview_pulloutButton"
#define PlaceHolder_photo @"messages_photo_default_image"
#define PlaceHolder_image @"page_image_loading"

//整个布局中的高度和宽度
#define screen_height [UIScreen mainScreen].bounds.size.height
#define screen_width [UIScreen mainScreen].bounds.size.width

//请求拼接的网址
#define request_url @"statuses/user_timeline.json"
#define user_url @"statuses/friends_timeline.json"
#define IIS_url @"https://iis.ucsi.edu.my/student/Login.aspx"

//富文本配置的一些参数
#define STRING @"AttributedString"
#define IMAGES @"images"
#define USERS @"users"
#define TOPICS @"topics"
#define TEXT_HEIGHT @"textHeight"
#define TEXT_FONT [UIFont fontWithName:@"Arial" size:14]
#define TEXT_WIDTH 260

//微博的一些参数
#define WEIBONAME @"留_学_生"
#define WEIBOCOUNT @"30"
#define SinaWeiboAuthData @"SinaWeiboAuthData"
#define AccessTokenKey @"AccessTokenKey"
#define ExpirationDateKey @"ExpirationDateKey"
#define UserIDKey @"UserIDKey"
#endif
