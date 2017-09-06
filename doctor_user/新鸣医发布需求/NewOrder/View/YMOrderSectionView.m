//
//  YMOrderSectionView.m
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderSectionView.h"

@interface YMOrderSectionView()
@property (strong, nonatomic) IBOutlet UIView *View;

@property (weak, nonatomic) IBOutlet UILabel *titleNumberLabel;//数量
@property (weak, nonatomic) IBOutlet UILabel *titleInfoLabel;//信息
@property (weak, nonatomic) IBOutlet UILabel *titleStatusLabel;//状态

@property (weak, nonatomic) IBOutlet UIImageView *rectangleImageView;
@end

@implementation YMOrderSectionView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
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
    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_View];
    [_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(void)setTitleLeftStr:(NSString *)titleLeftStr{
    _titleInfoLabel.text = titleLeftStr;
}

-(void)setTitleRightStr:(NSString *)titleRightStr{
    _titleStatusLabel.text = titleRightStr;
    if (_type == HeaderNumberType) {
        [NSString setRichNumberWithLabel:_titleStatusLabel Color:RGBCOLOR(79, 167, 251) FontSize:13];
    }
}

-(void)setTitleNumberStr:(NSString *)titleNumberStr{
    _titleNumberLabel.text = titleNumberStr;
}

-(void)setType:(HeaderType)type{
    _type = type;
    
    switch (type) {
        case HeaderCloseType:{
            UIButton * closeButon = [[UIButton alloc]init];
            [closeButon addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
            [closeButon setImage:[UIImage imageNamed:@"cancel_order_icon"] forState:UIControlStateNormal];
            [self addSubview:closeButon];
            [closeButon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-10);
                make.top.bottom.equalTo(self);
                make.width.equalTo(@40);
            }];
        }
            break;
        case HeaderTopllTye:{
            _titleStatusLabel.textColor  = RGBCOLOR(255, 161, 42);
        }
            break;
        case HeaderNumberType:{
            _titleStatusLabel.textColor = RGBCOLOR(80, 80, 80);
            [NSString setRichNumberWithLabel:_titleStatusLabel Color:RGBCOLOR(79, 167, 251) FontSize:13];
        }
            break;
        case HeaderFailureType:{
            _titleStatusLabel.textColor  = RGBCOLOR(130, 130, 130);
        }
        default:
            break;
    }
}

-(void)setStatus:(titleStatus)status{
    switch (status) {
        case titleStatusDefaultStatus:{
            _titleNumberLabel.textColor = RGBCOLOR(62, 146, 252);
            _rectangleImageView.image = [UIImage imageNamed:@"dingdian_status_icon"];
            _titleInfoLabel.textColor = [UIColor blackColor];
        }
            break;
        case titleStatusGrayStatus:{
            _titleNumberLabel.textColor = RGBCOLOR(130, 130, 130);
            _rectangleImageView.image = [UIImage imageNamed:@"rectangle_icon_gray"];
            _titleInfoLabel.textColor = RGBCOLOR(51, 51, 51);
        }
            break;
        default:
            break;
    }
}


-(void)closeClick:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(orderSectionView:closeButton:)]){
        [self.delegate orderSectionView:self closeButton:sender];
    }
}


@end
