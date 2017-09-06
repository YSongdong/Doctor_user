//
//  YMDemandDetailModel.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDemandDetailModel.h"

@implementation YMDemandDetailModel
-(NSString*)leagure_sex{
    if ([_leagure_sex integerValue] == 1) {
        return @"男";
    }else if([_leagure_sex integerValue]==2){
        return @"女";
    }
    return @"";
}
@end
