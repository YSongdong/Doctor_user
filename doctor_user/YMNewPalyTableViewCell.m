//
//  YMNewPalyTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMNewPalyTableViewCell.h"

@interface YMNewPalyTableViewCell()

@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *rightImageView;

@end

@implementation YMNewPalyTableViewCell

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
    
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.backgroundColor = [UIColor clearColor];
    _headerImageView.image = [UIImage imageNamed:@"play_Alipay_icon"];
    [self addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_offset(45);
    }];
    
    _rightImageView = [[UIImageView alloc]init];
    _rightImageView.image = [UIImage imageNamed:@"play_no_select_icon"];
    _rightImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(_headerImageView.mas_centerY);
        make.height.width.equalTo(@15);
        
    }];
    
    _titleLabel =[[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = RGBCOLOR(51, 51, 51);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageView.mas_right).offset(10);
        make.top.bottom.equalTo(self);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter

-(void)setDataDic:(NSDictionary *)dataDic{
    _headerImageView.image = [UIImage imageNamed:dataDic[@"headerImageName"]];
    _titleLabel.text = dataDic[@"titleName"];
}

-(void)setSelect:(BOOL)select{
    NSString *imageName = @"";
    if (select) {
        imageName = @"play_select_icon";
    }else{
        imageName = @"play_no_select_icon";
    }
    _rightImageView.image = [UIImage imageNamed:imageName];
}

@end
