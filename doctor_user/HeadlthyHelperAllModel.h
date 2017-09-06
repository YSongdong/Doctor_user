//
//  HeadlthyHelperAllModel.h
//  doctor_user
//
//  Created by dong on 2017/8/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HeadlthyAllMealthModel,HeadlMedictionModel,HeadlMedicalModel,healthHistModel,headlthyDetailModel;

@interface HeadlthyHelperAllModel : NSObject<YYModel>

@property (nonatomic,strong) HeadlthyAllMealthModel  *mealth; //用户信息

@property (nonatomic,strong) HeadlMedictionModel *health_medication; //用药

@property (nonatomic,strong)  HeadlMedicalModel  * health_medical ; //提醒

@property (nonatomic,strong) healthHistModel  *health_history; //历史


@end

 //用户信息
@interface HeadlthyAllMealthModel : NSObject

@property(nonatomic,copy) NSString *mealth_sex; //用户性别
@property(nonatomic,copy) NSString *member_id; //用户id
@property(nonatomic,copy) NSString *health_id; //健康id
@property(nonatomic,copy) NSString *mealth_img;  //用户头像
@property(nonatomic,copy) NSString *mealth_name; //姓名
@property(nonatomic,copy) NSString *mealth_age; //岁数
@property(nonatomic,copy) NSString *mealth_city; //用户城市
@property(nonatomic,copy) NSString *mealth_profession; //用户职业

@end

//用药
@interface HeadlMedictionModel : NSObject<YYModel>

@property(nonatomic,copy) NSString *medication_id;  //提醒用药id
@property(nonatomic,copy) NSString *orders;   //医嘱
@property(nonatomic,copy) NSString *is_open;  //提醒用药铃声 1开启 2关闭
@property(nonatomic,strong) headlthyDetailModel *detail; // 详情

@end
// 详情
@interface headlthyDetailModel : NSObject
@property(nonatomic,copy) NSString *warn_id; //药物id
@property(nonatomic,copy) NSString *second; //一日几次：1 一次、2 两次 、3次
@property(nonatomic,copy) NSString *day; //用药天数
@property(nonatomic,copy) NSString *drug; //药品名
@property(nonatomic,copy) NSString *medication_time;//提醒结束时间
@end

//提醒
@interface HeadlMedicalModel : NSObject

@property(nonatomic,copy) NSString *doctor;   //就诊医生
@property(nonatomic,copy) NSString *big_ks;  //大科室
@property(nonatomic,copy) NSString *small_ks;  //小科室
@property(nonatomic,copy) NSString *small_ksh; //中文字段
@property(nonatomic,copy) NSString *remarks;  //备注
@property(nonatomic,copy) NSString *doctor_time;  //就诊时间
@property(nonatomic,copy) NSString *is_open;   //就诊用药铃声 1开启 2关闭
@property(nonatomic,copy) NSString *medical_id; //就诊提醒id

@end

//历史
@interface healthHistModel : NSObject
@property(nonatomic,copy) NSString *history_id; //就诊历史id
@property(nonatomic,copy) NSString *title; //标题
@property(nonatomic,copy) NSString *history_time; //就诊时间
@property(nonatomic,copy) NSString *history_image; //图片

-(NSString *)year;
-(NSString *)month;
-(NSString *)day;


@end
