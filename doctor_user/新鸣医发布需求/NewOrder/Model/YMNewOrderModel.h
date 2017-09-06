//
//  YMNewOrderModel.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMNewOrderModel : NSObject

@property(nonatomic,copy)NSString *demand_id;//需求ID
@property(nonatomic,copy)NSString *demand_sn;//需求编号
@property(nonatomic,copy)NSString *demand_type;//鸣医订单需求类型：1-询医问诊 2-市内坐诊 3-活动讲座（根据demand_type和order_type判断显示哪种订单流程
@property(nonatomic,copy)NSString *order_type;//订单类型：1-鸣医订单 2-预约订单 3-服务购买 4-活动参与订单 5-提交报告 6-疑难杂症
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *demand_time;//需求时间

@property(nonatomic,copy)NSString *money;//金额
@property(nonatomic,copy)NSString *status;//状态：0-待支付 1-已支付 2-已完成3-已失败
@property(nonatomic,copy)NSString *status_desc;//状态描述
@property(nonatomic,copy)NSString *order_id;//订单ID
@property(nonatomic,copy)NSString *user_signed;//用户是否已签合同：1-已签 0未签(根据此字段判断是跳选标页面还是跳订单流程)
@property(nonatomic,copy)NSString *yuyue_state;//预约订单状态：0-待支付 1-已支付 2-已完成3-已失败
@property(nonatomic,copy)NSString *yuyue_state_desc;//预约订单状态描述

@property(nonatomic,copy)NSString *create_time; //创建时间
@property(nonatomic,copy)NSString *diseases_id; //疑难杂症时间
@property(nonatomic,copy)NSString *diseases_time;//疑难杂症时间

@end
