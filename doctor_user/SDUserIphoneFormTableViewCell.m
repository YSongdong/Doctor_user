//
//  SDUserIphoneFormTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDUserIphoneFormTableViewCell.h"

@interface SDUserIphoneFormTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *emergencyContactPeopleLab; //紧急联系人

@property (weak, nonatomic) IBOutlet UILabel *contactPeopleNumberLab; //联系人电话
@property (weak, nonatomic) IBOutlet UILabel *privateDoctorNameLab; //私人医生名字

@property (weak, nonatomic) IBOutlet UILabel *doctorIphoneLab; //私人医生电话

@property (weak, nonatomic) IBOutlet UILabel *healthyManagerNameLab; //健康管理师名字
@property (weak, nonatomic) IBOutlet UILabel *managerIphoneLab; //健康管理师电话

@property (weak, nonatomic) IBOutlet UILabel *otherLabel; //其他

@property (weak, nonatomic) IBOutlet UIView *iphoneFormBackgrouView;

@end


@implementation SDUserIphoneFormTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
   
}
-(void)updateUI{

    self.iphoneFormBackgrouView.layer.cornerRadius = 5;
    self.iphoneFormBackgrouView.layer.masksToBounds = YES;
    self.iphoneFormBackgrouView.layer.borderWidth = 1;
    self.iphoneFormBackgrouView.layer.borderColor = [UIColor NaviBackgrounColor].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
