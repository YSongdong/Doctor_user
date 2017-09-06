//
//  YMNewPlayView.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TitlePassworldType,//输入支付密码
    TitleNoSetPassworldType,//没有设置支付密码，
} TitleType;

@class YMNewPayView;

@protocol YMNewPayViewDelegate <NSObject>

-(void)newPayView:(YMNewPayView *)payView backButton:(UIButton *)sender;//返回按钮

-(void)newPayView:(YMNewPayView *)payView fulfillButton:(UIButton *)sender;//完成按钮

-(void)newPayView:(YMNewPayView *)payView forgetPasdButton:(UIButton *)sender;//忘记密码按钮

-(void)newPayView:(YMNewPayView *)payView textField:(NSString *)text; //textField发生改变

@end

@interface YMNewPayView : UIView

//@property(nonatomic,copy)NSString *titleName;

@property(nonatomic,weak)id<YMNewPayViewDelegate> delegate;

@property(nonatomic,assign)TitleType type;

@end
