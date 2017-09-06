//
//  NSObject+YMUserInfo.m
//  doctor_user
//
//  Created by kupurui on 2017/2/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "NSObject+YMUserInfo.h"
#import <RongIMKit/RongIMKit.h>
@implementation NSObject (YMUserInfo)



-(void)getRongyunToken{
    
    NSDictionary *dic = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=demand&op=rongyun" params:dic withModel:nil complateHandle:^(id showdata, NSString *error) {
        NSLog(@"_______________%@",showdata);
        
        if (!error ) {
        
            if (showdata == nil) {
                return ;
            }

            if ([showdata isKindOfClass:[NSDictionary class]]) {
                
                NSString *token = showdata[@"huanxinpew"];
                [[RCIM sharedRCIM]connectWithToken:token success:^(NSString *userId) {
                    if ([[YMUserInfo sharedYMUserInfo].member_avatar length] > 0) {
                        RCUserInfo *userInfo = [[RCUserInfo alloc]initWithUserId:userId name:[YMUserInfo sharedYMUserInfo].member_name portrait:[YMUserInfo sharedYMUserInfo].member_avatar];
                        [RCIM sharedRCIM].currentUserInfo = userInfo ;
                    } else {
                        RCUserInfo *userInfo = [[RCUserInfo alloc]initWithUserId:userId name:[YMUserInfo sharedYMUserInfo].member_name
                                                                        portrait:[YMUserInfo sharedYMUserInfo].default_avatar];
                        [RCIM sharedRCIM].currentUserInfo = userInfo ;
                    }
                    
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"融云token失败 -- %ld",status);
                    
                } tokenIncorrect:^{
                    NSLog(@"融云token不正确");
                }];
            }
            
        }
    }];
}

@end
