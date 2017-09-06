//
//  YMUserInfoMemberModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMUserInfoMemberModel.h"

@implementation YMUserInfoMemberModel

-(NSString *)leagure_sex{
    if (_leagure_sex) {
        if([_leagure_sex integerValue] == 1){
            return @"男";
        }
    }
    return @"女";
}

-(NSString *)leaguer_id{
    if ([NSString isEmpty:_leaguer_id]) {
        return @"";
    }
    return _leaguer_id;
    
}


- (id)copyWithZone:(NSZone *)zone{
    YMUserInfoMemberModel *model = [[[self class] allocWithZone:zone]init];
    model.leaguer_id = [_leaguer_id copyWithZone:zone];
    model.member_id = [_member_id copyWithZone:zone];
    model.leaguer_img = [_leaguer_img copyWithZone:zone];
    
    model.leagure_name = [_leagure_name copyWithZone:zone];
    
    model.leagure_sex = [_leagure_sex copyWithZone:zone];
    model.leagure_age = [_leagure_age copyWithZone:zone];
    model.leagure_idcard = [_leagure_idcard copyWithZone:zone];
    model.leagure_mobile = [_leagure_mobile copyWithZone:zone];
    model.is_default = [_is_default copyWithZone:zone];
    return model;
}

@end
