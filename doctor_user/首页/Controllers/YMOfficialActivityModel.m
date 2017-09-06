//
//  YMOfficialActivityModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/21.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOfficialActivityModel.h"

@implementation YMOfficialActivityModel

-(NSString *)title{
    if (_title) {
        return _title;
    }else{
        return @"";
    }
}
-(NSString *)start_time{
    if (_start_time) {
        return _start_time;
    }else{
        return @"";
    }
}

-(NSString *)end_time{
    if (_end_time) {
        return _end_time;
    }else{
        return @"";
    }
}

-(NSString *)conditions{
    if (_conditions) {
        return _conditions;
    }else{
        return @"";
    }
}

-(NSString *)intro{
    if (_intro) {
        return _intro;
    }else{
        return @"";
    }
}

@end
