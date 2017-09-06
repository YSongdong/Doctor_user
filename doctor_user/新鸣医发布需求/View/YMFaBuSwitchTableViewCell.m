//
//  YMFaBuSwitchTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMFaBuSwitchTableViewCell.h"
#import "YMSwitchView.h"

@interface YMFaBuSwitchTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)YMSwitchView *switchtView;

@end

@implementation YMFaBuSwitchTableViewCell

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

    
    _switchtView = [[YMSwitchView alloc]init];
    _switchtView.on = YES;
    [_switchtView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_switchtView];
    [_switchtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(49);
        make.height.mas_equalTo(31);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitleName:(NSString *)titleName{
    _titleLabel.text = titleName;
}

-(void)setOn:(BOOL)On{
    [_switchtView setOn:On];
}


-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if ([self.delegate respondsToSelector:@selector(fabuSwitch:setOn:)]) {
        [self.delegate fabuSwitch:self setOn:isButtonOn];
    }
}

@end
