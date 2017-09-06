//
//  SDMyPrivateDoctorModel.h
//  doctor_user
//
//  Created by dong on 2017/9/6.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDMyPrivateDoctorModel : NSObject

@property(nonatomic,copy) NSString *p_health_id;//私人医生会员id
@property(nonatomic,copy) NSString *member_name; //用户姓名
@property(nonatomic,copy) NSString *member_avatar; //用户头像
@property(nonatomic,copy) NSString *address;  //用户地址
@property(nonatomic,copy) NSString *member_mobile;  //用户电话
@property(nonatomic,copy) NSString *endDate;   //到期日期
@property(nonatomic,copy) NSString *member_names; //医生名字
@property(nonatomic,copy) NSString *member_mobiles; //医生电话
@property(nonatomic,copy) NSString *physical_examination;  //全名健康体检总数
@property(nonatomic,copy) NSString *physical_examination_con;  //全名健康体检已用数
@property(nonatomic,copy) NSString *famous_doctors; //名医体检解读总数
@property(nonatomic,copy) NSString *famous_doctors_con; //名医体检解读已用数
@property(nonatomic,copy) NSString *service_home; //医生服务到家总数
@property(nonatomic,copy) NSString *service_home_con; //医生服务到家已用数
@property(nonatomic,copy) NSString *health_management; //健康管理方案总数
@property(nonatomic,copy) NSString *health_management_con; //健康管理方案已用数
@property(nonatomic,copy) NSString *green_access; //绿色住院通道总数
@property(nonatomic,copy) NSString *green_access_con; //绿色住院通道已用数
@property(nonatomic,copy) NSString *green_hospital; //绿色就诊通道总数
@property(nonatomic,copy) NSString *green_hospital_con; //绿色就诊通道已用数
@property(nonatomic,copy) NSString *annual_report;  //年度健康报告总数
@property(nonatomic,copy) NSString *annual_report_con;   //年度健康报告已用数

@end
