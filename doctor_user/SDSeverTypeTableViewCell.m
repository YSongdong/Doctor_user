//
//  SDSeverTypeTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDSeverTypeTableViewCell.h"

@interface SDSeverTypeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *physicalExaminationLab; //全身健康体检

@property (weak, nonatomic) IBOutlet UILabel *famousDoctorsLab; //名医体检解读
@property (weak, nonatomic) IBOutlet UILabel *serviceHomeLab;//医生服务到家总数
@property (weak, nonatomic) IBOutlet UILabel *healthManagementLab; //健康管理方案

@property (weak, nonatomic) IBOutlet UILabel *greenAccessLab; //绿色住院通道
@property (weak, nonatomic) IBOutlet UILabel *greenHospitalLab;  //绿色就诊通道
@property (weak, nonatomic) IBOutlet UILabel *annualReportLab;//年度健康报告


@end


@implementation SDSeverTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
   
}
-(void) updateUI{

    for (int i=0; i< 9; i++) {
        UIButton *btn = [self viewWithTag:500+i];
        [btn addTarget:self action:@selector(onSeverBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }

}

-(void)onSeverBtnAction:(UIButton *)sender{
   
    if ([self.delegate respondsToSelector:@selector(selectdSeverBtnTag:)]) {
        [self.delegate selectdSeverBtnTag:sender.tag-500];
    }

}

-(void)setModel:(SDMyPrivateDoctorModel *)model{

    _model =model;

    //全身健康体检
    self.physicalExaminationLab.text = [NSString stringWithFormat:@"(%@/%@)",model.physical_examination_con,model.physical_examination];
    //名医体检解读
    self.famousDoctorsLab.text =[NSString stringWithFormat:@"(%@/%@)",model.famous_doctors_con,model.famous_doctors];
    //医生服务到家
    self.serviceHomeLab.text =[NSString stringWithFormat:@"(%@/%@)",model.service_home_con,model.service_home];
    //健康管理方案
    self.healthManagementLab.text =[NSString stringWithFormat:@"(%@/%@)",model.health_management_con,model.health_management];
   //绿色住院通道
    self.greenAccessLab.text =[NSString stringWithFormat:@"(%@/%@)",model.green_access_con,model.green_access];
    //绿色就诊通道
    self.greenHospitalLab.text =[NSString stringWithFormat:@"(%@/%@)",model.green_hospital_con,model.green_hospital];
    //年度健康报告
    self.annualReportLab.text =[NSString stringWithFormat:@"(%@/%@)",model.annual_report_con,model.annual_report];

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
