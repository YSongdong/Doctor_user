//
//  YMFirstSingleTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMFirstSingleTableViewCell.h"

@interface YMFirstSingleTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIImageView *rightArrowImageView;

@property(nonatomic,strong)UILabel *subTitlel;

@end

@implementation YMFirstSingleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
    // Initialization code
}

-(void)initView{
    _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"真实姓名:";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.equalTo(self);
    }];
    
    _rightArrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"self_right_icon"]];
    [self addSubview:_rightArrowImageView];
    [_rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_offset(17);
    }];
    
    _subTitlel = [[UILabel alloc]init];
    _subTitlel.textColor = RGBCOLOR(180, 180, 180);
    _subTitlel.textAlignment = NSTextAlignmentRight;
    _subTitlel.font = [UIFont systemFontOfSize:13];
    _subTitlel.text = @"请选择";
    [self addSubview:_subTitlel];
    [_subTitlel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightArrowImageView.mas_left).offset(-5);
        make.top.bottom.equalTo(self);
        make.left.equalTo(_titleLabel.mas_right).offset(5);
    }];
}

-(void)setHiddenArrow:(BOOL)hiddenArrow{
    _rightArrowImageView.hidden  = _hiddenArrow;
    [_rightArrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.with.equalTo(@0);
    }];
}

-(void)setTitltStr:(NSString *)titltStr{
    _titleLabel.text = titltStr;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_titleLabel.intrinsicContentSize.width);
    }];
}

-(void)setSubTitleStr:(NSString *)subTitleStr{
    _subTitlel.text = subTitleStr;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
