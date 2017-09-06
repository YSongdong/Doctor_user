//
//  YMHomeDoctorTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHomeDoctorTableViewCell.h"
#import "LRMacroDefinitionHeader.h"
@interface YMHomeDoctorTableViewCell()
//名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
//医生详情 地址
@property (weak, nonatomic) IBOutlet UILabel *doctorDetailLable;
//医生介绍
@property (weak, nonatomic) IBOutlet UILabel *doctorIntroduceLabel;


@end
@implementation YMHomeDoctorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    LRViewBorderRadius(self.headImageView, 32.5, 0, [UIColor clearColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDetailWithDic:(NSDictionary *)dic {
    NSLog(@"%@",dic);
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"store_avatar"]] placeholderImage:[UIImage imageNamed:@"医盟用户版首页_17-8"]];
    self.nameLabel.text = dic[@"member_names"];
    self.doctorDetailLable.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"member_bm"],dic[@"member_ks"],dic[@"member_occupation"]];
    //self.doctorIntroduceLabel.text = dic[@"member_service"];
    NSString * cLabelString = dic[@"member_service"];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cLabelString];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cLabelString length])];
    [self.doctorIntroduceLabel setAttributedText:attributedString1];
}
@end
