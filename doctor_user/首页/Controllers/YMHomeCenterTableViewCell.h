//
//  YMHomeCenterTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/29.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMHomeCenterTableViewCell;

@protocol YMHomeCenterTableViewCellDelegate <NSObject>
//订单
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell dingDanButton:(UIButton *)sender;
//医生库
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell doctorButton:(UIButton *)sender;
//护士库
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell nurseButton:(UIButton *)sender;
//需求大厅
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell xuQiuButton:(UIButton *)sender;
//案例库
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell anLiKuButton:(UIButton *)sender;
//鸣医助手
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell zhuShowButton:(UIButton *)sender;
//疑难杂症
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell zaZhengButton:(UIButton *)sender;
//体检报告
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell tiJianButton:(UIButton *)sender;
//活动
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell activityButton:(UIButton *)sender;

//点击热点
-(void) selectdHospotUrl:(NSString *)url andTitle:(NSString *)title;
@end

@interface YMHomeCenterTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMHomeCenterTableViewCellDelegate> delegate;

@end
