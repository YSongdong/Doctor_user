//
//  YMDemandDetailModel.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDemandDetailModel : NSObject

@property(nonatomic,copy)NSString *demand_id;//需求ID
@property(nonatomic,copy)NSString *demand_type;//鸣医订单需求类型：1-询医问诊 2-市内坐诊 3-活动讲座
@property(nonatomic,copy)NSString *order_type;//订单类型：1-鸣医订单 2-预约订单 3-服务购买 4-活动参与订单 5-提交报告 6-疑难杂症
@property(nonatomic,copy)NSString *is_daifa;//是否代发：1-是 0-否
@property(nonatomic,copy)NSString *is_fuzhen;//是否复诊：1-是 0-否
@property(nonatomic,copy)NSString *order_id;//对应订单ID
@property(nonatomic,copy)NSString *leaguer_id;//成员ID
@property(nonatomic,copy)NSString *title;//标题：主要症状
@property(nonatomic,copy)NSString *demand_content;//详情描述
@property(nonatomic,copy)NSString *big_ks;//大科室
@property(nonatomic,copy)NSString *small_ks;//小科室
@property(nonatomic,copy)NSString *demand_company;//单位名
@property(nonatomic,copy)NSString *demand_company_tel;//单位电话
@property(nonatomic,copy)NSString *demand_time;//需求时间
@property(nonatomic,copy)NSString *demand_time2;//结束时间
@property(nonatomic,copy)NSString *hospital_id;//医院ID
@property(nonatomic,copy)NSString *aptitude;//职称
@property(nonatomic,copy)NSString *money;//价格
@property(nonatomic,copy)NSString *agent_regist;//平台代挂号费用，没勾选代挂号时是0
@property(nonatomic,strong)NSArray *demand_imgs;//需求图片
@property(nonatomic,copy)NSString *leagure_name;//姓名
@property(nonatomic,copy)NSString *leaguer_img;//头像
@property(nonatomic,copy)NSString *leagure_sex;//性别：1-男 2-女
@property(nonatomic,copy)NSString *leagure_age;//年龄
@property(nonatomic,copy)NSString *hospital_name;//医院名字
@property(nonatomic,copy)NSString *is_bid;//当前医生是否已投标 1-已投 0-未投



@end
