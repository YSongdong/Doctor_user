//
//  YMApplicationInformation.m
//  doctor_user
//
//  Created by 黄军 on 17/6/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMApplicationInformation.h"

@implementation YMApplicationInformation

+(NSString *)appCurVersionNum{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSLog(@"当前应用版本号码：%@",[infoDictionary objectForKey:@"CFBundleVersion"]);
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

@end
