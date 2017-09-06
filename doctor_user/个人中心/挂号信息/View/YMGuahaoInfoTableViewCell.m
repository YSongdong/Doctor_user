//
//  YMGuahaoInfoTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMGuahaoInfoTableViewCell.h"

@interface YMGuahaoInfoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *xueqiuLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitoNameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation YMGuahaoInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailWithDic:(NSDictionary *)dic {
    
    self.xueqiuLabel.text = [NSString stringWithFormat:@"需求标题：%@",dic[@"demand_sketch"]];
    self.hospitoNameLable.text = [NSString stringWithFormat:@"挂号医院：%@",dic[@"occupation"]];
    self.timeLabel.text = [NSString stringWithFormat:@"就诊时间：%@",dic[@"ht_time"]];
    
    if ([self.type isEqualToString:@"1"]) {
        self.statusLabel.text = @"进行中";
    } else {
        self.statusLabel.text = @"已完成";
    }
}

@end
