//
//  YMHomeBtnTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHomeBtnTableViewCell.h"
@interface YMHomeBtnTableViewCell()
//鸣医
@property (weak, nonatomic) IBOutlet UIView *mingyiView;
//疑难杂症
@property (weak, nonatomic) IBOutlet UIView *yinanzazhengView;
//医生库
@property (weak, nonatomic) IBOutlet UIView *yishengkuView;
//护士库
@property (weak, nonatomic) IBOutlet UIView *hushikuView;

@end
@implementation YMHomeBtnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnClick:(id)sender {
    if (self.block) {
        self.block(FUWUMINGXING);
    }
}
//鸣医
- (IBAction)mingyiBtnClick:(id)sender {
    if (self.block) {
        self.block(MINGYI);
    }
}
//疑难杂症
- (IBAction)yinanzazhengBtnClick:(id)sender {
    if (self.block) {
        self.block(YINANZAZHENG);
    }
}
//医生库
- (IBAction)yishengkuBtnClick:(id)sender {
    if (self.block) {
        self.block(YISHENGKU);
    }
}
//护士库
- (IBAction)hushikuBtnClick:(id)sender {
    if (self.block) {
        self.block(HUSHIKU);
    }
}

@end
