//
//  YMDoctorCell.h
//  doctor_user
//
//  Created by kupurui on 2017/2/10.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ContactDoctorBlock)(id value);
typedef void(^SecondBtnClickBlock)(id value,NSInteger status);
typedef void(^ThirdBtnClickBlock)(id value);
typedef void(^ClickHeadBlock)(id value);

@interface YMDoctorCell : UITableViewCell

@property (nonatomic,strong)NSDictionary *dic ;

@property (nonatomic,copy)ContactDoctorBlock contactBlock ;//联系医生
@property (nonatomic,copy)SecondBtnClickBlock secondBtnBlock ;//联系医生
@property (nonatomic,copy)ThirdBtnClickBlock thirdBtnClickBlock ;//联系医生
@property (nonatomic,copy)ClickHeadBlock headBtnBlock ;//联

@end
