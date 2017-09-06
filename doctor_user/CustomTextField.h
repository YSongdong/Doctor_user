//
//  CustomTextField.h
//  TextField自动换行
//
//  Created by yangqijia on 16/8/11.
//  Copyright © 2016年 yangqijia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTextField;
@protocol CustomTextFieldDelegate <NSObject>

@optional

-(void)CustomTextField:(CustomTextField *)textField textFieldHeight:(CGFloat)height;

- (BOOL)textField:(UITextField *)textField shouldChangeRange:(NSRange)range String:(NSString *)string;

@end

@interface CustomTextField : UITextField<UITextFieldDelegate>

/**
 *  自定义初始化方法
 *
 *  @param frame       frame
 *  @param placeholder 提示语
 *  @param clear       是否显示清空按钮 YES为显示
 *  @param view        是否设置leftView不设置传nil
 *  @param font        设置字号
 *
 *  @return 
 */

@property(nonatomic,weak)id<CustomTextFieldDelegate> delegateCustom;

-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder clear:(BOOL)clear leftView:(id)view fontSize:(CGFloat)font;

@end
