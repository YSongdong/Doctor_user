//
//  YMOrderDetailsUserInfoTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderDetailsUserInfoTableViewCell.h"

@interface YMOrderDetailsUserInfoTableViewCell()
@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UILabel *titleUserInfoLabel;
@property(nonatomic,strong)UILabel *titleInfoLabel;

@end

@implementation YMOrderDetailsUserInfoTableViewCell

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
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 30;
    _headerImageView.image = [UIImage imageNamed:@"暂无头像_03"];
    [self addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.width.equalTo(@60);
    }];
    _titleUserInfoLabel = [[UILabel alloc]init];
    _titleUserInfoLabel.font = [UIFont systemFontOfSize:15];
    _titleUserInfoLabel.textColor = RGBCOLOR(51, 51, 51);
    _titleUserInfoLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_titleUserInfoLabel];
    [_titleUserInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageView.mas_right).offset(10);
        make.top.equalTo(_headerImageView.mas_top).offset(-5);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    _titleInfoLabel = [[UILabel alloc]init];
    _titleInfoLabel.font = [UIFont systemFontOfSize:13];
    _titleInfoLabel.textColor = RGBCOLOR(130, 130, 130);
    _titleInfoLabel.numberOfLines = 0;
    [self addSubview:_titleInfoLabel];
    [_titleInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleUserInfoLabel);
        make.top.equalTo(_titleUserInfoLabel.mas_bottom).offset(10);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YMDemandDetailModel *)model {
    _model = model;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_model.leaguer_img] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    _titleUserInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@岁",_model.leagure_name,_model.leagure_sex,_model.leagure_age];
    _titleInfoLabel.text = _model.title;
}



@end
