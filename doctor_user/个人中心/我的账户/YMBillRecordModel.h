//
//  YMBillRecordModel.h
//  doctor_user
//  账单纪录
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMBillRecordModel : NSObject
@property(nonatomic,copy)NSString *order_id;//订单id
@property(nonatomic,copy)NSString *buyer_id; //用户id
@property(nonatomic,copy)NSString *store_id;//医生id
@property(nonatomic,copy)NSString *order_cpid; //需求id
@property(nonatomic,copy)NSString *order_amount;//订单金额
@property(nonatomic,copy)NSString *payment_time;//支付时间
@property(nonatomic,copy)NSString *finnshed_time;//订单完成时间
@property(nonatomic,copy)NSString *member_names; //医生名
@property(nonatomic,copy)NSString *demand_sketch;//订单名

@property(nonatomic,copy)NSString *yearAndMonthAndDay;//年月日

@property(nonatomic,copy)NSString *time;//时间 23:12


@end
