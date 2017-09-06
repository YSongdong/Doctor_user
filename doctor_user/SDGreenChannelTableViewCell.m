//
//  SDGreenChannelTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDGreenChannelTableViewCell.h"

@interface SDGreenChannelTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel; //时间lab

@property (weak, nonatomic) IBOutlet UIView *greenChannelBackgrouView;


@end




@implementation SDGreenChannelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}
-(void)updateUI{
    
    self.greenChannelBackgrouView.layer.cornerRadius = 5;
    self.greenChannelBackgrouView.layer.masksToBounds = YES;
    self.greenChannelBackgrouView.layer.borderWidth = 1;
    self.greenChannelBackgrouView.layer.borderColor = [UIColor lineColor].CGColor;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
