//
//  UIImage+Utils.h
//
//
//  Created by whang on 16/5/18.
//  Copyright © 2016年 Hang.W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

/**
 1.白色,参数:
 透明度 0~1,  0为白,   1为深灰色
 半径:默认30,推荐值 3   半径值越大越模糊 ,值越小越清楚
 色彩饱和度(浓度)因子:  0是黑白灰, 9是浓彩色, 1是原色  默认1.8
 “彩度”，英文是称Saturation，即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。
 */
- (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;

/**
 *勋章墙毛玻璃效果
 */
- (UIImage *)imgWithBlur;

/**
 *截取view
 */
+ (UIImage *)screenShot:(UIView *)view;

/**
 *截取除开状态栏以外、包括状态栏的区域
 */
+ (UIImage *)fullScreenshots;

/**
 *  给传入的图片设置圆角后返回圆角图片
 *
 *  @param image  原始图片
 *  @param size   图片的大小
 *
 *  @return 返回圆角图片
 */
+ (UIImage *)imageOfRoundRectWithImage: (UIImage *)image size: (CGSize)size radius: (CGFloat)radius;

/**
 *  将图片缩放到指定大小
 *
 */
+ (UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size;

@end
