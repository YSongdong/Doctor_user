//
//  YMMyAttentionModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyAttentionModel.h"

@implementation YMMyAttentionModel

-(NSString*)member_names{
    if ([NSString isEmpty:_member_names]) {
        return @"";
    }
    return _member_names;
}
-(NSString*)grade_id{
    if ([NSString isEmpty:_grade_id]) {
        return @"1";
    }
    return _grade_id;
}
-(NSString*)member_occupation{
    if ([NSString isEmpty:_member_occupation]) {
        return @"";
    }
    return _member_occupation;
}
-(NSString*)member_ks{
    if ([NSString isEmpty:_member_ks]) {
        return @"";
    }
    return _member_ks;
}
-(NSString*)member_aptitude{
    if ([NSString isEmpty:_member_aptitude]) {
        return @"";
    }
    return _member_aptitude;
}
-(NSString*)store_sales{
    if ([NSString isEmpty:_store_sales]) {
        return @"0";
    }
    return _store_sales;
}
-(NSString*)stoer_browse{
    if ([NSString isEmpty:_stoer_browse]) {
        return @"0";
    }
    return _stoer_browse;
}
-(NSString*)member_avatar{
    if ([NSString isEmpty:_member_avatar]) {
        return @"0";
    }
    return _member_avatar;
}
-(NSString*)follow_num{
    if ([NSString isEmpty:_follow_num]) {
        return @"0";
    }
    return _follow_num;
}
-(NSString*)avg_score{
    if ([NSString isEmpty:_avg_score]) {
        return @"";
    }
    return _avg_score;
}

@end
