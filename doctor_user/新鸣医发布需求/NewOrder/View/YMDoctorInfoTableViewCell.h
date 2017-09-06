//
//  YMDoctorInfoTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMBidListModel.h"

@class YMDoctorInfoTableViewCell;
@protocol YMDoctorInfoTableViewCellDelegate <NSObject>

-(void)doctorInfoCell:(YMDoctorInfoTableViewCell *)cell bidModel:(YMBidListModel *)bidModel;

@end

@interface YMDoctorInfoTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMDoctorInfoTableViewCellDelegate> delegate;

@property(nonatomic,strong)YMBidListModel *model;

@end
