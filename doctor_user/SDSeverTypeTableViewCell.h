//
//  SDSeverTypeTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDMyPrivateDoctorModel.h"

@protocol SDSeverTypeTableViewCellDelegate <NSObject>

-(void)selectdSeverBtnTag:(NSInteger)tag;

@end

@interface SDSeverTypeTableViewCell : UITableViewCell

@property(nonatomic,weak) id <SDSeverTypeTableViewCellDelegate> delegate;

@property(nonatomic,strong) SDMyPrivateDoctorModel *model;

@end
