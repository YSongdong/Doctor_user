//
//  SDYiNanUserInfoTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDYiNanUserInfoTableViewCell.h"

@interface SDYiNanUserInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView; //用户头像

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel; //姓名

@property (weak, nonatomic) IBOutlet UILabel *userSexLabel; //性别

@property (weak, nonatomic) IBOutlet UILabel *userAgeLabel; //年龄




@end



@implementation SDYiNanUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}
-(void) updateUI{
    self.userHeaderImageView.layer.cornerRadius = CGRectGetHeight(self.userHeaderImageView.frame)/2;
    self.userHeaderImageView.layer.masksToBounds = YES;
    self.userHeaderImageView.layer.borderWidth =1;
    self.userHeaderImageView.layer.borderColor = [UIColor lineColor].CGColor;
    
}

-(void)setModel:(SDYiNanDetailModel *)model{

    _model = model;
    
    //头像
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    //名字
    self.userNameLabel.text = model.leagure_name;
    //性别
    self.userSexLabel.text = model.leagure_sex;
    //年龄
    self.userAgeLabel.text = [NSString stringWithFormat:@"%@岁",model.leagure_idcard];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
