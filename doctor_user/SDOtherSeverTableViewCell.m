//
//  SDOtherSeverTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDOtherSeverTableViewCell.h"

@interface SDOtherSeverTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *otherSeverImageView; //图片

@property (weak, nonatomic) IBOutlet UILabel *otherSeverTitleLab; //标题
@property (weak, nonatomic) IBOutlet UILabel *otherSeverConcetLab; //介绍

@property (weak, nonatomic) IBOutlet UILabel *otherSeverTimeLab; //时间



@end





@implementation SDOtherSeverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(SDOtherSeverModel *)model{

    _model = model;
   
    //图片
    [self.otherSeverImageView sd_setImageWithURL:[NSURL URLWithString:model.service_url] placeholderImage:[UIImage imageNamed:@"user_otherSeverCell"]];
    
    //标题
    self.otherSeverTitleLab.text = model.service_title;
    
    //内容
    self.otherSeverConcetLab.text = model.service_content;
    
    //时间
    self.otherSeverTimeLab.text =[NSString stringWithFormat:@"%@-%@",model.start_time,model.end_time];
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
