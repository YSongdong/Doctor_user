//
//  UIImage+CreateBarCode.h
//  kartor3
//  根据链接地址生成二维码图片
//  Created by zhangfan on 16/8/2.
//  Copyright © 2016年 CST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CreateBarCode)

/**
 *  通过一个链接地址生成一个二维码图片（默认，黑白色，大小最小为160 * 160）
 *  @param networkAddress 链接地址
 *  @return 二维码图片
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress;


/**
 *  通过链接地址生成二维码图片并且设置二维码宽度（默认，黑白色）
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize;

/**
 *  通过链接地址生成二维码图片以及设置二维码宽度和颜色
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue;


/**
 *  通过链接地址生成二维码图片以及设置二维码宽度和颜色，在二维码中间插入图片（图片的大小最好为二维码图片的1/5，图片为空时，直接返回没有中间图片的二维码）
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue
                  insertImage: (UIImage *)insertImage;

/**
 *  通过链接地址生成二维码图片以及设置二维码宽度和颜色，在二维码中间插入圆角图片（图片的大小最好为二维码图片的1/5,图片为空时，直接返回没有中间图片的二维码）
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue
                  insertImage: (UIImage *)insertImage
                  roundRadius: (CGFloat)roundRadius;


@end
