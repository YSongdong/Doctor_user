//
//  YMOrderFuaFulfillTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderFuaFulfillTableViewCell.h"

@interface YMOrderFuaFulfillTableViewCell()

@property(nonatomic,strong)UIButton *evaluationButton;
@property(nonatomic,strong)UIButton *lookevaluationButton;

@end

@implementation YMOrderFuaFulfillTableViewCell

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
    _lookevaluationButton = [[UIButton alloc]init];
    _lookevaluationButton.layer.masksToBounds = YES;
    _lookevaluationButton.layer.cornerRadius = 3;
    _lookevaluationButton.layer.borderWidth = 1;
    _lookevaluationButton.layer.borderColor = RGBCOLOR(252, 153, 15).CGColor;
    [_lookevaluationButton setTitle:@"查看评价" forState:UIControlStateNormal];
    [_lookevaluationButton addTarget:self action:@selector(lookevaluationClick:) forControlEvents:UIControlEventTouchUpInside];
    _lookevaluationButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_lookevaluationButton setTitleColor:RGBCOLOR(252, 152, 15) forState:UIControlStateNormal];
    [self addSubview:_lookevaluationButton];
    [_lookevaluationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@23);
        make.width.mas_equalTo(_lookevaluationButton.titleLabel.intrinsicContentSize.width + 20);
    }];
    
    
    _evaluationButton = [[UIButton alloc]init];
    _evaluationButton.layer.masksToBounds = YES;
    _evaluationButton.layer.cornerRadius = 3;
    _evaluationButton.layer.borderWidth = 1;
    _evaluationButton.layer.borderColor = RGBCOLOR(66, 147,227).CGColor;
    [_evaluationButton setTitle:@"去评价" forState:UIControlStateNormal];
    _evaluationButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_evaluationButton setTitleColor:RGBCOLOR(66, 147,227) forState:UIControlStateNormal];
     [_evaluationButton addTarget:self action:@selector(evaluationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_evaluationButton];
    [_evaluationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_lookevaluationButton.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@23);
        make.width.mas_equalTo(_evaluationButton.titleLabel.intrinsicContentSize.width + 20);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter

-(void)setWhetherPay:(BOOL)whetherPay{
    if (whetherPay) {
        _lookevaluationButton.userInteractionEnabled = YES;;
        _lookevaluationButton.layer.borderColor = RGBCOLOR(252, 153, 15).CGColor;
        [_lookevaluationButton setTitleColor:RGBCOLOR(252, 152, 15) forState:UIControlStateNormal];
       // _evaluationButton.layer.borderColor = RGBCOLOR(66, 147,227).CGColor;
       // [_evaluationButton setTitleColor:RGBCOLOR(66, 147,227) forState:UIControlStateNormal];
       
        
    }else{
        _lookevaluationButton.userInteractionEnabled = NO;
       // _evaluationButton.userInteractionEnabled = NO;
        _lookevaluationButton.layer.borderColor = RGBCOLOR(80, 80, 80).CGColor;
        [_lookevaluationButton setTitleColor:RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
       // _evaluationButton.layer.borderColor = RGBCOLOR(80, 80,80).CGColor;
        
       // [_evaluationButton setTitleColor:RGBCOLOR(130, 130,130) forState:UIControlStateNormal];
    }
}

//评价
-(void)setEvaluation:(BOOL)evaluation{

    if (evaluation) {
        _evaluationButton.userInteractionEnabled = NO;
        _evaluationButton.backgroundColor = RGBCOLOR(148, 148, 148);
        _evaluationButton.layer.borderColor = RGBCOLOR(148, 148, 148).CGColor;
        [_evaluationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        _evaluationButton.layer.borderColor = RGBCOLOR(66, 147,227).CGColor;
        [_evaluationButton setTitleColor:RGBCOLOR(66, 147,227) forState:UIControlStateNormal];
        _evaluationButton.userInteractionEnabled = YES;
    
    }


}

-(void)lookevaluationClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(orderFuaFulfillCell:lookevaluationButton:)]) {
        [self.delegate orderFuaFulfillCell:self lookevaluationButton:sender];
    }
}

-(void)evaluationClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(orderFuaFulfillCell:evaluationButton:)]) {
        [self.delegate orderFuaFulfillCell:self evaluationButton:sender];
    }
}

-(void)setModel:(YMDoctorOrderProcessModel *)model{

    NSString *order_type = model.order_type;
    
    NSString *mingyistatus = model.mingyi_status;
    NSString *yuystatus = model.yuyue_status;
    
    if ([order_type  integerValue] == 1) {
        //鸣医订单
        if ([mingyistatus integerValue] == 4) {
            NSString *userPingStr = model.user_ping;
            if (![userPingStr isEqualToString:@""]) {
                _evaluationButton.userInteractionEnabled = NO;
                _evaluationButton.backgroundColor = RGBCOLOR(148, 148, 148);
                _evaluationButton.layer.borderColor = RGBCOLOR(148, 148, 148).CGColor;
                [_evaluationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }else{
            _evaluationButton.userInteractionEnabled = YES;
            _evaluationButton.layer.borderColor = RGBCOLOR(66, 147,227).CGColor;
            [_evaluationButton setTitleColor:RGBCOLOR(66, 147,227) forState:UIControlStateNormal];
        }
    }else if ([order_type  integerValue] == 2){
      //预约订单
        if (([yuystatus integerValue] == 6) ) {
            NSString *userPingStr = model.user_ping;
            if (![userPingStr isEqualToString:@""]) {
                _evaluationButton.userInteractionEnabled = NO;
                _evaluationButton.backgroundColor = RGBCOLOR(148, 148, 148);
                _evaluationButton.layer.borderColor = RGBCOLOR(148, 148, 148).CGColor;
                [_evaluationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }else{
            
            _evaluationButton.userInteractionEnabled = YES;
            _evaluationButton.layer.borderColor = RGBCOLOR(66, 147,227).CGColor;
            [_evaluationButton setTitleColor:RGBCOLOR(66, 147,227) forState:UIControlStateNormal];
        }

    
    }
    
    
    


}






@end
