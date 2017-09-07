//
//  DoctorConsultHonorModel.h
//  doctor_user
//
//  Created by dong on 2017/9/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorConsultHonorModel : NSObject
@property(nonatomic,copy) NSString *honor_id; //荣誉id
@property(nonatomic,copy) NSString *honor_mid; //荣誉名字
@property(nonatomic,copy) NSString *honor_name; //荣誉名字
@property(nonatomic,copy) NSString *honor_time;  //获得时间
@property(nonatomic,copy) NSString *honor_image;  //荣誉图片
@end
