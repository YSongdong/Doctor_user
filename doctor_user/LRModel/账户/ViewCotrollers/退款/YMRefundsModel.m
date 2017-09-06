//
//  YMRefundsModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMRefundsModel.h"

@implementation YMRefundsModel

-(YMWithdrawModel *)bankInfor{
    _bankInfor = [[YMWithdrawModel alloc]init];
    if (_bank) {
        if ([_bank isKindOfClass:[NSDictionary class]] ||[_bank isKindOfClass:[NSMutableDictionary class]]) {
            _bankInfor = [YMWithdrawModel modelWithJSON:_bankInfor];
        }
    }
    return _bankInfor;
}

@end
