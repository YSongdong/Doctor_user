//
//  NSString+BitusStringUtils.m
//  Kartor
//
//  Created by cluries on 14-4-2.
//  Copyright (c) 2014年 cn.cstonline. All rights reserved.
//

#import "NSString+BitusStringUtils.h"

static NSDateFormatter *__dateFormatter;

@implementation NSString (BitusStringUtils)

+ (void)initialize
{
    if (self == [NSString class]) {
        if (__dateFormatter == nil) {
            __dateFormatter = [NSDateFormatter new];
            // http://www.skyfox.org/ios-formatter-daylight-saving-time.html
            // 夏令时导致某些时候时间解析返回nil问题
            [__dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:3600*8]];
        }
    }
}

- (NSString*) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



/**
 *  如果自己为nil或者NSNull的话，方法不会执行，需要在外面判断nil
 *  只判断有值情况
 *  @return
 */
- (BOOL) isEmpty
{
    return self.length < 1;
}

/**
 *  判断是否为空，当obj为nil、NSNull或者空串时，判断为空，否则不为空（只针对字符串）
 *  @return 空返回YES，不为空返回NO
 */
+ (BOOL)isEmpty:(id)obj
{
    if(obj) {
        if([obj isKindOfClass:[NSString class]]) { // 只用于判断NSString
            NSString *temp = [(NSString *)obj trim];
            if(![temp isBlank] && ![temp isEqual:[NSNull null]]) { // 字符串不为空
                return NO;
            } else { // 字符串为空
                return YES;
            }
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}



/**
 *  如果自己为nil或者NSNull的话，方法不会执行，需要在外面判断nil
 *  只判断有值情况，判断字符是否为空白符
 *  @return
 */
- (BOOL) isBlank
{
    //去掉空白符
    NSString *noBlankChar = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return [noBlankChar isEmpty];
}


+ (void)setRichNumberWithLabel:(UILabel*)label Color:(UIColor *)color FontSize:(CGFloat)size {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSString *temp = nil;
    for(int i =0; i < [attributedString length]; i++) {
        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
        if ([self isPureInt:temp]) {
            [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             color, NSForegroundColorAttributeName,
                                             [UIFont systemFontOfSize:size],NSFontAttributeName,nil]
                                      range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = attributedString;
}
/**
 *此方法是用来判断一个字符串是不是整型.
 *如果传进的字符串是一个字符,可以用来判断它是不是数字
 */
+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}

/*
 *x*y
 *改变字符start 和 end 之间的字符的颜色 和 字体大小
 */
+ (void)messageAction:(UILabel *)theLab startString:(NSString *)start endString:(NSString *)end andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize {
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    // 'x''y'字符的范围
    NSRange tempRange = NSMakeRange(0, 0);
    if (![self isEmpty:start]) {
        tempRange = [tempStr rangeOfString:start];
    }
    NSRange tempRangeOne = NSMakeRange([strAtt length], 0);
    if (![self isEmpty:end]) {
        tempRangeOne =  [tempStr rangeOfString:end];
    }
    // 更改字符颜色
    NSRange markRange = NSMakeRange(tempRange.location+tempRange.length, tempRangeOne.location-(tempRange.location+tempRange.length));
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    // 更改字体
    // [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] range:NSMakeRange(0, [strAtt length])];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    theLab.attributedText = strAtt;
}



+ (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize {
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    NSRange markRange = [tempStr rangeOfString:change];
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    theLab.attributedText = strAtt;
}

@end
