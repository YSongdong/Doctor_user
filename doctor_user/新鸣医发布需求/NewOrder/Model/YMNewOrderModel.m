//
//  YMNewOrderModel.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMNewOrderModel.h"

@implementation YMNewOrderModel

-(NSString *)status{
    switch ([_status integerValue]) {
        case 0:
            return @"待支付";
            break;
        case 1:
            return @"已支付";
            break;
        case 2:
            return @"已完成";
            break;
        case 3:
            return @"已失败";
            break;
        default:
            break;
    }
    return @"";
}

@end
