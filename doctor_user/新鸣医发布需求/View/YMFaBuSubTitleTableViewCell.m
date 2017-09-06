//
//  YMFaBuSubTitleTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMFaBuSubTitleTableViewCell.h"

@interface YMFaBuSubTitleTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;
@property(nonatomic,strong)UIImageView *rowImageView;


@end

@implementation YMFaBuSubTitleTableViewCell

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
}

-(void)initView{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = RGBCOLOR(80, 80, 80);
    _titleLabel.text = @"真实姓名";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(_titleLabel.intrinsicContentSize.width+10);
    }];
    
    _rowImageView = [[UIImageView alloc]init];
    _rowImageView.image = [UIImage imageNamed:@"self_right_icon"];
    _rowImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_rowImageView];
    [_rowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(9);
    }];
    _subTitleLabel = [[UILabel alloc]init];
    _subTitleLabel.backgroundColor = [UIColor clearColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:13];
    _subTitleLabel.textColor = RGBCOLOR(80, 80, 80);
    _subTitleLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_subTitleLabel];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right);
        make.right.equalTo(_rowImageView.mas_left).offset(-10);
        make.top.bottom.equalTo(self);
    }];
}

-(void)setType:(arrowType)type{
    _type = type;
    if (type == bottomArrowType) {
        _rowImageView.image = [UIImage imageNamed:@"dropdown_icon"];
        [_rowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.width.mas_equalTo(22);
        }];
    }
}

-(void)setTitleName:(NSString *)titleName{
    _titleLabel.text = titleName;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_titleLabel.intrinsicContentSize.width+10);
    }];
}
-(void)setSubTitleName:(NSString *)subTitleName{
    _subTitleLabel.text = subTitleName;
}

-(void)setHiddenArrow:(BOOL)hiddenArrow{
    _hiddenArrow = hiddenArrow;
    if (_hiddenArrow) {
        _rowImageView.hidden = YES;
        [_rowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
        [_subTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
        }];
    }else{
        _rowImageView.hidden = NO;
        [_rowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (_type == bottomArrowType) {
                make.width.equalTo(@22);
            }else{
                make.width.equalTo(@9);
            }
        }];
        [_subTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rowImageView.mas_left).offset(-10);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
