//
//  SDSymptomDescTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDSymptomDescTableViewCell.h"

@interface SDSymptomDescTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *symptomLab;


@end


@implementation SDSymptomDescTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setSyptomStr:(NSString *)syptomStr{

    _syptomStr = syptomStr;
    self.symptomLab.text = syptomStr;

}
+(CGFloat)cellSymptomHeight:(NSString *)symptomStr{
    
    UILabel *detailLabel = [[UILabel alloc]init];
    
    detailLabel.numberOfLines = 0;
    
    CGSize titleSize = [symptomStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 78, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    detailLabel.size = titleSize;
    
    return titleSize.height+20;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
