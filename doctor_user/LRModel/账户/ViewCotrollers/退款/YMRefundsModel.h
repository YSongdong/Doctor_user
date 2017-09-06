//
//  YMRefundsModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMWithdrawModel.h"

@interface YMRefundsModel : NSObject
@property(nonatomic,copy)NSString *money;//用户余额
@property(nonatomic,copy)NSString *tips;
@property(nonatomic,strong)NSDictionary *bank;

@property(nonatomic,strong)YMWithdrawModel *bankInfor;

@end
