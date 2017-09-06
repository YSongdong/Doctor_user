//
//  YMMyHeaderTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMUserInforModel.h"

@class YMMyHeaderTableViewCell;

@protocol YMMyHeaderTableViewCellDelegate <NSObject>

-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell setUp:(UIButton *)sender;//设置点击
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell message:(UIButton *)sender;//消息
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell upDataHeaderImage:(UIButton *)sender;//头像
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell myMingyYi:(UIButton *)sender;//鸣医
//服务
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell purchaseServer:(UIButton *)sender;
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell presentation:(UIButton *)sender;//报告
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell registerInfor:(UIButton *)sender;//挂号信息

-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell backGroup:(UIButton *)sender;//顶部背景
//进入我的账户
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell myAccount:(UIButton *)sender;
//进入编辑
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell upEdit:(UIButton *) sender;


@end

@interface YMMyHeaderTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMMyHeaderTableViewCellDelegate> delegate;

@property(nonatomic,strong)YMUserInforModel *model;

@end
