//
//  YMRankingTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMRankingTableViewCell.h"

@interface YMRankingTableViewCell()

@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UIImageView *rankingImageView;
@property(nonatomic,strong)UILabel *departmentLabel;//科室
@property(nonatomic,strong)UILabel *physicianLabel;//医师
@property(nonatomic,strong)UILabel *hospitalLabel;//医院
@property(nonatomic,strong)UILabel *scoreLabel;//评分
@property(nonatomic,strong)UILabel *volumeLabel;//上周成交量

@property(nonatomic,strong)UILabel *moneyLabel;//总成交量
@end

@implementation YMRankingTableViewCell

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
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 30;
    _headerImageView.image = [UIImage imageNamed:@"暂无头像_03"];
    [self addSubview:_headerImageView];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.height.width.mas_equalTo(60);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.text = @"总评分:4.5";
    _scoreLabel.font = [UIFont systemFontOfSize:13] ;
    _scoreLabel.textColor = [UIColor redColor];
    [self addSubview:_scoreLabel];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo([_scoreLabel intrinsicContentSize].width);
    }];
    
    _hospitalLabel = [[UILabel alloc]init];
    _hospitalLabel.text = @"西南医西南医院西南医院西南医院西南医院院";
    _hospitalLabel.font = [UIFont systemFontOfSize:13];
    _hospitalLabel.textColor = RGBCOLOR(51, 51, 51);
    [self addSubview:_hospitalLabel];
    [_hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageView.mas_right).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(_scoreLabel.mas_left).offset(-5);
    }];
    
    _physicianLabel = [[UILabel alloc]init];
    _physicianLabel.text = @"主治医师";
    _physicianLabel.font = _hospitalLabel.font;
    _physicianLabel.textColor = _hospitalLabel.textColor;
    [self addSubview:_physicianLabel];
    [_physicianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_scoreLabel.mas_top).offset(-5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo([_physicianLabel intrinsicContentSize].width);
    }];
    
    
    _departmentLabel = [[UILabel alloc]init];
    _departmentLabel.text = @"外科";
    _departmentLabel.font = _hospitalLabel.font;
    _departmentLabel.textColor = _hospitalLabel.textColor;
    [self addSubview:_departmentLabel];
    [_departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_physicianLabel.mas_bottom);
        make.right.equalTo(_physicianLabel.mas_left).offset(-5);
        make.width.mas_equalTo([_departmentLabel intrinsicContentSize].width);
    }];
    
    
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.text = @"王铭心";
    _userNameLabel.font = [UIFont systemFontOfSize:13];
    _userNameLabel.textColor = RGBCOLOR(134, 191, 251);
    [self addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_physicianLabel.mas_bottom);
        make.left.equalTo(_hospitalLabel.mas_left);
        make.width.mas_equalTo([_userNameLabel intrinsicContentSize].width);
    }];
    
    _rankingImageView = [[UIImageView alloc]init];
    [self addSubview:_rankingImageView];
    [_rankingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLabel.mas_right).offset(5);
        make.bottom.equalTo(_userNameLabel.mas_bottom).offset(-3);
        make.width.mas_equalTo(31);
        make.height.mas_equalTo(11);
    }];
    
    _volumeLabel = [[UILabel alloc]init];
    _volumeLabel.text = @"上周成交量：1312笔";
    _volumeLabel.font = [UIFont systemFontOfSize:11];
    _volumeLabel.textColor = RGBCOLOR(180, 180, 180);
    [self addSubview:_volumeLabel];
    [_volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hospitalLabel.mas_bottom).offset(5);
        make.left.equalTo(_hospitalLabel.mas_left);
        make.width.mas_equalTo([_volumeLabel intrinsicContentSize].width);
    }];
    
    _moneyLabel = [[UILabel alloc]init];
    _moneyLabel.text = @"上周成交量：1312笔";
    _moneyLabel.font = _volumeLabel.font;
    _moneyLabel.textColor = _volumeLabel.textColor;
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_volumeLabel.mas_top);
        make.right.equalTo(_scoreLabel.mas_right);
        make.width.mas_equalTo([_moneyLabel intrinsicContentSize].width);
    }];
}


-(void)setModel:(YMDoctorRankingModel *)model{
    _model = model;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.store_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    _userNameLabel.text = model.member_names;
    _rankingImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"no.%@",model.no]];
    _physicianLabel.text = model.member_aptitude;//医师
    
    _departmentLabel.text = model.member_ks;//科室
   
    _hospitalLabel.text = model.member_occupation;//医院
    _scoreLabel.text = [NSString stringWithFormat:@"总评分: %@",model.avg_score];//评分
   
    _volumeLabel.text = [NSString stringWithFormat:@"上周成交量: %@",model.week_store_sales];//成交量
    
    _moneyLabel.text = [NSString stringWithFormat:@"历史成交量: %@",model.store_sales];//成交量
    
    [_physicianLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_physicianLabel intrinsicContentSize].width +5);
    }];
    
    [_departmentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_departmentLabel intrinsicContentSize].width);
    }];
    
    [_scoreLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_scoreLabel intrinsicContentSize].width);
    }];
    [_moneyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_moneyLabel intrinsicContentSize].width);
    }];
}

@end
