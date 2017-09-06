//
//  SDHealthyManagerTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDHealthyManagerTableViewCell.h"

@interface SDHealthyManagerTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *cellDownBtn; //下载

- (IBAction)cellDownBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *cellBackgrounView;


@end


@implementation SDHealthyManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}
-(void)updateUI{
    
    self.cellDownBtn.layer.cornerRadius = 5;
    self.cellDownBtn.layer.masksToBounds = YES;
   
    self.cellBackgrounView.layer.cornerRadius = 5;
    self.cellBackgrounView.layer.masksToBounds = YES;
    self.cellBackgrounView.layer.borderWidth = 1;
    self.cellBackgrounView.layer.borderColor = [UIColor lineColor].CGColor;
    
}
-(void)setManagerType:(NSString *)ManagerType{
   //1 体检报告查看 2健康管理 3体检解读 4绿色住院通道 5年度健康报告 6医生服务到家 7医生服务到家-预约服务
    if ([ManagerType isEqualToString:@"2"]) {
        self.timeLabel.text = @"2017年08月01日方案";
    }else  if ([ManagerType isEqualToString:@"5"]) {
        self.timeLabel.text = @"年度健康报告:2017年08月01日";
    }else  if ([ManagerType isEqualToString:@"6"]) {
        self.timeLabel.text = @"NO.1 2017年08月01日";
        [self.cellDownBtn setTitle:@"已完成" forState:UIControlStateNormal];
    }


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;

}
-(void)setIsOpen:(BOOL)isOpen{

    _isOpen = isOpen;
    if (isOpen) {
        [self.cellDownBtn setTitle:@"打开" forState:UIControlStateNormal];
    }

}

- (IBAction)cellDownBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectdDownOrOpenBtn:andIndexPath:)]) {
        [self.delegate selectdDownOrOpenBtn:sender andIndexPath:self.indexPath];
    }
    
}
@end