//
//  YMOrderProgressCell.m
//  doctor_user
//
//  Created by kupurui on 2017/2/10.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderProgressCell.h"
#import "ProgressView.h"

@interface YMOrderProgressCell ()
@property (weak, nonatomic) IBOutlet ProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;//当前共有多少人
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;//等待选标
@end

@implementation YMOrderProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)drawRect:(CGRect)rect {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDic:(NSDictionary *)dic {

    _dic = dic ;
    NSInteger schedual = [dic[@"demand_schedule"] integerValue];
    [self.progressView setAccount:5.0];
    [self.progressView setProgress:schedual];
    [self.progressView addViews];
    self.statusLabel.text = dic[@"demand_type"];
    if ([dic[@"demand_hire"] integerValue] == 1) {
        self.totalLabel.text = @"";
    }
    else{
        self.totalLabel.text = [NSString stringWithFormat:@"共有%@位医生投标。",dic[@"demand_amount"]];
    }
}
@end
