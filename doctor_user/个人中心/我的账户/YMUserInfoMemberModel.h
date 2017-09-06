//
//  YMUserInfoMemberModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMUserInfoMemberModel : NSObject
@property(nonatomic,strong)NSString *leaguer_id;//成员ID
@property(nonatomic,strong)NSString *member_id;//当前用户ID
@property(nonatomic,strong)NSString *leaguer_img;//头像
@property(nonatomic,strong)NSString *leagure_name;//真实姓名
@property(nonatomic,strong)NSString *leagure_sex;//性别：1-男 2-女
@property(nonatomic,strong)NSString *leagure_age;//年龄
@property(nonatomic,strong)NSString *leagure_idcard;//身份证;
@property(nonatomic,strong)NSString *leagure_mobile;//手机号@end
@property(nonatomic,strong)NSString *is_default;//1-账号户主 0-非账号户主

@end
