//
//  SDMineInfoTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDMyPrivateDoctorModel.h"

@protocol SDMineInfoTableViewCellDelegate <NSObject>
//个人健康状况
-(void)selectdHealthyStatesBtn:(UIButton *)sender;
//健康管理方案
-(void)selectdHealthyManamgerBtn:(UIButton *)sender;
//体检报告查看
-(void)selectdTiJianBtn:(UIButton *)sender;


@end



@interface SDMineInfoTableViewCell : UITableViewCell

@property(nonatomic,weak) id <SDMineInfoTableViewCellDelegate> delegate;

@property(nonatomic,strong) SDMyPrivateDoctorModel *model;

@end
