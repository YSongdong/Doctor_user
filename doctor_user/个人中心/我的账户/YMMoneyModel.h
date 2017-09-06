//
//  YMMoneyModel.h
//  doctor_user
//  钱信息
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMMoneyModel : NSObject
@property(nonatomic,copy)NSString *member_id;//用户id
@property(nonatomic,copy)NSString *available_predeposit; // 用户的账户余额
@property(nonatomic,copy)NSString *is_paypwd; //是否有支付密码    0 没有，1   有
@property(nonatomic,copy)NSString *card_num;//银行卡数量
@end
