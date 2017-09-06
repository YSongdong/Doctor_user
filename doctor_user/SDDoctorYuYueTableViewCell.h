//
//  SDDoctorYuYueTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDDoctorYuYueTableViewCellDelegate <NSObject>

-(void)selectdTimeBtnAction:(UIButton *)sender;

@end

@interface SDDoctorYuYueTableViewCell : UITableViewCell

@property(nonatomic,weak) id <SDDoctorYuYueTableViewCellDelegate> delegate;

@property(nonatomic,strong) NSString *selectTime;

@end
