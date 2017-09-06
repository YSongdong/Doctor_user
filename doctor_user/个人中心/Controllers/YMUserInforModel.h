//
//  YMUserInforModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMUserInforModel : NSObject
@property(nonatomic,copy)NSString *member_id;//用户id
@property(nonatomic,copy)NSString *member_avatar;//用户头像
@property(nonatomic,copy)NSString *member_name;//用户昵称
@property(nonatomic,copy)NSString *member_mobile;//用户电话
@property(nonatomic,copy)NSString *sound;//铃声
@property(nonatomic,copy)NSString *vibrates;//震动
@property(nonatomic,copy)NSString *member_email; //邮箱
@property(nonatomic,copy)NSString *huanxinid;//环信id
@property(nonatomic,copy)NSString *huanxinpew;//环信
@property(nonatomic,copy)NSString *is_buy;//用户id
@property(nonatomic,copy)NSString *count;//用户成交记录
@property(nonatomic,copy)NSString *sum;//用户成交金额
@property(nonatomic,copy)NSString *demand;//需求订单提示
@property(nonatomic,copy)NSString *cases; //疑难杂症提示  特别注意
@property(nonatomic,copy)NSString *registerNumber;//挂号提示   特别注意
@property(nonatomic,copy)NSString *member_address;//"cqdaxi" 地址
@property(nonatomic,copy)NSString *member_number;//"500230199508084371", 身份证
@property(nonatomic,copy)NSString *member_names;//"132465",
@property(nonatomic,copy)NSString *member_age;//用户年龄
@property(nonatomic,copy)NSString *member_education;//用户学历
@property(nonatomic,copy)NSString *member_aptitude;
@property(nonatomic,copy)NSString *member_occupation;//用户所从事的行业
@property(nonatomic,copy)NSString *member_truename;//真实姓名
@property(nonatomic,copy)NSString *member_image;
@property(nonatomic,copy)NSString *member_sex;//性别
@property(nonatomic,copy)NSString *member_birthday;//生日
@property(nonatomic,copy)NSString *member_passwd;//密码
@property(nonatomic,copy)NSString *member_paypwd;//支付密码
@property(nonatomic,copy)NSString *member_email_bind;
@property(nonatomic,copy)NSString *member_mobile_bind;
@property(nonatomic,copy)NSString *member_qq;//QQ
@property(nonatomic,copy)NSString *member_ww;//微信
@property(nonatomic,copy)NSString *member_login_num;//登录的次数
@property(nonatomic,copy)NSString *member_time;
@property(nonatomic,copy)NSString *member_login_time;
@property(nonatomic,copy)NSString *member_old_login_time;
@property(nonatomic,copy)NSString *member_login_ip;
@property(nonatomic,copy)NSString *member_old_login_ip;
@property(nonatomic,copy)NSString *member_qqopenid;
@property(nonatomic,copy)NSString *member_qqinfo;
@property(nonatomic,copy)NSString *member_sinaopenid;
@property(nonatomic,copy)NSString *member_sinainfo;
@property(nonatomic,copy)NSString *weixin_unionid;
@property(nonatomic,copy)NSString *weixin_info;
@property(nonatomic,copy)NSString *member_points; 
@property(nonatomic,copy)NSString *available_predeposit;//余额
@property(nonatomic,copy)NSString *freeze_predeposit; 
@property(nonatomic,copy)NSString *available_rc_balance; 
@property(nonatomic,copy)NSString *freeze_rc_balance; 
@property(nonatomic,copy)NSString *inform_allow; 
@property(nonatomic,copy)NSString *member_state; 
@property(nonatomic,copy)NSString *is_allowtalk; 
@property(nonatomic,copy)NSString *member_snsvisitnum; 
@property(nonatomic,copy)NSString *member_areaid; 
@property(nonatomic,copy)NSString *member_cityid; 
@property(nonatomic,copy)NSString *member_provinceid; 
@property(nonatomic,copy)NSString *member_areainfo; 
@property(nonatomic,copy)NSString *member_quicklink; 
@property(nonatomic,copy)NSString *member_privacy; 
@property(nonatomic,copy)NSString *member_exppoints; 
@property(nonatomic,copy)NSString *inviter_id; 
@property(nonatomic,copy)NSString *member_ks; 
@property(nonatomic,copy)NSString *member_bm; 
@property(nonatomic,copy)NSString *member_service; 
@property(nonatomic,copy)NSString *member_Personal; 
@property(nonatomic,copy)NSString *member_property; 
@property(nonatomic,copy)NSString *member_image1; 
@property(nonatomic,copy)NSString *member_phone; 
@property(nonatomic,copy)NSString *member_real; 
@property(nonatomic,copy)NSString *is_paypwd;

+ (YMUserInforModel *)currentUser;

@end
