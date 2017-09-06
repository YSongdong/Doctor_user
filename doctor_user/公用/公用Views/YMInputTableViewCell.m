//
//  YMInputTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMInputTableViewCell.h"
@interface YMInputTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;


@end
@implementation YMInputTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)inputEnd:(UITextField *)sender {
    [self endEditing:YES];
    if (self.block) {
        self.block(sender.text);
    }
}
- (void)setDetailWithDic:(NSDictionary *)dic dataDic:(NSDictionary *)dataDic{
    self.nameLabel.text = dic[@"name"];
    self.inputTextField.placeholder = dic[@"placeholder"];
    if ([self.textType isEqualToString:@"1"]) {
        self.inputTextField.text = dataDic[@"leaguer_name"];
    } else if ([self.textType isEqualToString:@"2"]) {
        self.inputTextField.text = dataDic[@"diagnosis_tim"];
    } else if ([self.textType isEqualToString:@"3"]) {
        self.inputTextField.text = dataDic[@"diagnosis_t"];
    } else if ([self.textType isEqualToString:@"4"]) {
        self.inputTextField.text = dataDic[@"diseases_tim"];
    } else if ([self.textType isEqualToString:@"5"]) {
        self.inputTextField.text = dataDic[@"diseases_t"];
    } else if ([self.textType isEqualToString:@"6"]) {
        self.inputTextField.text = dataDic[@"ztime"];
    } else if ([self.textType isEqualToString:@"7"]) {
        self.inputTextField.text = dataDic[@"quality_name"];
    } else if ([self.textType isEqualToString:@"8"]) {
        if ([dataDic[@"member_name"] length] > 0) {
            self.inputTextField.text = dataDic[@"member_name"];
        } else {
            self.inputTextField.text = dataDic[@"demand_name"];
        }
        
    } else if ([self.textType isEqualToString:@"9"]) {
        self.inputTextField.text = dataDic[@"demand_sid"];
    } else if ([self.textType isEqualToString:@"10"]) {
        self.inputTextField.text = dataDic[@"demand_sketch"];
    }
    if (self.canClick) {
        self.inputTextField.userInteractionEnabled = NO;
    } else {
        self.inputTextField.userInteractionEnabled = YES;
    }
    if (self.vcType) {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        imageview.contentMode = UIViewContentModeRight;
        self.inputTextField.rightView = imageview;
        self.inputTextField.rightViewMode = UITextFieldViewModeAlways;
        if ([self.vcType isEqualToString:@"1"]) {
            imageview.image = [UIImage imageNamed:@"下拉箭头_03"];
        } else {
            imageview.image = [UIImage imageNamed:@"右箭头"];
        }
       
    } else {
        self.inputTextField.rightViewMode = UITextFieldViewModeNever;
    }
}
@end
