//
//  YMExplainAndTipTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMExplainAndTipTableViewCell.h"

@interface YMExplainAndTipTableViewCell()

@property(nonatomic,strong)UILabel *titleNameLabel;
@property(nonatomic,strong)UILabel *explainLabel;
@property(nonatomic,strong)UILabel *tipLabel;


@end

@implementation YMExplainAndTipTableViewCell

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
    _titleNameLabel = [[UILabel alloc]init];
    _titleNameLabel.text = @"服务确认合同";
    _titleNameLabel.font = [UIFont systemFontOfSize:15];
    _titleNameLabel.textColor = [UIColor blackColor];
    _titleNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleNameLabel];
    [_titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
    }];
    
    _explainLabel = [[UILabel alloc]init];
    _explainLabel.text = @"合同说明:";
    _explainLabel.numberOfLines = 0;
    _explainLabel.font = [UIFont systemFontOfSize:13];
    _explainLabel.textColor = RGBCOLOR(130, 130, 130);
    [self addSubview:_explainLabel];
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleNameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.text = @"温馨提示:";
    _tipLabel.numberOfLines = 0;
    _tipLabel.font = [UIFont systemFontOfSize:13];
    _tipLabel.textColor = RGBCOLOR(130, 130, 130);
    [self addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_explainLabel.mas_bottom).offset(10);
        make.left.right.equalTo(_explainLabel);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YMUserContractPageModel *)model{
    NSString *explainStr = [NSString stringWithFormat:@"合同说明:%@",model.explain];
    NSString *tipStr = [NSString stringWithFormat:@"温馨提示:%@",model.tips];
    _explainLabel.text =explainStr;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tipStr];
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor blackColor]
                range:NSMakeRange(0,5)];
    _tipLabel.attributedText = str;
}

+(CGFloat)heightForExplain:(NSString *)explain forTips:(NSString *)tips{
    UILabel *detailLabel = [[UILabel alloc]init];
    
    detailLabel.numberOfLines = 0;
   CGFloat explainHeight = [explain boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    CGFloat tipsHeight = [explain boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    
    return explainHeight + tipsHeight + 100;
}

@end
