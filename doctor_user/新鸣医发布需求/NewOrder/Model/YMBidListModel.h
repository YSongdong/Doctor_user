//
//  YMBidListModel.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMBidListModel : NSObject
@property(nonatomic,copy)NSString *order_id;//订单ID
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *doctor_member_id;//医生member_id
@property(nonatomic,copy)NSString *doctor_store_id;//医生store_id
@property(nonatomic,copy)NSString *doctor_price;//医生服务金额
@property(nonatomic,copy)NSString *service_start_time;//服务开始时间
@property(nonatomic,copy)NSString *service_end_time;//服务结束时间（判断开始和结束时间，两个都有值就显示两个，只有一个有值就显示有的那个
@property(nonatomic,copy)NSString *member_names;//医生姓名
@property(nonatomic,copy)NSString *grade_id;//级别
@property(nonatomic,copy)NSString *member_aptitude;//职称
@property(nonatomic,copy)NSString *member_bm;//大科室
@property(nonatomic,copy)NSString *member_ks;//小科室
@property(nonatomic,copy)NSString *member_occupation;//医院
@property(nonatomic,copy)NSString *huanxinid;//融云ID
@property(nonatomic,copy)NSString *huanxinpew;//融云token
@property(nonatomic,copy)NSString *member_avatar;//头像
@property(nonatomic,copy)NSString *follow_num;//关注数量
@property(nonatomic,copy)NSString *avg_score;//评分

@end
