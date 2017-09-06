//
//  SDMineInfoView.m
//  doctor_user
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDMineInfoView.h"

@interface SDMineInfoView ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView; //用户头像

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel; //用户名字

@property (weak, nonatomic) IBOutlet UILabel *userAddressLabel;//用户居住地址

@property (weak, nonatomic) IBOutlet UILabel *useriphoneNumberLabel; //用户电话
@property (weak, nonatomic) IBOutlet UILabel *memberlimitTimeLab; //会员期限

@property (weak, nonatomic) IBOutlet UIView *btnBackGrounView;//按钮背景

- (IBAction)heahthyStatusBtnAction:(UIButton *)sender; //健康状况

- (IBAction)healthyManagerBtnAction:(UIButton *)sender; //健康管理
- (IBAction)tijianReportBtnAction:(UIButton *)sender; //体检报告





@end




@implementation SDMineInfoView

-(void)awakeFromNib{

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



//健康状况
- (IBAction)heahthyStatusBtnAction:(UIButton *)sender {
}
//健康管理
- (IBAction)healthyManagerBtnAction:(UIButton *)sender {
}
//体检报告
- (IBAction)tijianReportBtnAction:(UIButton *)sender {
}
@end
