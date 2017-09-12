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
   
    if ([classType isEqualToString:@"1"]) {
        self.showTimeLab.text = @"体检时间:";
    }else  if ([classType isEqualToString:@"3"]) {
        self.showTimeLab.text = @"解读医师:";
    }else  if ([classType isEqualToString:@"5"]) {
        self.showTimeLab.text = @"";
    }
    
}
-(void)setdictManageType:(NSString *)type andIndexPath:(NSIndexPath *)indexPath andWithDict:(NSDictionary *)dict{
     //1 体检报告查看 2健康管理 3体检解读 4绿色住院通道 5年度健康报告 6医生服务到家 7医生服务到家-预约服务
    if ([type isEqualToString:@"3"]) {
        //名医体检解读
        self.showTimeLab.text = @"解读医师:";
        //名字
        NSString *numberStr = [NSString stringWithFormat:@"NO.%ld",indexPath.row+1];
        self.serialNumberLabel.text = [NSString stringWithFormat:@"%@ %@",numberStr,[dict objectForKey:@"report_time"]];
        //解读医师
        self.timeLabel.text = [dict objectForKey:@"report_doctor"];
        //按钮
        [self.cellGroupBtn setTitle:@"下载" forState:UIControlStateNormal];
        self.cellGroupBtn.backgroundColor = [UIColor colorWithHexString:@"#409FFF"];
    }else if ([type isEqualToString:@"1"]) {
        NSLog(@"dic ===%@",dict);
        //名医体检解读
        self.showTimeLab.text = @"体验时间:";
        //名字
        NSString *numberStr = [NSString stringWithFormat:@"NO.%ld",indexPath.row+1];
        self.serialNumberLabel.text = [NSString stringWithFormat:@"%@ %@",numberStr,[dict objectForKey:@"report_name"]];
        //解读医师
        self.timeLabel.text = [dict objectForKey:@"report_time"];
        //按钮
        [self.cellGroupBtn setTitle:@"下载" forState:UIControlStateNormal];
        self.cellGroupBtn.backgroundColor = [UIColor colorWithHexString:@"#409FFF"];
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
        [self.cellGroupBtn setTitle:@"打开" forState:UIControlStateNormal];
    }
    
}
- (IBAction)cellGroupBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdDownBtnIndexPath:)]) {
        [self.delegate selectdDownBtnIndexPath:self.indexPath];
    }
    
}
@end
