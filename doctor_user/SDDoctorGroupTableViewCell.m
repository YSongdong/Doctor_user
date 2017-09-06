//
//  SDDoctorGroupTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDDoctorGroupTableViewCell.h"

@interface SDDoctorGroupTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *cellGroupBtn; //按钮
- (IBAction)cellGroupBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel; //时间lable

@property (weak, nonatomic) IBOutlet UILabel *hospitalNameLabel;//医院
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;//序号

@property (weak, nonatomic) IBOutlet UIView *explairBackgrounView;

@property (weak, nonatomic) IBOutlet UILabel *showTimeLab; //显示体检时间label


@end


@implementation SDDoctorGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}

-(void)updateUI{
    
    self.cellGroupBtn.layer.cornerRadius = 5;
    self.cellGroupBtn.layer.masksToBounds = YES;
    
    self.explairBackgrounView.layer.cornerRadius = 5;
    self.explairBackgrounView.layer.masksToBounds = YES;
    self.explairBackgrounView.layer.borderWidth = 1;
    self.explairBackgrounView.layer.borderColor = [UIColor lineColor].CGColor;
    
}
-(void)setClassType:(NSString *)classType{
    //1 体检报告查看 2健康管理 3体检解读 4绿色住院通道 5年度健康报告 6医生服务到家 7医生服务到家-预约服务
    if ([classType isEqualToString:@"1"]) {
        self.showTimeLab.text = @"体检时间:";
    }else  if ([classType isEqualToString:@"3"]) {
        self.showTimeLab.text = @"解读医师";
    }else  if ([classType isEqualToString:@"5"]) {
        self.showTimeLab.text = @"";
    }
    

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cellGroupBtnAction:(UIButton *)sender {
}
@end
