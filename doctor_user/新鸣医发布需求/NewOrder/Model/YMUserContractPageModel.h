//
//  YMUserContractPageModel.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMUserContractPageModel : NSObject

@property(nonatomic,copy)NSString *order_id;//订单ID
@property(nonatomic,copy)NSString *order_sn;//订单编号
@property(nonatomic,copy)NSString *diff_price;//差价，>0点击签合同时跳支付页面,<=0点击签合同时调签合同接口
@property(nonatomic,copy)NSString *explain;//合同说明
@property(nonatomic,copy)NSString *tips;//温馨提示
@property(nonatomic,copy)NSString *service_start_time;
@property(nonatomic,copy)NSString *service_end_time;
@property(nonatomic,strong)NSArray *tiparr;//重要提醒
@property(nonatomic,copy)NSString *other_tips;//其他提醒
@property(nonatomic,copy)NSString *content;//合同内容
@property(nonatomic,copy)NSString *partB_name;//乙方
@property(nonatomic,copy)NSString *partB_time;//乙方签署日期
@property(nonatomic,copy)NSString *partA_time;//甲方签署日期
@property(nonatomic,copy)NSString *user_is_sign;//用户是否已签合同：1-已签  0-未签（显示签合同按钮）
@property(nonatomic,copy)NSString *partA_name;//甲方
@property(nonatomic,copy)NSString *note;


@end
