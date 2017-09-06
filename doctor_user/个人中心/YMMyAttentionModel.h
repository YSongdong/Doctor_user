//
//  YMMyAttentionModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMMyAttentionModel : NSObject
@property(nonatomic,copy)NSString *store_id;//店铺ID
@property(nonatomic,copy)NSString *member_id;//医生member_id
@property(nonatomic,copy)NSString *member_names;//名字
@property(nonatomic,copy)NSString *grade_id;//等级
@property(nonatomic,copy)NSString *member_occupation;//医院名
@property(nonatomic,copy)NSString *member_ks;//科室
@property(nonatomic,copy)NSString *member_aptitude;//职称
@property(nonatomic,copy)NSString *store_sales;//成交量
@property(nonatomic,copy)NSString *stoer_browse;//浏览量
@property(nonatomic,copy)NSString *member_avatar;//头像
@property(nonatomic,copy)NSString *follow_num;//关注数量
@property(nonatomic,copy)NSString *avg_score;//评分
@property(nonatomic,copy)NSString *live_store_tel; //电话
@end
