//
//  YMUserContractPageModel.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMUserContractPageModel.h"

@implementation YMUserContractPageModel

-(NSString *)order_sn{
    if ([NSString isEmpty:_order_sn]) {
        return @"";
    }
    return _order_sn;
}

-(NSString *)diff_price{
    if ([NSString isEmpty:_diff_price]) {
        return @"";
    }
    return _diff_price;
}

@end
