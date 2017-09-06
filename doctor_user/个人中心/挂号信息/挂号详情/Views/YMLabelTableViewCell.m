//
//  YMLabelTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMLabelTableViewCell.h"

@interface YMLabelTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation YMLabelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDetailWith:(NSString *)str {
    if (str == NULL) {
        return;
    }
    self.myLabel.text = str;
}

@end
