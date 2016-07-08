//
//  NSString+Expand.h
//  SINOPEC_MobileApp
//
//  Created by 张 云鹤 on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Expand)

+ (int)ChangeStringToItemsViewType:(NSString *)str;
+ (int)ChangeStringToItemsViewTitleType:(NSString *)str;
+ (BOOL)isContain:(NSString *)str1 andContain:(NSString *)str2;


@end
