//
//  YMMyAttentionTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/19.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMMyAttentionModel.h"
#import "YMDoctorLibaryModel.h"


@protocol YMMyAttentionTableViewCellDelegate <NSObject>

-(void)doctorLibaryMedicalCareBtn:(NSIndexPath *)indexPath;

@end



@interface YMMyAttentionTableViewCell : UITableViewCell

//传一个model即可

@property(nonatomic,strong)YMMyAttentionModel *model;//关注model
@property(nonatomic,strong)YMDoctorLibaryModel *doctorModel;//医生库model
@property(nonatomic,assign) BOOL isStar; //判断是否我的关注
@property(nonatomic,strong) NSIndexPath *indexPath;
@property (weak,nonatomic) id <YMMyAttentionTableViewCellDelegate> delegate;
@end
