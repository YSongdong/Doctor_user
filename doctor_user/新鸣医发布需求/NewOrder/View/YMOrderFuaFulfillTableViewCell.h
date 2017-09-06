//
//  YMOrderFuaFulfillTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YMDoctorOrderProcessModel.h"
@class YMOrderFuaFulfillTableViewCell;

@protocol YMOrderFuaFulfillTableViewCellDelegate <NSObject>

-(void)orderFuaFulfillCell:(YMOrderFuaFulfillTableViewCell *)cell lookevaluationButton:(UIButton *) sender;//查看评价

-(void)orderFuaFulfillCell:(YMOrderFuaFulfillTableViewCell *)cell evaluationButton:(UIButton *)sender;//去评价

@end

@interface YMOrderFuaFulfillTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMOrderFuaFulfillTableViewCellDelegate> delegate;

@property(nonatomic,strong)YMDoctorOrderProcessModel *model;

@property(nonatomic,assign)BOOL whetherPay;

@property(nonatomic,assign)BOOL evaluation;

@end
