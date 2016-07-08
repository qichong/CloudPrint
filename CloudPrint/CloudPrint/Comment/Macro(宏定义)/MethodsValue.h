//
//  MethodsValue.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#define kScreen_Height  MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define kScreen_Width   MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define GetImageUrlStr(url) [NSString stringWithFormat:@"%@%@",kImageUrlPrefix,url]

#define kDomainId      [[NSUserDefaults standardUserDefaults] objectForKey:Main_DomainId]



#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//#define BSLog(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


////rgb颜色
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
//
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


//设备为IPHONE5
#define DEVICE_IPHONE5 [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO

//设备IOSVersion
#define IOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

//设备IOSVersion为6.0之后
#define IOSVersion_6 [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0
//设备IOSVersion为7.0之后
#define IOSVersion_7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0


#define UIImageWithName(imageName) [UIImage imageNamed:imageName]

#define UIImageGetImageFromName(__POINTER) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:__POINTER ofType:nil]]
//没有代理的提示框

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wformat-security"
//写在这个中间的代码,都不会被编译器提示-Wdeprecated-declarations类型的警告
#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]
#pragma clang diagnostic pop


//安全释放
#define RELEASE_SAFELY(_POINTER) if (nil != (_POINTER)){[_POINTER release];_POINTER = nil; }
//自定义导航栏的位置
#define kTopFrame        CGRectMake(0, 0, kScreen_Width, kNavHeight+self.iosChangeFloat)

//打印
#define ISDEV 1
#ifndef QSLog
#if ISDEV==1
#define QSLog(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define QSLog(id, ...)
#endif
#endif

