//
//  YMBillRecordModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMBillRecordModel.h"

@implementation YMBillRecordModel

-(NSString *)yearAndMonthAndDay{
    return [NSString stringWithFormat:@"%@.%@.%@",[self year],[self month],[self day]];
}

-(NSString *)time{
    return [NSString stringWithFormat:@"%@:%@",[self hour],[self minute]];
}

-(NSString *)year{
    if ([self isFinnshed_time_Empty]){
        return @"";
    }else{
        return  [_finnshed_time substringWithRange:NSMakeRange(0,4)];
    }
}

-(NSString *)month{
    if ([self isFinnshed_time_Empty]){
        return @"";
    }else{
        return  [_finnshed_time substringWithRange:NSMakeRange(5,2)];
    }
}

-(NSString *)day{
    if ([self isFinnshed_time_Empty]){
        return @"";
    }else{
        return  [_finnshed_time substringWithRange:NSMakeRange(8,2)];
    }
}

-(NSString *)hour{
    if ([self isFinnshed_time_Empty]){
        return @"";
    }else{
        return  [_finnshed_time substringWithRange:NSMakeRange(_finnshed_time.length -5,2)];
    }
}
-(NSString *)minute{
    if ([self isFinnshed_time_Empty]){
        return @"";
    }else{
        return  [_finnshed_time substringWithRange:NSMakeRange(_finnshed_time.length -2,2)];
    }
}
-(BOOL)isFinnshed_time_Empty{
    return [NSString isEmpty:_finnshed_time];
}

@end
