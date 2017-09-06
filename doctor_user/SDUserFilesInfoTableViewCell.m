//
//  SDUserFilesInfoTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDUserFilesInfoTableViewCell.h"


@interface SDUserFilesInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLab; //姓名

@property (weak, nonatomic) IBOutlet UILabel *userBirthdayLab; //生日
@property (weak, nonatomic) IBOutlet UILabel *userBloodTypeLab; //血型

@property (weak, nonatomic) IBOutlet UILabel *userAddressLab; //地址

@property (weak, nonatomic) IBOutlet UILabel *userDiseaseHistorLab; //疾病史

@property (weak, nonatomic) IBOutlet UILabel *userAnapHistoryLab;//过敏史

@property (weak, nonatomic) IBOutlet UIView *filesInfoBackgrounView;



@end


@implementation SDUserFilesInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}
-(void)updateUI{
   
    self.filesInfoBackgrounView.layer.cornerRadius = 5;
    self.filesInfoBackgrounView.layer.masksToBounds = YES;
    self.filesInfoBackgrounView.layer.borderWidth = 1;
    self.filesInfoBackgrounView.layer.borderColor = [UIColor NaviBackgrounColor].CGColor;
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
