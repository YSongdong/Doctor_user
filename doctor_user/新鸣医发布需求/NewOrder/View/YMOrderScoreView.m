//
//  YMOrderScoreView.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderScoreView.h"
#import "XHStarRateView.h"

@interface YMOrderScoreView()<XHStarRateViewDelegate>

@property(nonatomic,strong) UIButton *subitButton;
@property(nonatomic,strong)XHStarRateView *starRateView;

@property(nonatomic,assign)CGFloat subitWidht;

@end


@implementation YMOrderScoreView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

-(void)initView{
    [self initSubitView];
    [self initStarRateView];
}

-(void)initSubitView{
    _subitButton = [[UIButton alloc]init];
    _subitButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_subitButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [_subitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _subitButton.backgroundColor = RGBCOLOR(72, 151, 227);
    _subitButton.layer.masksToBounds = YES;
    _subitButton.layer.cornerRadius = 5.f;
    [self addSubview:_subitButton];
    _subitWidht = _subitButton.intrinsicContentSize.width+10;;
    [_subitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@20);
        make.width.equalTo(@(_subitWidht));
    }];
}

-(void)initStarRateView{
    _starRateView = [[XHStarRateView alloc]initWithFrame:CGRectMake(10, 5, 130, 20)];
    _starRateView.isAnimation = YES;
    _starRateView.delegate = self;
    [self addSubview:_starRateView];
}

#pragma mark - XHStarRateViewDelegate

-(void)starRateView:(XHStarRateView *)starRateView currentScore:(CGFloat)currentScore{
    
}

@end
