//
//  YMDoctorLibaryModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDoctorLibaryModel : NSObject
@property(nonatomic,copy)NSString *store_id;
@property(nonatomic,copy)NSString *store_name;
@property(nonatomic,copy)NSString *member_occupation;//医院
@property(nonatomic,copy)NSString *member_names;//姓名
@property(nonatomic,copy)NSString *store_avatar;//头像
@property(nonatomic,copy)NSString *grade_id;
@property(nonatomic,copy)NSString *member_bm;
@property(nonatomic,copy)NSString *member_ks;
@property(nonatomic,copy)NSString *member_aptitude;
@property(nonatomic,copy)NSString *member_id;
@property(nonatomic,copy)NSString *goods_volume;
@property(nonatomic,copy)NSString *fs;
@property(nonatomic,copy)NSString *follow; //关注状态  1已关注  0未关注
@property(nonatomic,copy)NSString *avg_score;//评分
@property(nonatomic,copy)NSString *stoer_browse;//浏览量
@property(nonatomic,copy)NSString *store_collect;//收藏数量
@property(nonatomic,copy)NSString *huanxinid;//融云用户Id


@end
