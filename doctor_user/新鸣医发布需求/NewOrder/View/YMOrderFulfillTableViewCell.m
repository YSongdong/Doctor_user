//
//  YMOrderFulfillTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderFulfillTableViewCell.h"

@interface YMOrderFulfillTableViewCell()


@property(nonatomic,strong)UIButton *rightButton;

@property(nonatomic,strong)UIButton *leftButton;

@end


@implementation YMOrderFulfillTableViewCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initView{
    _rightButton = [[UIButton alloc]init];
    _rightButton.layer.masksToBounds = YES;
    _rightButton.backgroundColor = [UIColor clearColor];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:11];
    
    [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitle:@"申请仲裁" forState:UIControlStateNormal];
    _rightButton.layer.masksToBounds = YES;
    _rightButton.layer.cornerRadius = 5;
    _rightButton.layer.borderWidth = 1;
    _rightButton.layer.borderColor = RGBCOLOR(173, 173, 173).CGColor;
    [self addSubview:_rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@22);
        make.width.equalTo(@70);
    }];
    
    _leftButton = [[UIButton alloc]init];
    _leftButton.titleLabel.font = _rightButton.titleLabel.font ;
    [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setTitle:@"确定付款" forState:UIControlStateNormal];
    _leftButton.layer.masksToBounds = YES;
    _leftButton.layer.cornerRadius = 5;
    [self addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightButton.mas_left).offset(-10);
        make.bottom.height.width.equalTo(_rightButton);
    }];
    
    self.type = FulfillButtonAplayType;
}

-(void)setLeftStr:(NSString *)leftStr{
    [_leftButton setTitle:leftStr forState:UIControlStateNormal];
}

-(void)setRightStr:(NSString *)rightStr{
    [_rightButton setTitle:rightStr forState:UIControlStateNormal];
}


-(void)rightClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(orderFulfillViewCell:rightClick:)]) {
        [self.delegate orderFulfillViewCell:self rightClick:sender];
    }
}
-(void)leftClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(orderFulfillViewCell:leftClick:)]) {
        [self.delegate orderFulfillViewCell:self leftClick:sender];
    }
}


-(void)setType:(FulfillButtonType)type{
    switch (type) {
        case FulfillButtonWorkType:{
            _rightButton.layer.masksToBounds = YES;
            _rightButton.layer.borderWidth = 1.f;
            _rightButton.layer.borderColor = RGBCOLOR(249, 74, 0).CGColor;
            _rightButton.layer.cornerRadius = 5.f;
            [_rightButton setTitleColor:RGBCOLOR(248, 113, 69) forState:UIControlStateNormal];
            
            _leftButton.layer.masksToBounds = YES;
            _leftButton.layer.cornerRadius = 5.f;
            _leftButton.backgroundColor = RGBCOLOR(72, 151, 27);
            [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            
            break;
        case FulfillButtonAplayType:{
            _rightButton.layer.masksToBounds = YES;
            _rightButton.layer.borderWidth = 1.f;
            _rightButton.layer.borderColor = RGBCOLOR(251, 172, 109).CGColor;
            _rightButton.layer.cornerRadius = 5.f;
            [_rightButton setTitleColor:RGBCOLOR(252, 169, 70) forState:UIControlStateNormal];
            
            _leftButton.layer.masksToBounds = YES;
            _leftButton.layer.borderWidth = 1.f;
            _leftButton.layer.borderColor = RGBCOLOR(0, 129, 223).CGColor;
            _leftButton.layer.cornerRadius = 5.f;
            _leftButton.backgroundColor = [UIColor clearColor];
            [_leftButton setTitleColor:RGBCOLOR(127, 179, 234) forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

@end
