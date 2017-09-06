//
//  YMDoctorOrderProcessModel.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDoctorOrderProcessModel : NSObject

@property(nonatomic,copy)NSString *order_id;//订单ID
@property(nonatomic,copy)NSString *order_sn;//订单编号
@property(nonatomic,copy)NSString *demand_id;//需求ID
@property(nonatomic,copy)NSString *doctor_sign_time;//医生签合同时间
@property(nonatomic,strong)NSArray *instructions_img;//医嘱图片
@property(nonatomic,copy)NSString *instructions_content;//医嘱内容
@property(nonatomic,copy)NSString *fuzhen_time;//复诊时间
@property(nonatomic,copy)NSString *fuzhen_tips;//复诊提示
@property(nonatomic,copy)NSString *mingyi_status;//鸣医订单状态：1-医生投标，合同已发起，等待用户选标 2-用户已选标 3-医生已填写医嘱 4-用户已确认付款
@property(nonatomic,copy)NSString *is_arbitrate;//是否申请仲裁：0-否 1-是
@property(nonatomic,copy)NSString *user_score;//用户评分：1-5，未评价时为0
@property(nonatomic,copy)NSString *user_ping;//用户评价标签
@property(nonatomic,copy)NSString *doctor_ping;//医生评价内容
@property(nonatomic,copy)NSString *title;//主要症状
@property(nonatomic,copy)NSString *demand_time;//需求时间
@property(nonatomic,copy)NSString *money;//需求最初的酬金
@property(nonatomic,copy)NSString *demand_type;//鸣医订单需求类型：1-询医问诊 2-市内坐诊 3-活动讲座
@property(nonatomic,copy)NSString *order_type;//订单类型：1-鸣医订单 2-预约订单 3-服务购买 4-活动参与订单 5-提交报告 6-疑难杂症
@property(nonatomic,copy)NSString *huanxinid;//融云用户ID
@property(nonatomic,copy)NSString *huanxinpew;//融云token

@property(nonatomic,copy)NSString *doctor_member_id;//医生member_id
@property(nonatomic,copy)NSString *doctor_store_id;//医生store_id
@property(nonatomic,copy)NSString *doctor_price;//医生服务金额
@property(nonatomic,copy)NSString *service_start_time;
@property(nonatomic,copy)NSString *service_end_time;//服务时间
@property(nonatomic,strong)NSArray *tips;//重要提示

@property(nonatomic,copy)NSString *yuyue_status;//预约订单状态：0-待支付 1-已支付（等待医生接受） 2-医生接受预约（签合同） 3-医生拒绝预约 4-用户签合同 5-医生提交医嘱 6-用户已确认付款
@property(nonatomic,copy)NSString *note;//备注：医生拒绝预约的原因；
@property(nonatomic,copy)NSString *member_names;//医生姓名
@property(nonatomic,copy)NSString *grade_id;//级别
@property(nonatomic,copy)NSString *follow_num;//关注数量
@property(nonatomic,copy)NSString *store_sales;//成交量
@property(nonatomic,copy)NSString *stoer_browse;//浏览量



@property(nonatomic,copy)NSString *member_aptitude;//职称
@property(nonatomic,copy)NSString *member_bm;//大科室
@property(nonatomic,copy)NSString *member_ks;//小科室
@property(nonatomic,copy)NSString *member_occupation;//医院

@property(nonatomic,copy)NSString *member_avatar;//头像
@property(nonatomic,strong)NSArray *recom_doctors;//推荐列表

@property(nonatomic,copy)NSString *should_pay;//未支付是的应付金额



@end
