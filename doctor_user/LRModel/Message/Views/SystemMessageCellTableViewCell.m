//
//  SystemMessageCellTableViewCell.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SystemMessageCellTableViewCell.h"
#import "NSString+Extention.h"
@implementation SystemMessageCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.layer.cornerRadius = 5 ;
    self.timeLabel.layer.masksToBounds = YES ;
    self.backView.layer.cornerRadius = 5 ;
    self.backView.layer.masksToBounds = YES ;
    self.contentView.backgroundColor = [UIColor clearColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}
- (void)setModel:(NSDictionary *)model {
     //CGSize timeSize = [model[@"message_time"] sizeWithBoundingSize:CGSizeMake(WIDTH  - 20, 0) font:[UIFont systemFontOfSize:13]];
    //self.timeLabel.width = timeSize.width + 10 ;
    //[self layoutIfNeeded];
    self.timeLabel.text = [NSString stringWithFormat:@"  %@   ",[self timeWithTimeIntervalString:model[@"message_time"] ]];
    if (![model[@"message_title"] isKindOfClass:[NSNull class]]) {
        self.titleLabel.text = model[@"message_title"] ;
    }
    
    self.contentLabel.text =  model[@"message_body"] ;
}
+ (CGFloat)calcuteHeihtWithWIthModel:(NSDictionary *)model {
    
    CGSize timeSize = [model[@"message_time"] sizeWithBoundingSize:CGSizeMake(WIDTH  - 20, 0) font:[UIFont systemFontOfSize:13]];
    CGSize contentSize = [model[@"message_body"] sizeWithBoundingSize:CGSizeMake(WIDTH - 130, 0) font:[UIFont systemFontOfSize:15]];
    CGFloat height = contentSize.height ;
    if (height < 60) {
        height  = 60 ;
    }
    return 50 + height + timeSize.height + 20 + 10;
}
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
@end
