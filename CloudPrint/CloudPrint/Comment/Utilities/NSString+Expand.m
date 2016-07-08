//
//  NSString+Expand.m
//  SINOPEC_MobileApp
//
//  Created by 张 云鹤 on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NSString+Expand.h"

@implementation NSString (Expand)

+ (int)ChangeStringToItemsViewType:(NSString *)str{
    if ([str isEqualToString:@"top"]) {
        return ItemsViewType_Top;
    }else if ([str isEqualToString:@"bottom"]){
        return ItemsViewType_Bottom;
    }else if ([str isEqualToString:@"left"]){
        return ItemsViewType_Left;
    }else if ([str isEqualToString:@"sodoku"] || [str isEqualToString:@"list"]){
        return ItemsViewType_LargeIcon;
    }
    return 0;
}

+ (int)ChangeStringToItemsViewTitleType:(NSString *)str{
    if ([str isEqualToString:@"word"]) {
        return ItemsViewTitleType_word;
    }else if ([str isEqualToString:@"picture"]){
        return ItemsViewTitleType_pic;
    }else if ([str isEqualToString:@"picword"]){
        return ItemsViewTitleType_picWord;
    }
    return 0;
}

+ (BOOL)isContain:(NSString *)str1 andContain:(NSString *)str2{
    NSRange foundObj=[str1 rangeOfString:str2 options:NSCaseInsensitiveSearch];
    if(foundObj.length>0) {
        return YES;
    } else {
        return NO;
    }
}

@end

