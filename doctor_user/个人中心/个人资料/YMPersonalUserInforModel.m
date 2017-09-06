//
//  YMPersonalUserInforModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMPersonalUserInforModel.h"

@implementation YMPersonalUserInforModel

-(NSString *)leagureSexChinese{
    if (![NSString isEmpty:_leagure_sex]) {
        if ([_leagure_sex integerValue] == 1) {
            return @"男";
        }else if([_leagure_sex integerValue]==2){
            return @"女";
        }
    }
    return @"";
}

-(NSString *)leagure_sex{
    if ([NSString isEmpty:_leagure_sex]) {
        return @"";
    }
    return _leagure_sex;
}

-(NSString *)leaguer_id{
    if ([NSString isEmpty:_leaguer_id]) {
        return @"";
    }
    return _leaguer_id;
}


-(NSString *)member_id{
    if ([NSString isEmpty:_member_id]) {
        return @"";
    }
    return _member_id;
}


-(NSString *)leagure_name{
    if ([NSString isEmpty:_leagure_name]) {
        return @"";
    }
    return _leagure_name;
}

-(NSString *)leagure_birth{
    if ([NSString isEmpty:_leagure_birth]) {
        return @"";
    }
    return _leagure_birth;
}
-(NSString *)leagure_idcard{
    if ([NSString isEmpty:_leagure_idcard]) {
        return @"";
    }
    return _leagure_idcard;
}
-(NSString *)leagure_mobile{
    if ([NSString isEmpty:_leagure_mobile]) {
        return @"";
    }
    return _leagure_mobile;
}
-(NSString *)leagure_profession{
    if ([NSString isEmpty:_leagure_profession]) {
        return @"";
    }
    return _leagure_profession;
}
-(NSString *)leagure_city{
    if ([NSString isEmpty:_leagure_city]) {
        return @"";
    }
    return _leagure_city;
}
-(NSString *)leagure_addr{
    if ([NSString isEmpty:_leagure_addr]) {
        return @"";
    }
    return _leagure_addr;
}

#pragma  mark - NSCoding
- (id)copyWithZone:(NSZone *)zone
{
    YMPersonalUserInforModel *model = [[[self class] allocWithZone:zone]init];
    model.leaguer_id = [_leaguer_id copyWithZone:zone];
    model.member_id = [_member_id copyWithZone:zone];
    model.leaguer_img = [_leaguer_img copyWithZone:zone];
    model.leagure_name = [_leagure_name copyWithZone:zone];
    model.leagure_idcard = [_leagure_idcard copyWithZone:zone];
    model.leagure_sex = [_leagure_sex copyWithZone:zone];
    model.leagure_birth = [_leagure_birth copyWithZone:zone];
    model.leagure_mobile = [_leagure_mobile copyWithZone:zone];
    model.leagure_profession = [_leagure_profession copyWithZone:zone];
    model.leagure_city = [_leagure_city copyWithZone:zone];
    model.leaguer_area_name = [_leaguer_area_name copyWithZone:zone];
    model.leagure_addr = [_leagure_addr copyWithZone:zone];
    model.is_default = [_is_default copyWithZone:zone];
    return model;
}

@end
