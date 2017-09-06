//
//  YMSwitchTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSwitchTableViewCell.h"

@interface YMSwitchTableViewCell()<UITextFieldDelegate>
//左边上面的字
@property (weak, nonatomic) IBOutlet UILabel *leftTopLabel;
//左边下面的字
@property (weak, nonatomic) IBOutlet UILabel *leftBottomLabel;
//开关
@property (weak, nonatomic) IBOutlet UIView *rightView;


@end
@implementation YMSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDetailWithDic:(NSDictionary *)dic andDataDic:(NSDictionary *)dataDic{
    for (UIView *sub in self.rightView.subviews) {
        [sub removeFromSuperview];
    }
    self.leftTopLabel.text = dic[@"lefttop"];
    self.leftBottomLabel.text = dic[@"leftbottom"];
    if ([dic[@"status"] isEqualToString:@"1"]) {
        //1.酬金  2.平台挂号费
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:17];
        label.text = @"¥";
        [self.rightView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightView.mas_right).with.offset(-15);
            make.centerY.equalTo(self.rightView.mas_centerY);
        }];
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"（必填）";
        textField.text = dataDic[@"price"];
        textField.textAlignment = NSTextAlignmentRight;
        textField.font = [UIFont systemFontOfSize:18];
        textField.textColor = [UIColor redColor];
        textField.returnKeyType = UIReturnKeyDone;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [self.rightView addSubview:textField];
        textField.delegate = self;
        textField.borderStyle = UITextBorderStyleNone;
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(label.mas_left).with.offset(-10);
            make.centerY.equalTo(self.rightView.mas_centerY);
            make.height.equalTo(@30);
            make.left.equalTo(self.rightView.mas_left);
        }];
    } else {
        UISwitch *switchs = [[UISwitch alloc]init];
        [switchs setOnTintColor:[UIColor colorWithRed:54.0/255 green:127.0/255 blue:223.0/255 alpha:1]];
        [switchs addTarget:self action:@selector(switchChage:) forControlEvents:UIControlEventValueChanged];
        [self.rightView addSubview:switchs];
        [switchs setOn:[dataDic[@"register"] integerValue]];
        [switchs mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightView.mas_right).with.offset(-15);
            make.centerY.equalTo(self.rightView.mas_centerY);
        }];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self endEditing:YES];
    if (self.block) {
        self.block(NO,textField.text);
    }
    return YES;
}
- (void)switchChage:(UISwitch *)sender {
    if (self.block) {
        NSInteger i = 0;
        if (sender.on) {
            i = 10;
        }
        self.block(YES,[NSString stringWithFormat:@"%ld",i]);
    }
}
@end
