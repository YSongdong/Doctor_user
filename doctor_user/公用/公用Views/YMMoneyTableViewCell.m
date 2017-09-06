//
//  YMMoneyTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMoneyTableViewCell.h"
@interface YMMoneyTableViewCell()
//开始时间
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *endLeft;

//介绍时间
@property (weak, nonatomic) IBOutlet UIButton *endBtn;

@end
@implementation YMMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//开始按钮点击
- (IBAction)beginBtnClick:(UIButton *)sender {
    self.block(1);
}
//结束按钮点击
- (IBAction)endBtnClick:(UIButton *)sender {
    self.block(2);
}
- (void)setTimeWithDic:(NSDictionary *)dic {
    if (self.vcType) {
        [self.beginBtn setTitle:dic[@"ktime"] forState:UIControlStateNormal];
        [self.endBtn setTitle:dic[@"jtime"] forState:UIControlStateNormal];
        self.beginBtn.hidden = YES;
        self.lineBtn.hidden = YES;
        CGFloat f = CGRectGetMaxX(_lineBtn.frame);
        CGFloat wight = self.endBtn.width;
        
        self.endLeft.constant = [UIScreen mainScreen].bounds.size.width - f - wight - 10;
        
    } else {
        [self.beginBtn setTitle:dic[@"ktime"] forState:UIControlStateNormal];
        [self.endBtn setTitle:dic[@"jtime"] forState:UIControlStateNormal];
        self.beginBtn.hidden = NO;
        self.lineBtn.hidden = NO;
        self.endLeft.constant = 0;
    }
    //[self.beginBtn setTitle:dic[@"ktime"] forState:UIControlStateNormal];
    //[self.endBtn setTitle:dic[@"jtime"] forState:UIControlStateNormal];
}
@end
