//
//  YMPersonalUserInforModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMPersonalUserInforModel : NSObject
@property(nonatomic,copy)NSString *leaguer_id;//成员ID
@property(nonatomic,copy)NSString *member_id;//当前用户ID
@property(nonatomic,copy)NSString *leaguer_img;//成员头像
@property(nonatomic,copy)NSString *leagure_name;//成员真实姓名
@property(nonatomic,copy)NSString *leagure_idcard;//成员身份证号
@property(nonatomic,copy)NSString *leagure_sex;//成员性别 1-男 2-女
@property(nonatomic,copy)NSString *leagure_birth;//出生日期
@property(nonatomic,copy)NSString *leagure_mobile;//成员手机号
@property(nonatomic,copy)NSString *leagure_profession;//成员职业
@property(nonatomic,copy)NSString *leagure_city;//所在地区ID
@property(nonatomic,copy)NSString *leaguer_area_name;//所在地区名称
@property(nonatomic,copy)NSString *leagure_addr;//联系地址
@property(nonatomic,copy)NSString *is_default;//1-是账号户主 0-非账号户主
@property(nonatomic,copy)NSString *leagureSexChinese;

@end
