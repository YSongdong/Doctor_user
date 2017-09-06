//
//  SDFilesMessageModel.h
//  doctor_user
//
//  Created by dong on 2017/9/6.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDFilesMessageModel : NSObject <YYModel>

@property(nonatomic,copy) NSString *p_health_id; //私人医生会员id
@property(nonatomic,copy) NSString *p_sn; //档案号
@property(nonatomic,copy) NSString *member_name;  //用户姓名
@property(nonatomic,copy) NSString *birthday; //用户生日
@property(nonatomic,copy) NSString *blood; //血型
@property(nonatomic,copy) NSString *address;  //居住地址
@property(nonatomic,copy) NSString *diseases; //疾病史
@property(nonatomic,copy) NSString *allergic; //过敏史
@property(nonatomic,copy) NSString *emergency_name; //紧急联系人
@property(nonatomic,copy) NSString *emergency_phone; //联系人电话
@property(nonatomic,copy) NSString *private_name; //私人医生
@property(nonatomic,copy) NSString *private_phone; //联系电话
@property(nonatomic,copy) NSString *manager_name; //健康管理师
@property(nonatomic,copy) NSString *manager_phone;  //联系电话
@property(nonatomic,copy) NSString *desc;   //其他说明

@end
