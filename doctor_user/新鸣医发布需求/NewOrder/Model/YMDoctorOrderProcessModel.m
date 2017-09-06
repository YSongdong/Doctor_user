//
//  YMDoctorOrderProcessModel.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorOrderProcessModel.h"

@implementation YMDoctorOrderProcessModel

-(NSString *)grade_id{
    if ([NSString isEmpty:_grade_id]) {
        return @"1";
    }
    return _grade_id;
}
-(NSString *)follow_num{
    if ([NSString isEmpty:_follow_num]) {
        return @"0";
    }
    return _follow_num;
}
-(NSString *)stoer_browse{
    if ([NSString isEmpty:_stoer_browse]) {
        return @"0";
    }
    return _stoer_browse;
}

-(NSString *)demand_id{
    if ([NSString isEmpty:_demand_id]) {
        return @"";
    }
    return _demand_id;
}

-(NSString *)order_id{
    if ([NSString isEmpty:_order_id]) {
        return @"";
    }
    return _order_id;
}

-(NSString *)note{
    if ([NSString isEmpty:_note]) {
        return @"";
    }
    return _note;
}


@end
