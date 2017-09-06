//
//  DemandOrderTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandOrderTableViewCell.h"
@interface DemandOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *demandOrderSn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLabel; //招标人数
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DemandOrderTableViewCell


- (void)drawRect:(CGRect)rect {
    
    _type.layer.cornerRadius = 5 ;
    _type.layer.masksToBounds = YES ;
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor orangesColor].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:_type.bounds].CGPath;
    border.frame = _type.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [_type.layer addSublayer:border];
}

- (void)setModel:(NSDictionary *)model {
    //model[@"demand_hire"] == 1 雇佣
    _model = model ;
    if ([model[@"demand_hire"] integerValue] == 1) {
        self.type.hidden = NO;
        self.personLabel.hidden = YES ;
    }else {
        self.type.hidden = YES ;
        self.personLabel.hidden = NO ;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model[@"demand_sketch"]];
    self.demandOrderSn.text = [NSString stringWithFormat:@"订单号: %@",model[@"demand_bh"]];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model[@"demand_needs"]];    
    self.priceLabel.text = [NSString stringWithFormat:@"¥  %@",model[@"price"]];
    self.timeLabel.text = [NSString stringWithFormat:@"需求时间: %@-%@",model[@"ktimes"],model[@"jtimes"]];
    self.progressLabel.text =  [NSString stringWithFormat:@"订单进度: %@",model[@"demand_type"]];
    self.personLabel.text = [NSString stringWithFormat:@"招标 %@/%@",model[@"demand_amount"],model[@"total"]];
    }

@end
