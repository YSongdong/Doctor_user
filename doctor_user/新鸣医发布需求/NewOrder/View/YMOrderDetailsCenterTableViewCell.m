//
//  YMOrderDetailsCenterTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderDetailsCenterTableViewCell.h"

@interface YMOrderDetailsCenterTableViewCell()

@property(nonatomic,strong)UILabel *titlLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;


@end

@implementation YMOrderDetailsCenterTableViewCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initView{
    _titlLabel = [[UILabel alloc]init];
    _titlLabel.font = [UIFont systemFontOfSize:17];
    _titlLabel.textColor = RGBCOLOR(51, 51, 51);
    [self addSubview:_titlLabel];
    [_titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.equalTo(self);
    }];
    _subTitleLabel = [[UILabel alloc]init];
    _subTitleLabel.font = [UIFont systemFontOfSize:15];
    _subTitleLabel.textColor = RGBCOLOR(80, 80, 80);
    [self addSubview:_subTitleLabel];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titlLabel.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
    }];
}

-(void)setDemand_type:(NSString *)demand_type
{

    _demand_type = demand_type;
}

-(void)setTitleName:(NSString *)titleName{
    _titlLabel.text = titleName;
}

-(void)setSubTitleName:(NSString *)subTitleName{
    _subTitleLabel.text = subTitleName;
}

@end
