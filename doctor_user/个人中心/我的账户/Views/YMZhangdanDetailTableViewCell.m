//
//  YMZhangdanDetailTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMZhangdanDetailTableViewCell.h"
@interface YMZhangdanDetailTableViewCell()
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//医生名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//钱数
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;


@end
@implementation YMZhangdanDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDetailWithDic:(NSDictionary *)dic {
    //设置数据
    self.timeLabel.text = dic[@"finnshed_time"];
    self.nameLabel.text = dic[@"member_names"];
    self.moneyLable.text = dic[@"order_amount"];
}
@end
