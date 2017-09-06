//
//  BillTableCell.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BillTableCell.h"

@interface BillTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *diseaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation BillTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setModel:(NSDictionary *)model {
    
        _timeLabel.text = [NSString stringWithFormat:@"%@",[model objectForKey:@"finnshed_time"]];
        _nameLabel.text  = [NSString stringWithFormat:@"%@",[model objectForKey:@"member_names"]];
        _diseaseLabel.text = [NSString stringWithFormat:@"%@",[model objectForKey:@"demand_sketch"]];
        _moneyLabel.text = [NSString stringWithFormat:@"+ %@",[model objectForKey:@"order_amount"]];

}
- (void)setHeadSectionDic:(NSDictionary *)dic {
    
    
    _titleLabel.text = dic[@"finnshed_time"];
    _detailLabel.text =[NSString stringWithFormat:@"消费: %@元", dic[@"order_amoun"]];
    
}

@end
