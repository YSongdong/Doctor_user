//
//  YMWithdrawModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMWithdrawModel.h"

@implementation YMWithdrawModel


-(NSString *)mem_name{
    if ([NSString isEmpty:_mem_name]) {
        return @"";
    }else{
        return _mem_name;
    }
}
-(NSString *)card_num{
    if ([NSString isEmpty:_card_num]) {
        return @"";
    }else{
        return _card_num;
    }
}

-(NSString*)name{
    if ([NSString isEmpty:_name]) {
        return @"";
    }else{
        return _name;
    }
}

@end
