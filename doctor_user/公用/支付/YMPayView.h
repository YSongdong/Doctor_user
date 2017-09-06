//
//  YMPayView.h
//  doctor_user
//
//  Created by kupurui on 17/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ZHIFUBAO,//支付宝
    WEIXIN,//微信
    YUE,//余额
}STATUS;
typedef void(^PAY_BTNCLICK)(long long status);
@interface YMPayView : UIView
- (void)setDetailMoneyWith:(NSString *)money andData:(NSDictionary *)dic;
- (void)setAnimaltion;
@property (nonatomic, strong) UIViewController *superVC;
@property (nonatomic, strong) PAY_BTNCLICK block;
@end
