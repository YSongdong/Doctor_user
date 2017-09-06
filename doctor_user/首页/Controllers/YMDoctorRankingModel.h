//
//  YMDoctorRankingModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDoctorRankingModel : NSObject

@property(nonatomic,copy)NSString *store_id;//医生id
@property(nonatomic,copy)NSString *store_avatar;//医生头像
@property(nonatomic,copy)NSString *member_names; //医生名字
@property(nonatomic,copy)NSString *member_bm;//科室
@property(nonatomic,copy)NSString *member_ks; //科室
@property(nonatomic,copy)NSString *member_occupation;//就职医院
@property(nonatomic,copy)NSString *member_service;//医生擅长
@property(nonatomic,copy)NSString *member_aptitude;//医生职称
@property(nonatomic,copy)NSString *store_sales;//历史成交量
@property(nonatomic,copy)NSString *week_store_sales;//上周成交量
@property(nonatomic,copy)NSString *avg_score;//总评分
@property(nonatomic,copy)NSString *no;//排名

@end
