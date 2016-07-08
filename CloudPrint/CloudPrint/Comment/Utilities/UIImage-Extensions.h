//
//  UIImage-Extensions.h
//  SunboxSoft
//
//  Created by 雷克 on 11-11-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (CS_Extensions)

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
//等比缩放
- (UIImage *)imageFitInSize:(CGSize)viewsize;

@end;


@interface UIImage (sizeFit) 
//thisSize 等比缩放到 aSize的 size
+ (CGSize)fitSize:(CGSize)thisSize inSize:(CGSize)aSize;
//等比缩放到指定size,如果有额外区域,显示透明
+ (UIImage *)image:(UIImage *)image fitInSize:(CGSize)viewsize;
//从image中心开始扩散截取viewsize的区域
+ (UIImage *)image:(UIImage *)image centerInSize:(CGSize)viewsize;
//整个填充viewsize,可能原图的某个边.
+ (UIImage *)image:(UIImage *)image fillSize:(CGSize)viewsize;
//截取成正方形
+ (UIImage *)autoFitImage:(UIImage *)image;
//截取成612正方形
+ (UIImage *)autoFitFormatImage:(UIImage *)image;
//
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
