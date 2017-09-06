//
//  YMOfficialActivityTopView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOfficialActivityTopView.h"


static NSInteger const promptWidth = 50;
static NSInteger const lineColor = 229;
static NSInteger const NoSelctWordColor = 152;

@interface YMOfficialActivityTopView()

@property(nonatomic,strong)UIButton *hallButton;//活动大厅
@property(nonatomic,strong)UIButton *participateButton;//我参与

@property(nonatomic,strong)UIView *hallLineView;//活动大厅下的横线
@property(nonatomic,strong)UIView *participateLineView;//我参与下的横线

@property(nonatomic,strong)UIView *verticalLineView;//垂直线

@end

@implementation YMOfficialActivityTopView

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
    
    _verticalLineView = [[UIView alloc]init];
    _verticalLineView.backgroundColor = RGBCOLOR(lineColor, lineColor, lineColor);
    [self addSubview:_verticalLineView];
    [_verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(1);
    }];
    
    _hallLineView = [[UIView alloc]init];
    _hallLineView.backgroundColor = RGBCOLOR(80, 168, 252);
    [self addSubview:_hallLineView];
    [_hallLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.right.equalTo(_verticalLineView.mas_left);
        make.height.mas_equalTo(2);
    }];
    
    _participateLineView = [[UIView alloc]init];
    _participateLineView.backgroundColor = RGBCOLOR(lineColor, lineColor, lineColor);
    [self addSubview:_participateLineView];
    [_participateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(_verticalLineView.mas_right);
        make.height.mas_equalTo(2);
    }];
    
    _hallButton = [[UIButton alloc]init];
    [_hallButton setTitle:@"活动大厅" forState:UIControlStateNormal];
    [_hallButton setTitleColor:RGBCOLOR(64, 133, 201) forState:UIControlStateNormal];
    _hallButton.backgroundColor = [UIColor clearColor];
    [_hallButton addTarget:self action:@selector(clickhall:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hallButton];
    [_hallButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.right.equalTo(_verticalLineView.mas_left);
        make.bottom.equalTo(_hallLineView.mas_top);
    }];
    
    _participateButton = [[UIButton alloc]init];
    [_participateButton setTitleColor:RGBCOLOR(NoSelctWordColor, NoSelctWordColor, NoSelctWordColor) forState:UIControlStateNormal];
    [_participateButton setTitle:@"我参与的" forState:UIControlStateNormal];
    _participateButton.backgroundColor = [UIColor clearColor];
    [_participateButton addTarget:self action:@selector(clickparticipate:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_participateButton];
    [_participateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_hallButton);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(_verticalLineView.mas_right);
    }];
}

#pragma mark - clickButton
-(void)clickhall:(UIButton *)sender{
    
    [_hallButton setTitleColor:RGBCOLOR(64, 133, 201) forState:UIControlStateNormal];
    _hallLineView.backgroundColor = RGBCOLOR(80, 168, 252);
    
    [_participateButton setTitleColor:RGBCOLOR(NoSelctWordColor, NoSelctWordColor, NoSelctWordColor)  forState:UIControlStateNormal];
    _participateLineView.backgroundColor = RGBCOLOR(lineColor, lineColor, lineColor);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(officialActivityView:hallButton:)]) {
        [self.delegate officialActivityView:self hallButton:sender];
    }
}

-(void)clickparticipate:(UIButton *)sender{

    [_hallButton setTitleColor:RGBCOLOR(NoSelctWordColor, NoSelctWordColor, NoSelctWordColor) forState:UIControlStateNormal];
    _hallLineView.backgroundColor =RGBCOLOR(lineColor, lineColor, lineColor);
    
    [_participateButton setTitleColor:RGBCOLOR(64, 133, 201) forState:UIControlStateNormal];
    _participateLineView.backgroundColor = RGBCOLOR(80, 168, 252);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(officialActivityView:participateButton:)]) {
        [self.delegate officialActivityView:self participateButton:sender];
    }
}
#pragma mark -setter
-(void)setLefName:(NSString *)lefName{
    [_hallButton setTitle:lefName forState:UIControlStateNormal];
}
-(void)setRightName:(NSString *)rightName{
    [_participateButton setTitle:rightName forState:UIControlStateNormal];
}

//跳转到右边的按钮
-(void)setIsRightBtn:(BOOL)isRightBtn{

    _isRightBtn = isRightBtn;
    if (isRightBtn) {
        [self clickparticipate:_participateButton];
    }

}


@end

