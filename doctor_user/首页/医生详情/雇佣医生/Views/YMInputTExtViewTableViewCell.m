//
//  YMInputTExtViewTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMInputTExtViewTableViewCell.h"

@interface YMInputTExtViewTableViewCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet KRMyTextView *myTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHight;

@end
@implementation YMInputTExtViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textViewHight.constant = 105;
    self.myTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self endEditing:YES];
    if (self.block) {
        self.block(textView.text);
    }
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [self endEditing:YES];
    if (self.block) {
        self.block(textView.text);
    }
    return YES;
}
- (void)setUpWithDic:(NSDictionary *)dic {
    self.myTextView.myPlaceholder = @"请在此描述你的状况，活动方会根据你提供的资料进行审核（必填）";
    self.myTextView.text = dic[@"diseases_content"];
}
@end
