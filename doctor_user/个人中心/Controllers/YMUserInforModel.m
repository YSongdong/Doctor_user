//
//  YMUserInforModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMUserInforModel.h"
static NSString *const saveUsrInfo = @"saveUsrInfo";

@implementation YMUserInforModel

-(NSString *)demand{
    if ([_demand integerValue]>0) {
        if ([_demand integerValue]>99) {
            return @"99+";
        }else{
            return _demand;
        }
    }else{
        return 0;
    }
    
}

-(NSString *)cases{
    if ([_cases integerValue]>0) {
        if ([_cases integerValue]>99) {
            return @"99+";
        }else{
            return _cases;
        }
    }else{
        return 0;
    }
    
}

-(NSString *)registerNumber{
    if ([_registerNumber integerValue]>0) {
        if ([_registerNumber integerValue]>99) {
            return @"99+";
        }else{
            return _registerNumber;
        }
    }else{
        return 0;
    }
}

-(NSString *)sum{
    if ([NSString isEmpty:_sum]) {
        return @"0.00";
    }else{
        return _sum;
    }
}

-(NSString *)count{
    if ([NSString isEmpty:_count]) {
        return @"0";
    }else{
        return _count;
    }
}
-(NSString *)available_predeposit{
    if ([NSString isEmpty:_available_predeposit]) {
        return @"0.00";
    }else{
        return _available_predeposit;
    }
}

-(NSString *)member_id{
    if ([NSString isEmpty:_member_id]) {
        return @"";
    }
    return _member_id;
}

+ (YMUserInforModel *)currentUser
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:saveUsrInfo];
    NSDictionary *userdic = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    return [self modelWithJSON:userdic];
}

@end
