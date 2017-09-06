//
//  SDSomkeReactionTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDSomkeReactionTableViewCell.h"



@interface SDSomkeReactionTableViewCell ()<UITextViewDelegate>


@end

@implementation SDSomkeReactionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}
-(void) initUI{

    self.somkeTextView.scrollEnabled = NO;
    self.somkeTextView.delegate = self;
    
}
#pragma mark  --- UITextViewDelegate---
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == self.somkeTextView) {
        if (range.location == 0){
            self.showPlacLabel.hidden = NO;
            return YES;
        }else{
             self.showPlacLabel.hidden = YES;
        }
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 90) {
            return NO;
        }
    }
    
    //如果用户点击了return
    if([text isEqualToString:@"\n"]){
        
        [self.somkeTextView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

     [self.somkeTextView resignFirstResponder];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
