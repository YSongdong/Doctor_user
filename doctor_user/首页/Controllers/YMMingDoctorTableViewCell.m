//
//  YMMingDoctorTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMingDoctorTableViewCell.h"

@interface YMMingDoctorTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subTitleLabel;

@property(nonatomic,strong)UIImageView *subImageView;

@property(nonatomic,strong)UIView *topLineView;

@property(nonatomic,strong)UIView *bottomLineView;

@end

@implementation YMMingDoctorTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initView{
    
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [self addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    _bottomLineView = [[UIView alloc]init];
    _bottomLineView.backgroundColor = RGBCOLOR(229, 229, 229);
    _bottomLineView.hidden = YES;
    [self addSubview:_bottomLineView];
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *clickButton = [[UIButton alloc]init];
    clickButton.backgroundColor = [UIColor clearColor];
    [clickButton addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickButton];
    [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLineView.mas_bottom);
        make.bottom.equalTo(_bottomLineView.mas_top);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(60);
    }];
    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(_topLineView.mas_bottom);
        make.bottom.equalTo(_bottomLineView.mas_top);
        
    }];
    
    _subImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dropdown_icon"]];
    [self addSubview:_subImageView];
    [_subImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.height.mas_equalTo(22);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _subTitleLabel = [[UILabel alloc]init];
    _subTitleLabel.font = _titleLabel.font;
    _subTitleLabel.textColor = RGBCOLOR(180, 180, 180);
    _subTitleLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_subTitleLabel];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(10);
        make.right.equalTo(_subImageView.mas_left).offset(-10);
        make.top.equalTo(_topLineView.mas_bottom);
        make.bottom.equalTo(_bottomLineView.mas_top);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark  - setter

-(void)setTitleName:(NSString *)titleName{
    _titleLabel.text = titleName;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_titleLabel intrinsicContentSize].width);
    }];
}

-(void)setSubTitleName:(NSString *)subTitleName{
    _subTitleLabel.text = subTitleName;
}
-(void)setShowImage:(BOOL)showImage{
    _subImageView.hidden = showImage;
}

-(void)setLineInterval:(BOOL)lineInterval{
    if (lineInterval) {
        [_topLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
        }];
    }
}

-(void)setLastOne:(BOOL)lastOne{
    _bottomLineView.hidden = NO;
}

#pragma mark buttonCLick

-(void)subButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(MingDoctorTableViewCell:rightSubClick:)]) {
        [self.delegate MingDoctorTableViewCell:self rightSubClick:sender];
    }
}

@end
