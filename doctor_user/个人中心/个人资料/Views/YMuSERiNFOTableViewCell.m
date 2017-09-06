//
//  YMuSERiNFOTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMuSERiNFOTableViewCell.h"
@interface YMuSERiNFOTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
@implementation YMuSERiNFOTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDetailWithIndexpath:(NSIndexPath *)indexPath andDic:(NSDictionary *)dic{
    if ([self.vcType isEqualToString:@"1"]) {
        if (self.canEdit) {
            self.inputTextField.userInteractionEnabled = YES;
        } else {
            self.inputTextField.userInteractionEnabled = NO;
        }
        self.indexPath = indexPath;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                self.nameLabel.text = @"昵称：";
                self.inputTextField.placeholder = @"输入昵称";
                self.inputTextField.text = dic[@"member_names"];
            } else {
                self.inputTextField.userInteractionEnabled = NO;
                self.nameLabel.text = @"性别：";
                self.inputTextField.placeholder = @"选择性别";
                self.inputTextField.text = [dic[@"member_sex"] isEqualToString:@"1"] ? @"男" : @"女";
            }
        } else {
            if (indexPath.row == 0) {
                self.nameLabel.text = @"城市：";
                self.inputTextField.placeholder = @"输入地址";
                self.inputTextField.text = dic[@"member_areainfo"];
            } else {
                self.nameLabel.text = @"职业：";
                self.inputTextField.placeholder = @"输入职业";
                self.inputTextField.text = dic[@"member_occupation"];
            }
        }
    } else {
        if (self.canEdit) {
            self.inputTextField.userInteractionEnabled = YES;
        } else {
            self.inputTextField.userInteractionEnabled = NO;
        }
        self.indexPath = indexPath;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                self.nameLabel.text = @"真实姓名：";
                self.inputTextField.placeholder = @"必填";
                self.inputTextField.text = dic[@"member_truename"];
            } else {
                self.nameLabel.text = @"身份证号：";
                self.inputTextField.placeholder = @"必填";
                if (![dic[@"member_number"] isKindOfClass:[NSNull class]]) {
                    self.inputTextField.text = dic[@"member_number"] ;
                }
                
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                self.nameLabel.text = @"联系电话：";
                self.inputTextField.placeholder = @"选填";
                if (![dic[@"member_phone"] isKindOfClass:[NSNull class]]) {
                    self.inputTextField.text = dic[@"member_phone"] ;
                }
                //self.inputTextField.text = dic[@"member_phone"];
            } else {
                self.nameLabel.text = @"电子邮箱：";
                self.inputTextField.placeholder = @"选填";
                if (![dic[@"member_email"] isKindOfClass:[NSNull class]]) {
                    self.inputTextField.text = dic[@"member_email"] ;
                }
                //self.inputTextField.text = dic[@"member_email"];
            }
        } else {
            self.nameLabel.text = @"详细地址：";
            self.inputTextField.placeholder = @"选填";
            if (![dic[@"member_address"] isKindOfClass:[NSNull class]]) {
                self.inputTextField.text = dic[@"member_address"] ;
            }
            //self.inputTextField.text = dic[@"member_address"];
        }
    }
   
}
- (IBAction)inputchage:(id)sender {
    if (self.block) {
        self.block(self.indexPath,self.inputTextField.text);
    }
}
- (IBAction)editEnd:(id)sender {
    [self endEditing:YES];
    if (self.block) {
        self.block(self.indexPath,self.inputTextField.text);
    }
}
@end
