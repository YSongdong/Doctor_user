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
-(void)setModel:(SDFilesMessageModel *)model{

    _model= model;
    //紧急联系人
    self.emergencyContactPeopleLab.text = model.emergency_name;
    //紧急联系人电话
    self.contactPeopleNumberLab.text = model.emergency_phone;
    //私人医生
    self.privateDoctorNameLab.text = model.private_name;
    //私人医生电话
    self.doctorIphoneLab.text = model.private_phone;
    //健康管理师
    self.healthyManagerNameLab.text = model.manager_name;
    //健康管理师电话
    self.managerIphoneLab.text = model.manager_phone;
    //其他说明
    self.otherLabel.text = model.desc;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
