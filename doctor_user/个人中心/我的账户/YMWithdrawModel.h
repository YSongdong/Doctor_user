//
//  YMWithdrawModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMWithdrawModel : NSObject
@property(nonatomic,copy)NSString *card_id;//银行卡ID
@property(nonatomic,copy)NSString *mem_name;//银行卡姓名 支付宝名字
@property(nonatomic,copy)NSString *card_num; //银行卡号 支付宝帐号
@property(nonatomic,copy)NSString *name;//银行名称 支付宝

@end
