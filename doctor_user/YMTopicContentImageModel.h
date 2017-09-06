//
//  YMTopicContentImageModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMTopicContentImageModel : NSObject

@property(nonatomic,copy)NSString *userHeader;//用户头像
@property(nonatomic,copy)NSString *userName;//用户名
@property(nonatomic,copy)NSString *userHospital;//所属医院

@property(nonatomic,copy)NSString *Duties;//职务

@property(nonatomic,copy)NSString *content;//内容

@property(nonatomic,strong)NSArray *imageArry;//图片内容

@property(nonatomic,copy)NSString *releaseTime;//发布时间

@property(nonatomic,assign)NSNumber *praise;//已赞：1 没赞：2

@property(nonatomic,assign)NSNumber *praiseNumber;//赞数量

@property(nonatomic,strong)NSDictionary *replyContent;//回复类容

-(void)initAssignmentData:(NSDictionary *)assignmentData;

@end
