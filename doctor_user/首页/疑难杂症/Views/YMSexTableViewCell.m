//
//  YMSexTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSexTableViewCell.h"
@interface YMSexTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end
@implementation YMSexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)sexChooseBtnClick:(id)sender {
    //选择性别
    if (self.block) {
        self.block(nil,YES);
    }
    
}
- (void)setDetailWithDic:(NSDictionary *)dic {
    if (dic[@"member_sex"]) {
        if ([dic[@"member_sex"] isEqualToString:@"1"] || [dic[@"member_sex"] isEqualToString:@"2"]) {
            [self.sexBtn setTitle:[dic[@"member_sex"] isEqualToString:@"1"]?@"男":@"女" forState:UIControlStateNormal];
        } else {
            [self.sexBtn setTitle:dic[@"member_sex"]  forState:UIControlStateNormal];
        }
        [self.sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    self.ageTextField.text = dic[@"member_age"];
}

- (IBAction)inputEnd:(UITextField *)sender {
    if (self.block) {
        self.block(sender.text,NO);
    }
}

@end
