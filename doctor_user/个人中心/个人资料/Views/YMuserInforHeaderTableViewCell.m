//
//  YMuserInforHeaderTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMuserInforHeaderTableViewCell.h"

@interface YMuserInforHeaderTableViewCell()

@property(nonatomic,strong)UIImageView *headerImgeView;

@end

@implementation YMuserInforHeaderTableViewCell

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initView{
    UILabel *headerlabel = [[UILabel alloc]init];
    headerlabel.text = @"头       像:";
    headerlabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:headerlabel];
    [headerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo([headerlabel intrinsicContentSize].width+10);
    }];
    
    UIImageView *rightArrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"self_right_icon"]];
    [self addSubview:rightArrowImage];
    [rightArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(17);
    }];
    
    _headerImgeView = [[UIImageView alloc]init];
    _headerImgeView.image = [UIImage imageNamed:@"暂无头像_03"];
    _headerImgeView.layer.masksToBounds = YES;
    _headerImgeView.layer.cornerRadius = 30;
    [self addSubview:_headerImgeView];
    [_headerImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightArrowImage.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(60);
    }];
}

-(void)setHeaderImagUrl:(NSString *)headerImagUrl{
    [_headerImgeView sd_setImageWithURL:[NSURL URLWithString:headerImagUrl] placeholderImage:_headerImag?: [UIImage imageNamed:@"暂无头像_03"]];
}

-(void)setHeaderImag:(UIImage *)headerImag{
    _headerImag = headerImag;
    _headerImgeView.image = headerImag;
    
}

@end
