//
//  YMYuYueOrderInfoTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDoctorOrderProcessModel.h"

@class YMYuYueOrderInfoTableViewCell;
@protocol YMYuYueOrderInfoTableViewCellDelegate <NSObject>

//查看合同
-(void)yuYueOrderView:(YMYuYueOrderInfoTableViewCell *)cell lookHeTongClick:(UIButton *)sender;

//签合同
-(void)yuYueOrderView:(YMYuYueOrderInfoTableViewCell *)cell qianHeTongClick:(UIButton *)sender;
//支付
-(void)yuYueOrderView:(YMYuYueOrderInfoTableViewCell *)cell payServerCharge:(UIButton *)sender;

@end

@interface YMYuYueOrderInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)YMDoctorOrderProcessModel *model;

@property(nonatomic,weak)id<YMYuYueOrderInfoTableViewCellDelegate> delegate;

+(CGFloat)heightForNote:(NSString *)note;
@end
