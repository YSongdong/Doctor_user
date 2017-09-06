//
//  SDStateFormExplairTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDStateFormExplairTableViewCell.h"


@interface SDStateFormExplairTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *explairBtn;
@property (weak, nonatomic) IBOutlet UIView *explairBackgrounView;


@end



@implementation SDStateFormExplairTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}
-(void)updateUI{

    self.explairBtn.layer.cornerRadius = 5;
    self.explairBtn.layer.masksToBounds = YES;
    self.explairBtn.backgroundColor = [UIColor NaviBackgrounColor];
    
    self.explairBackgrounView.layer.cornerRadius = 5;
    self.explairBackgrounView.layer.masksToBounds = YES;
    self.explairBackgrounView.layer.borderWidth = 1;
    self.explairBackgrounView.layer.borderColor = [UIColor NaviBackgrounColor].CGColor;

}

-(void)setTextType:(NSString *)textType{
    //1 体检报告查看 2健康管理 3体检解读 4绿色住院通道 5年度健康报告 6医生服务到家 7医生服务到家-预约服务
    if ([textType isEqualToString:@"1"]) {
       
        self.explairLabel.text = @"自购买高端商务私人医生服务卡起一年内，乙方将为甲方免费提供常规全面体检。此卡包含常规体检次数2次，体检项目范围为常规体检";
    }else  if ([textType isEqualToString:@"2"]) {
        self.explairLabel.text = @"自购买高端商务私人医生服务卡起一年内，甲方可享受全科医生量身定制健康管理方案1份，健康管理方案于全科医生上门采集用户健康信息后一周内制定完成。";
    }else  if ([textType isEqualToString:@"3"]) {
        self.explairLabel.text = @"客户及其家人共同享有三甲名医体检报告解读服务 5 次。体检报告解读专家团队成员来自西南医院、重庆医科大学。附属第一医院等三甲医院，职务均为副主任医师级别以上或博士学位。";
    }else  if ([textType isEqualToString:@"4"]) {
        self.explairLabel.text = @"自购买高端商务私人医生服务卡起壹年内，乙方为甲方提供 1次“预约式”的住院服务。服务过程中，是否达到住院的标准由乙方安排接诊的医生判定，达到住院标准（即开具住院单），乙方将安排健康管理师代办住院手续和床位协调工作，服务时间半天。";
    }else  if ([textType isEqualToString:@"5"]) {
        self.explairLabel.text = @"自购买医生联盟私人医生服务卡起 壹 年内，乙方将对甲方的健康进行长期跟踪管理，为甲方出具 1 份年度健康报告。出具报告的时间为服务期满前一月内。该健康报告将为甲方标注异常指标，发现潜在威胁，预测未来健康风险并提供专业的健康管理建议。";
    }else  if ([textType isEqualToString:@"6"]) {
        self.explairLabel.text = @"客户自购买服务卡起壹年内，可享受全科医生“健康到家”服务 1 次。服务内容包括健康咨询、采集用户健康信息，服务时间为 2 小时内。服务对象仅限于持卡本人，服务人员包括私人医生、健康顾问。服务时间为体检完成后一周内，服务地点及具体时间由甲乙双方协商决定。";
    }else  if ([textType isEqualToString:@"7"]) {
        self.explairLabel.text = @"客户自购买服务卡起壹年内，可享受全科医生“健康到家”服务 1 次。服务内容包括健康咨询、采集用户健康信息，服务时间为 2 小时内。服务对象仅限于持卡本人，服务人员包括私人医生、健康顾问。服务时间为体检完成后一周内，服务地点及具体时间由甲乙双方协商决定。";
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
