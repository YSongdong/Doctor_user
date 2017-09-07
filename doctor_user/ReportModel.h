//
//  ReportModel.h
//  doctor_user
//
//  Created by dong on 2017/9/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportModel : NSObject

@property(nonatomic,copy) NSString *report_id;//解读报告id
@property(nonatomic,copy) NSString *p_health_id; //私人医生id
@property(nonatomic,copy) NSString *report_name; //报告名字
@property(nonatomic,copy) NSString *report_doctor; //解读医生
@property(nonatomic,copy) NSString *report_url; //下载路径
@property(nonatomic,copy) NSString *report_time; //解读时间
@property(nonatomic,copy) NSString *created_time;//上传报告时间
@property(nonatomic,copy) NSString *status; //预约状态
@property(nonatomic,copy) NSString *status_desc; //预约状态


@end
