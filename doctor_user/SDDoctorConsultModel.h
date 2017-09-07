//
//  SDDoctorConsultModel.h
//  doctor_user
//
//  Created by dong on 2017/9/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DoctorConsultHonorModel.h"

@interface SDDoctorConsultModel : NSObject<YYModel>

@property(nonatomic,copy) NSString *member_names; //医生名字
@property(nonatomic,copy) NSString *member_aptitude; //医生资质
@property(nonatomic,copy) NSString *member_occupation; //医生所在医院
@property(nonatomic,copy) NSString *member_ks; //科室
@property(nonatomic,copy) NSString *member_personal; //个人简介
@property(nonatomic,copy) NSString *live_store_tel; //医生电话
@property(nonatomic,copy) NSString *member_avatar; //医生头像
@property(nonatomic,copy) NSString *huanxinpew;//医生荣云
@property(nonatomic,strong) NSArray *honor;

-(NSMutableArray<DoctorConsultHonorModel *> *) consultHonor;

@end
