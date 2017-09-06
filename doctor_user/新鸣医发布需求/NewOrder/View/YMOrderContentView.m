//
//  YMOrderContentView.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderContentView.h"
#import "YMLabelButtonView.h"
#import "XHStarRateView.h"
//#import "YMOrderScoreView.h"
#import "YMBottomView.h"
#import "YMOrderSectionView.h"

@interface YMOrderContentView()<YMBottomViewDelegate,YMOrderSectionViewDelegate,XHStarRateViewDelegate,YMLabelButtonViewDelegate>

@property(nonatomic,strong)YMLabelButtonView *labelButtonView;

@property(nonatomic,strong)XHStarRateView *starRateView;

@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,strong)YMOrderSectionView *orderSectinView;

@property(nonatomic,strong)UIView *serverControllerView;

@property(nonatomic,assign)NSInteger commentNumber;

@property(nonatomic,strong)NSArray *selectLabelArr;

@property(nonatomic,copy)NSString *user_ping;

@end

@implementation YMOrderContentView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _commentNumber = 0;
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

-(void)initView{
    [self initBottomView];
    [self initServerControllerView];
    [self initCommentLabaView];
    [self initOrderSectinView];
    
}
-(void)initBottomView{
    _bottomView = [[YMBottomView alloc]init];
    _bottomView.type = MYBottomBlueAndwhiteType;
    _bottomView.bottomTitle = @"提交评价";
    _bottomView.delegate = self;
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@44);
    }];
}
-(void)initServerControllerView{
    _serverControllerView = [[UIView alloc]init];
    _serverControllerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_serverControllerView];
    [_serverControllerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(_bottomView.mas_top).offset(-10);
        make.height.equalTo(@40);
    }];
    UILabel *tipLabel =[[UILabel alloc]init];
    tipLabel.text  =@"服务评分";
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = RGBCOLOR(130, 130, 130);
    [_serverControllerView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_serverControllerView.mas_left).offset(10);
        make.top.bottom.equalTo(_serverControllerView);
    }];
    
    _starRateView = [[XHStarRateView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 5, 130, 20)];
    _starRateView.isAnimation = YES;
    _starRateView.delegate = self;
    [_serverControllerView addSubview:_starRateView];
}

-(void)initCommentLabaView{
    _labelButtonView= [[YMLabelButtonView alloc]init];
    _labelButtonView.backgroundColor = [UIColor whiteColor];
    _labelButtonView.delegate = self;
    _labelButtonView.width = SCREEN_WIDTH;
    [self addSubview:_labelButtonView];
    [_labelButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(_serverControllerView.mas_top);
        make.height.equalTo(@70);
    }];
}

-(void)initOrderSectinView{
    _orderSectinView = [[YMOrderSectionView alloc]init];
    _orderSectinView.delegate = self;
    _orderSectinView.backgroundColor = [UIColor whiteColor];
    _orderSectinView.type = HeaderCloseType;
    _orderSectinView.titleLeftStr = @"完成工作，双方互评";
    _orderSectinView.titleNumberStr =@"03";
    _orderSectinView.titleRightStr = @"";
    [self addSubview:_orderSectinView];
    [_orderSectinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_labelButtonView.mas_top);
        make.left.right.equalTo(self);
        make.height.equalTo(@30);
    }];
    
}

#pragma mark - setter
-(void)setLabeArry:(NSArray *)labeArry{
    _user_ping = @"";
    [_labelButtonView removeAllSubviews];
    _labeArry = labeArry;
    _labelButtonView.labelArry = labeArry;
}

#pragma mark - XHStarRateViewDelegate
-(void)starRateView:(XHStarRateView *)starRateView currentScore:(CGFloat)currentScore{
    _commentNumber = currentScore ;
}

#pragma mark - YMBottomViewDelegate
-(void)bottomView:(YMBottomView *)bottomClick{
    
    
    if ([self.delegate respondsToSelector:@selector(orderContentView:userSubPing:submitButton:)]) {
        [self.delegate orderContentView:self
                            userSubPing:@{@"user_score":@(_commentNumber),
                                          @"user_ping":_user_ping}
                           submitButton:nil];
    }
}

#pragma mark -  YMOrderSectionViewDelegate
-(void)orderSectionView:(YMOrderSectionView *)View closeButton:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(orderContentView:closeButton:)]) {
        [self.delegate orderContentView:self closeButton:sender];
    }
}

#pragma mark - YMLabelButtonViewDelegate

-(void)labelButtonView:(YMLabelButtonView *)labelButtonView replaceClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(orderContentView:changeButton:)]) {
        [self.delegate orderContentView:self changeButton:sender];
    }
}

-(void)labelButtonView:(YMLabelButtonView *)labelButtonView slectLabelArr:(NSMutableArray  *)slectLabelArr{

    _user_ping = @"";
    if (slectLabelArr.count>0) {
        NSString *tag = slectLabelArr[0];
       _user_ping = _labeArry[[tag integerValue]];
        
        for (NSInteger i=1;i< slectLabelArr.count; i++) {
              NSString * nestTag = slectLabelArr[i];
            _user_ping = [NSString stringWithFormat:@"%@,%@",_user_ping,_labeArry[[nestTag integerValue]]];
        }
    }
}

@end
