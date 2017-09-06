//
//  YMOrderStatusView.m
//  doctor_user
//
//  Created by 黄军 on 17/6/2.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderStatusView.h"


@interface YMOrderStatusView()

@property(nonatomic,strong)NSArray *statusArry;

@property(nonatomic,assign)NSInteger selectTextTag;

@end

@implementation YMOrderStatusView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initVar];
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initVar];
    [self initView];
}

-(void)initVar{
    _statusArry = @[@"全部",@"进行中",@"已完成",@"已失败"];
}

-(void)initView{
    CGFloat subWidth = (SCREEN_WIDTH - 10*5 )/4.0;

    for (NSInteger i = 0 ;i<_statusArry.count;i++) {
        UIButton *commodityButton = [[UIButton alloc]init];
        commodityButton.titleLabel.font = [UIFont systemFontOfSize:13];
        commodityButton.tag = allOrderTag+i;
        [commodityButton setTitle:_statusArry[i] forState:UIControlStateNormal];
        [commodityButton addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside
         ];
        
        if (i == 0) {
            _selectTextTag = commodityButton.tag;
        }
        commodityButton.layer.cornerRadius = 15;
        commodityButton.layer.masksToBounds =YES;
        
        [commodityButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        commodityButton.backgroundColor = RGBCOLOR(255, 255, 255);
        
        [self addSubview:commodityButton];
        [commodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(subWidth *i+(10*(i+1)));
            make.centerY.equalTo(self);
            make.width.mas_offset(subWidth);
            make.height.equalTo(@30);
        }];
    }
}

-(void)selectOrderStatus:(OrderTag)orderStatus{

    NSArray *subViewArry = [self subviews];
    
    for (NSInteger i= 0; i<subViewArry.count; i++) {
        
        UIButton *sender = (UIButton *)[self viewWithTag:allOrderTag+i];
        
        if (_selectTextTag == sender.tag) {
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            sender.backgroundColor = RGBCOLOR(80, 168, 252);
        }else{
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [sender setBackgroundColor:RGBCOLOR(255, 255, 255)];
        }
    }
}

-(void)filterClick:(UIButton *)sender{
    if (sender.tag == _selectTextTag) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(orderStatusView:clickTag:)]) {
        [self.delegate orderStatusView:self clickTag:sender.tag];
    }
    _selectTextTag = sender.tag;
    [self selectOrderStatus:sender.tag];
}

@end
