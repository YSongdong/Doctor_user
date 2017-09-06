//
//  YMActivityDetailsModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/21.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMActivityDetailsModel : NSObject
@property(nonatomic,copy)NSString *apply_id; //报名ID，未报名时返回空
@property(nonatomic,copy)NSString *stauts;//参与状态，0未报名，1审核中，2审核通过，3审核失败
@property(nonatomic,copy)NSString *stauts_str; //状态说明文字
@property(nonatomic,copy)NSString *activity_id;//活动ID
@property(nonatomic,copy)NSString *content;//活动详情，html格式

@property(nonnull,copy)NSString *is_first;//是否首单活动，1是，0否

@property(nonatomic,copy)NSString *is_apply; //用户是否已参加，0未参与，1已参与

@property(nonatomic,copy)NSString *title;//活动标题

@end
