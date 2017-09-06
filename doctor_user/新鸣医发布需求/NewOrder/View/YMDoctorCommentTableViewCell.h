//
//  YMDoctorCommentTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCheckPingModel.h"

@interface YMDoctorCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)YMCheckPingModel *model;

+(CGFloat)heightDoctorComment:(NSString *)doctorComment;
@end
