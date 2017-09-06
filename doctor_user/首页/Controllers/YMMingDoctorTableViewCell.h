//
//  YMMingDoctorTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMMingDoctorTableViewCell;
@protocol YMMingDoctorTableViewCellDelegate <NSObject>

-(void)MingDoctorTableViewCell:(YMMingDoctorTableViewCell *)MingDoctorTableViewCell rightSubClick:(UIButton *)sender;

@end

@interface YMMingDoctorTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMMingDoctorTableViewCellDelegate> delegate;

@property(nonatomic,copy)NSString *titleName;
@property(nonatomic,copy)NSString *subTitleName;
@property(nonatomic,assign)BOOL showImage;

@property(nonatomic,assign)BOOL lastOne;//最后一个Cell

@property(nonatomic,assign) BOOL lineInterval;//间隔

@end
