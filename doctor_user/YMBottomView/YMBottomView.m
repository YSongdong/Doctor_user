//
//  YMBottomView.m
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMBottomView.h"


@interface YMBottomView()


@property(nonatomic,strong)UIButton *bottomButton;



@end

@implementation YMBottomView


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
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttomClick)];
    [self addGestureRecognizer:gesture];
    
    _bottomButton = [[UIButton alloc]init];
    _bottomButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bottomButton addTarget:self action:@selector(buttomClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bottomButton];
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    _bottomButton.layer.masksToBounds = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        _bottomButton.layer.cornerRadius = (self.height-10)/2.f;
    });
    
}

-(void)setType:(MYBottomType)type{
    switch (type) {
        case MYBottomBlueType:{
            self.backgroundColor = RGBCOLOR(74, 153, 227);
            _bottomButton.backgroundColor = [UIColor whiteColor];
            [_bottomButton setTitleColor:RGBCOLOR(81, 153, 224) forState:UIControlStateNormal];
        }
            break;
        case MYBottomBlueAndLeftIconType:{
            self.backgroundColor = RGBCOLOR(74, 153, 227);
            _bottomButton.backgroundColor = [UIColor whiteColor];
            [_bottomButton setTitleColor:RGBCOLOR(81, 153, 224) forState:UIControlStateNormal];
        }
        case MYBottomBlueAndwhiteType:{
            self.backgroundColor = RGBCOLOR(74, 153, 227);
            _bottomButton.backgroundColor = [UIColor clearColor];
            [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;

            break;
        case MYBottomGrayType:{
            self.backgroundColor = RGBCOLOR(224, 225, 226);
            _bottomButton.backgroundColor = [UIColor whiteColor];
            [_bottomButton setTitleColor:RGBCOLOR(148, 148, 148) forState:UIControlStateNormal];
        }
            break;
        case MYBottomWhiteBackAndGrayTextAndLeftIconType:{
            self.backgroundColor = [UIColor whiteColor];
            _bottomButton.backgroundColor = [UIColor whiteColor];
            [_bottomButton setTitleColor:RGBCOLOR(148, 148, 148) forState:UIControlStateNormal];
            _bottomButton.layer.borderWidth = 1;
            _bottomButton.layer.masksToBounds = YES;
            _bottomButton.layer.borderColor = RGBCOLOR(229, 229, 229).CGColor;
        }
            break;
        case MYBottomWhiteType:{
            self.backgroundColor = [UIColor whiteColor];
            _bottomButton.backgroundColor = [UIColor whiteColor];
            [_bottomButton setTitleColor:RGBCOLOR(81, 153, 224) forState:UIControlStateNormal];
            _bottomButton.layer.borderWidth = 1;
            _bottomButton.layer.masksToBounds = YES;
            _bottomButton.layer.borderColor = RGBCOLOR(229, 229, 229).CGColor;
        }
            break;
        case MYBottomWhiteAndLeftIconType:{
            self.backgroundColor = [UIColor whiteColor];
            _bottomButton.backgroundColor = [UIColor whiteColor];
            [_bottomButton setTitleColor:RGBCOLOR(81, 153, 224) forState:UIControlStateNormal];
            _bottomButton.layer.borderWidth = 1;
            _bottomButton.layer.masksToBounds = YES;
            _bottomButton.layer.borderColor = RGBCOLOR(229, 229, 229).CGColor;
            
        }
            break;
        default:
            break;
    }
}

-(void)setBottomTitle:(NSString *)bottomTitle{
    [_bottomButton setTitle:bottomTitle forState:UIControlStateNormal];
}

-(void)setBottomImageName:(NSString *)bottomImageName{
    [_bottomButton setImage:[UIImage imageNamed:bottomImageName] forState:UIControlStateNormal];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_bottomButton LZSetbuttonType:LZCategoryTypeRight];
    });
}

-(void)buttomClick{
    if ([self.delegate respondsToSelector:@selector(bottomView:)]) {
        [self.delegate bottomView:self];
    }
}

@end
