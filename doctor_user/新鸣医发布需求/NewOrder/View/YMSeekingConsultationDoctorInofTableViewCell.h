//
//  YMSeekingConsultationDoctorInofTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDoctorOrderProcessModel.h"

@class YMSeekingConsultationDoctorInofTableViewCell;
@protocol YMSeekingConsultationDoctorInofTableViewCellDelegate <NSObject>

-(void)SeekingConsultationDoctorView:(YMSeekingConsultationDoctorInofTableViewCell *)cell lookHetong:(UIButton *)sender;

@end
@interface YMSeekingConsultationDoctorInofTableViewCell : UITableViewCell

@property(nonatomic,strong)YMDoctorOrderProcessModel *model;

@property(nonatomic,weak)id<YMSeekingConsultationDoctorInofTableViewCellDelegate> delegate;

+(CGFloat)heightForTips:(NSArray *)tips;

@end
