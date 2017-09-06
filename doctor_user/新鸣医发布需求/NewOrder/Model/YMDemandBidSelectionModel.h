//
//  YMDemandBidSelectionModel.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMBidListModel.h"



@interface YMDemandBidSelectionModel : NSObject
@property(nonatomic,copy)NSString *demand_id;//需求ID
@property(nonatomic,copy)NSString *demand_sn;//需求订单编号
@property(nonatomic,copy)NSString *money;//酬金
@property(nonatomic,copy)NSString *agent_regist;//平台代挂号费用
@property(nonatomic,copy)NSString *title;//症状描述
@property(nonatomic,copy)NSString *demand_time;//需求时间
@property(nonatomic,copy)NSString *status;//需求订单状态：0-待支付 1-已支付 2-已完成（用户确认付款后为已完成）3-已失败（如果是待支付状态，下面的按钮是【托管酬金】）
@property(nonatomic,copy)NSString *should_pay;//用户应支付金额
@property(nonatomic,copy)NSString *bid_num;
@property(nonatomic,strong)NSArray *bid_list;


@property(nonatomic,strong)NSMutableArray <YMBidListModel *> *bidListArry;

@end
