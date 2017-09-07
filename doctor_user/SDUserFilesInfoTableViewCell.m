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

-(void)setModel:(SDFilesMessageModel *)model{

    _model = model;
    //姓名
    self.userNameLab.text = model.member_name;
    //生日
    self.userBirthdayLab.text = model.birthday;
    //血型
    self.userBloodTypeLab.text = model.blood;
    //家庭地址
    self.userAddressLab.text = model.address;
    //疾病史
    self.userDiseaseHistorLab.text = model.diseases;
    //过敏史
    self.userAnapHistoryLab.text = model.allergic;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
