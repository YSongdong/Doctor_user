//
//  SDDoctorInfoTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDDoctorConsultModel.h"

@class SDDoctorInfoTableViewCell;

@protocol SDDoctorInfoTableViewCellDelegate <NSObject>

-(void)HeaderTableViewCell:(SDDoctorInfoTableViewCell *)headerTableViewCell sender:(UIButton *)sender;

@end



@interface SDDoctorInfoTableViewCell : UITableViewCell


@property(nonatomic,weak) id <SDDoctorInfoTableViewCellDelegate> delegate;


@property(nonatomic,assign)BOOL clcickEvent;

@property (nonatomic,strong) SDDoctorConsultModel *model;

+(CGFloat)DetailsViewHeight:(NSString *)text detailsClick:(BOOL)detailsClick;

+(CGFloat)memberPersonalInfoHeight:(NSString *)memberPersonalInfo;
@end
