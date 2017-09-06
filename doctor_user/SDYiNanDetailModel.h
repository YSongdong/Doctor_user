//
//  SDYiNanDetailModel.h
//  doctor_user
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDYiNanDetailModel : NSObject

@property(nonatomic,copy) NSString *diseases_id; //疑难杂症id
@property(nonatomic,copy) NSString *leaguer_id; //成员id
@property(nonatomic,copy) NSString *title; //疑难杂症症状描述
@property(nonatomic,copy) NSString *diseases_time; //疑难杂症开始时间
@property(nonatomic,copy) NSString *diseases_time2; //疑难杂症结束时间
@property(nonatomic,copy) NSString *diagnosis_time; //第一次诊断时间
@property(nonatomic,copy) NSString *diagnosis_times; //第二次诊断时间
@property(nonatomic,copy) NSString *diseases_company; //疑难杂症详情描述
@property(nonatomic,copy) NSString *leagure_name;  //成员名
@property(nonatomic,copy) NSString *leagure_sex;  //成员性别
@property(nonatomic,copy) NSString *leagure_idcard; //成员年龄
@property(nonatomic,copy) NSString *member_avatar; //成员头像
@property(nonatomic,copy) NSString *diseases_img0; //疑难杂症图片
@property(nonatomic,copy) NSString *diseases_img1;
@property(nonatomic,copy) NSString *diseases_img2;
@property(nonatomic,copy) NSString *diseases_img3;
@property(nonatomic,copy) NSString *diseases_img4;
@property(nonatomic,copy) NSString *diseases_img5;
@property(nonatomic,copy) NSString *status;  //状态
@property(nonatomic,copy) NSString *status_desc; //状态
@end
