//
//  YMDoctorActivityModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorActivityModel.h"

@implementation YMDoctorActivityModel

-(NSString *)leagure_name{
    if (_leagure_name) {
        return _leagure_name;
    }else{
       return @"";
    }
}

-(NSArray *)hospital{
    if (_hospital) {
        for (NSDictionary *dic in _hospital) {
            [dic setValue:@1 forKey:@"showType"];
            if (![dic isKindOfClass:[YMSignUpAndDorctorModel class]]) {
                [_hospital addObject:[YMSignUpAndDorctorModel modelWithJSON:dic]];
            }
        }
        return _hospital;
    }else{
        return @[];
    }
}

@end
