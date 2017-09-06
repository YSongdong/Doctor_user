//
//  HelperInfoTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HelperInfoTableViewCell.h"

@interface HelperInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView; //头像

@property (weak, nonatomic) IBOutlet UILabel *nameLabel; //名字

@property (weak, nonatomic) IBOutlet UILabel *sexLabel; //性别

@property (weak, nonatomic) IBOutlet UILabel *ageLabel; //年龄

@property (weak, nonatomic) IBOutlet UILabel *cityLabel; //城市

@property (weak, nonatomic) IBOutlet UILabel *professionLabel;//职业

@property (weak, nonatomic) IBOutlet UILabel *diseaseLabel; //病

@property (weak, nonatomic) IBOutlet UIButton *healtheFilesBtn;//健康档案按钮
- (IBAction)healtheFilesBtnAction:(UIButton *)sender;


@end



@implementation HelperInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    //头像
    self.headerImageView.layer.cornerRadius = CGRectGetHeight(self.headerImageView.frame)/2;
    self.headerImageView.layer.masksToBounds = YES;
    //档案按钮
    self.healtheFilesBtn.layer.cornerRadius = CGRectGetHeight(self.healtheFilesBtn.frame)/2;
    self.healtheFilesBtn.layer.masksToBounds = YES;
    self.healtheFilesBtn.layer.borderWidth = 1;
    self.healtheFilesBtn.layer.borderColor = [UIColor btnBroungColor].CGColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//健康档案按钮
- (IBAction)healtheFilesBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdHealtheFilesBtnAction)]) {
        [self.delegate selectdHealtheFilesBtnAction];
    }
    
}

-(void)setModel:(HeadlthyAllMealthModel *)model{

    _model = model;

    //头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.mealth_img] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    //名字
    self.nameLabel.text = model.mealth_name;
    //性别
    self.sexLabel.text = model.mealth_sex;
    //年龄
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁",model.mealth_age];
    //城市
    self.cityLabel.text = model.mealth_city;
    //职业
    self.professionLabel.text = model.mealth_profession;
    
}





@end
