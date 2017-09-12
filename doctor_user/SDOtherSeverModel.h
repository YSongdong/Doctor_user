//
//  SDOtherSeverModel.h
//  doctor_user
//
//  Created by dong on 2017/9/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDOtherSeverModel : NSObject

@property(nonatomic,copy) NSString * service_id; //增值业务id
@property(nonatomic,copy) NSString * service_title;  //业务标题
@property(nonatomic,copy) NSString * service_content; //业务介绍
@property(nonatomic,copy) NSString * service_img; //业务图片
@property(nonatomic,copy) NSString * service_url; //业务连接
@property(nonatomic,copy) NSString * start_time;   //开始时间
@property(nonatomic,copy) NSString * end_time;  //结束时间
@property(nonatomic,copy) NSString * status;  //状态
@property(nonatomic,copy) NSString * created_time; //创建时间


@end
