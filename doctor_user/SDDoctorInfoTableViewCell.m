//
//  SDDoctorInfoTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDDoctorInfoTableViewCell.h"

@interface SDDoctorInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *selectDetailBtn; //查看详情按钮
- (IBAction)selectdDetailBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *goodDescriptionLabel; //个人介绍

@end





@implementation SDDoctorInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    
}

-(void)setClcickEvent:(BOOL)clcickEvent{
    _clcickEvent = clcickEvent;
    
    if (clcickEvent){
        
        _goodDescriptionLabel.numberOfLines = 0;
        [_selectDetailBtn setTitle:@"隐藏详情" forState:UIControlStateNormal];
        [_selectDetailBtn setImage:[UIImage imageNamed:@"imgv_arrow_top_black"] forState:UIControlStateNormal];
    }else{
        
        _goodDescriptionLabel.numberOfLines = 2;
        [_selectDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_selectDetailBtn setImage:[UIImage imageNamed:@"dropdown_icon"] forState:UIControlStateNormal];
    }
}

+(CGFloat)DetailsViewHeight:(NSString *)text detailsClick:(BOOL)detailsClick{
    
    UILabel *detailLabel = [[UILabel alloc]init];
    if (detailsClick) {
        detailLabel.numberOfLines = 0;
        return  [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    }else{
        detailLabel.text = text;
        detailLabel.numberOfLines = 2;
        detailLabel.font = [UIFont systemFontOfSize:13];
        
        if (detailLabel.width>(SCREEN_WIDTH-20)) {
            return  35.f;
        }else{
            return 16;
        }
        
    }
    
    
}
+(CGFloat)memberPersonalInfoHeight:(NSString *)memberPersonalInfo{
    
    UILabel *detailLabel = [[UILabel alloc]init];
    
    detailLabel.numberOfLines = 0;
    
    CGSize titleSize = [memberPersonalInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    detailLabel.size = titleSize;
    
    return titleSize.height;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectdDetailBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(HeaderTableViewCell:sender:)]) {
        [self.delegate HeaderTableViewCell:self sender:sender];
    }
}
@end
