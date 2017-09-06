//
//  YMOfficialActivityModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/21.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMOfficialActivityModel : NSObject

@property(nonatomic,copy)NSString *activity_id;//活动ID
@property(nonatomic,copy)NSString *title;//活动主题
@property(nonatomic,copy)NSString *image;//主题图片
@property(nonatomic,copy)NSString *start_time; //开始日期
@property(nonatomic,copy)NSString *end_time;//结束日期
@property(nonatomic,copy)NSString *conditions;//参与条件
@property(nonatomic,copy)NSString *intro;//活动简介

@end
