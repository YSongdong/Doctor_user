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
@property (weak, nonatomic) IBOutlet UILabel *showLab;


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
-(void)setdictManageType:(NSString *)type andIndexPath:(NSIndexPath *)indexPath andWithDict:(NSDictionary *)dict{
    
    if ([type isEqualToString:@"4"] ||[type isEqualToString:@"8"] ) {
        //绿色住院通道
        NSString *numberStr = [NSString stringWithFormat:@"第%ld次使用时间:",(long)indexPath.row+1];
        self.showLab.text = numberStr;
        self.timeLabel.text =[NSString stringWithFormat:@"%@",[dict objectForKey:@"report_time"]];
        
    }
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
