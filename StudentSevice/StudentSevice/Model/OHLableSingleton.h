//
//  OHLableSingleton.h
//  Sina
//
//  Created by victor on 13-1-22.
//  Copyright (c) 2013年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "RegexKitLite.h"
#import "MarkupParser.h"
@interface OHLableSingleton : NSObject
@property(nonatomic,retain)OHAttributedLabel * OHLabel;
@property(nonatomic,retain)NSArray * emoticons;

+(OHLableSingleton *)shareOH;

-(NSDictionary *)transformString:(NSString*)texts Width:(int)width Font:(UIFont *)font;
@end
