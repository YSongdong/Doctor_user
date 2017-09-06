//
//  NSString+BitusStringUtils.h
//  Kartor
//
//  Created by cluries on 14-4-2.
//  Copyright (c) 2014年 cn.cstonline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BitusStringUtils)

- (NSString *)trim;
+ (NSString *)trim:(NSString *)str;
+ (BOOL)isEmpty:(id)obj;

/**
 *改变字符串中所有数字的颜色
 */
+ (void)setRichNumberWithLabel:(UILabel*)label Color:(UIColor *)color FontSize:(CGFloat)size;

/**
 *改变字符串中具体某字符串的颜色
 */
+ (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize;

/*
 *x*y
 *改变字符start 和 end 之间的字符的颜色 和 字体大小
 */
+ (void)messageAction:(UILabel *)theLab startString:(NSString *)start endString:(NSString *)end andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize;
/**
 *此方法是用来判断一个字符串是不是整型.
 *如果传进的字符串是一个字符,可以用来判断它是不是数字
 */
+ (BOOL)isPureInt:(NSString *)string;

@end
