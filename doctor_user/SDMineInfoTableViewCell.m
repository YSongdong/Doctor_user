//
//  SDMineInfoTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDMineInfoTableViewCell.h"

@interface SDMineInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView; //用户头像

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel; //用户名字
@property (weak, nonatomic) IBOutlet UILabel *userAddressLabel;//居住地址

@property (weak, nonatomic) IBOutlet UILabel *useriphoneNumberLabel; //用户电话

@property (weak, nonatomic) IBOutlet UILabel *memberlimitTimeLab;//会员到期时间

@property (weak, nonatomic) IBOutlet UIView *btnBackGrounView;//按钮背景view

 //健康状况
- (IBAction)heahthyStatusBtnAction:(UIButton *)sender;
//健康管理
- (IBAction)healthyManagerBtnAction:(UIButton *)sender;
//体检报告
- (IBAction)tijianReportBtnAction:(UIButton *)sender;



@end


@implementation SDMineInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}
-(void)updateUI{
    //头像
    self.userHeaderImageView.layer.cornerRadius = CGRectGetHeight(self.userHeaderImageView.frame)/2;
    self.userHeaderImageView.layer.masksToBounds = YES;
    self.userHeaderImageView.layer.borderWidth  = 1;
    self.userHeaderImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //背景view
    self.btnBackGrounView.layer.cornerRadius = CGRectGetHeight(self.btnBackGrounView.frame)/2;
    self.btnBackGrounView.layer.masksToBounds = YES;
    self.btnBackGrounView.layer.borderWidth  = 1;
    self.btnBackGrounView.layer.borderColor = [UIColor whiteColor].CGColor;
    
  
}


-(void)setModel:(SDMyPrivateDoctorModel *)model{

    _model = model;
    //头像
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    //姓名
    self.userNameLabel.text = model.member_name;
    
    //有效期
    self.memberlimitTimeLab.text = [NSString stringWithFormat:@"会员有效期:%@",model.endDate];
   //地址
    self.userAddressLabel.text = model.address;
    //电话
    self.useriphoneNumberLabel.text = model.member_mobile;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
 //健康状况
- (IBAction)heahthyStatusBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdHealthyStatesBtn:)]) {
        [self.delegate selectdHealthyStatesBtn:sender];
    }
}
//健康管理
- (IBAction)healthyManagerBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdHealthyManamgerBtn:)]) {
        [self.delegate selectdHealthyManamgerBtn:sender];
    }
}
//体检报告
- (IBAction)tijianReportBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdTiJianBtn:)]) {
        [self.delegate selectdTiJianBtn:sender];
    }
}
@end
