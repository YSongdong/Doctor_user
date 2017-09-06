//
//  YMDoctorAskedHeTongTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorAskedHeTongTableViewCell.h"

@interface YMDoctorAskedHeTongTableViewCell()

@property(nonatomic,strong)UILabel *tipsAskedLabel;

@end

@implementation YMDoctorAskedHeTongTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initView];
}

-(void)initView{
    _tipsAskedLabel = [[UILabel alloc]init];
    _tipsAskedLabel.font = [UIFont systemFontOfSize:15];
    _tipsAskedLabel.textColor = RGBCOLOR(130, 130, 130);
    _tipsAskedLabel.numberOfLines = 0;
    [self addSubview:_tipsAskedLabel];
    [_tipsAskedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOther_tips:(NSString *)other_tips{
    _tipsAskedLabel.text = other_tips;
}

+(CGFloat)heightForOtherTips:(NSString *)OtherTips {
    UILabel *detailLabel = [[UILabel alloc]init];
    
    detailLabel.numberOfLines = 0;
    return  [OtherTips boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height +30;
}

@end
