//
//  YMDoctorAskedTableViewCell.h
//  doctor_user
//  医生嘱述
//  Created by 黄军 on 17/6/6.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDoctorOrderProcessModel.h"

@class YMDoctorAskedTableViewCell;

@protocol YMDoctorAskedTableViewCellDelegate <NSObject>

-(void)doctorAskedViewCell:(YMDoctorAskedTableViewCell *)doctorAskedViewCell aplayButton:(UIButton *)aplayButton;//付款

-(void)doctorAskedViewCell:(YMDoctorAskedTableViewCell *)doctorAskedViewCell arbitration:(UIButton *)arbitration;//仲裁

@end


@interface YMDoctorAskedTableViewCell : UITableViewCell

@property(nonatomic,strong)YMDoctorOrderProcessModel *model;

@property(nonatomic,assign)BOOL yuYue;

@property(nonatomic,weak)id<YMDoctorAskedTableViewCellDelegate> delegate;

+(CGFloat)DoctorAskedHeight:(NSString *)askedStr picNum:(NSInteger)number referralInfo:(NSString *)referralInfo;

@end
