//
//  SDDoctorYuYueTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDDoctorYuYueTableViewCell.h"

@interface SDDoctorYuYueTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectTimeBtn;

- (IBAction)selectTimeBtnAction:(UIButton *)sender;


@end


@implementation SDDoctorYuYueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}
-(void)updateUI{
    
    self.selectTimeBtn.layer.cornerRadius = 5;
    self.selectTimeBtn.layer.masksToBounds = YES;
    self.selectTimeBtn.layer.borderWidth = 1;
    self.selectTimeBtn.layer.borderColor = [UIColor lineColor].CGColor;
    
}
-(void)setSelectTime:(NSString *)selectTime{

    _selectTime = selectTime;
    self.timeLabel.text = selectTime;

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectTimeBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdTimeBtnAction:)]) {
        [self.delegate selectdTimeBtnAction:sender];
    }
    
    
}
@end
