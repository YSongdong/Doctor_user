//
//  PhoneView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^VertificationClickBlock)();
typedef void(^DrawWithMessageBlock)(NSString *code);
typedef void(^DrawWithPayPassBlock)(NSString *payPass); //设置支付密码

typedef void (^payWithPayPassBlock)(NSString *paypass);

@interface PhoneView : UIView

@property (nonatomic,copy)VertificationClickBlock block ;

@property (nonatomic,copy)DrawWithMessageBlock messgeBlock ;
@property (nonatomic,copy)DrawWithPayPassBlock setPaypassBlock ; //设置支付密码
@property (nonatomic,copy)payWithPayPassBlock paypassBlock ;

@property (nonatomic,assign)BOOL havePayPass ;
- (void)disappearView;
+(PhoneView *)phoneViewFromXIBWithTitle:(NSString *)title ;

- (void)showView  ;
@end
