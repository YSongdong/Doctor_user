//
//  YMRegisteredViewTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMRegisteredViewTableViewCell.h"
#import "YMSwitchView.h"

@interface YMRegisteredViewTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *daiguahaoFeiyong;


@property (weak, nonatomic) IBOutlet UILabel *platformLabel;


@property (weak, nonatomic) IBOutlet UILabel *additionalInformationLabel;

@property(nonatomic,strong)YMSwitchView *switchtView;

@property(nonatomic,strong)UIView *topLineView;

@property(nonatomic,strong)UIView *bottomLineView;

@end

@implementation YMRegisteredViewTableViewCell

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
    [self initView];
}

-(void)initView{
    
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    _switchtView = [[YMSwitchView alloc]init];
    [_switchtView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    _switchtView.on = NO;
    [_view addSubview:_switchtView];
    [_switchtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view.mas_right).offset(-10);
        make.centerY.equalTo(_view.mas_centerY);
        make.width.mas_equalTo(49);
        make.height.mas_equalTo(31);
    }];
    
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [self addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    _bottomLineView = [[UIView alloc]init];
    _bottomLineView.backgroundColor = RGBCOLOR(229, 229, 229);
    _bottomLineView.hidden = NO;
    [self addSubview:_bottomLineView];
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.mas_bottom).offset(1);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setOn:(BOOL)On{
    [_switchtView setOn:On];
}


-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if ([self.delegate respondsToSelector:@selector(registeredViewCell:setOn:)]) {
        [self.delegate registeredViewCell:self setOn:isButtonOn];
    }
}


-(void)setFeiyong:(NSString *)feiyong{
    _daiguahaoFeiyong.text = feiyong;
}



@end
