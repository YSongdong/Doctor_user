//
//  YMActivityBottomView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMActivityBottomView.h"
#import "UIButton+LZCategory.h"

@interface YMActivityBottomView()

@property(nonatomic,strong)UIButton *bottomCenterButton;

@end

@implementation YMActivityBottomView

-(id)initWithFrame:(CGRect)frame{
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
    UIButton *bottomButton =[[UIButton alloc]init];
    bottomButton.backgroundColor =[UIColor clearColor];
    [bottomButton addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _bottomCenterButton = [[UIButton alloc]init];
    _bottomCenterButton.backgroundColor = [UIColor clearColor];
    _bottomCenterButton.titleLabel.font = [UIFont systemFontOfSize:13];
   
    _bottomCenterButton.layer.cornerRadius = 15;
    _bottomCenterButton.layer.masksToBounds = YES;
    [_bottomCenterButton addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bottomCenterButton];
    [_bottomCenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.centerX.centerY.equalTo(self);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - ButtonClick
-(void)bottomClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(activityBottomView:bottomClick:)]) {
        [self.delegate activityBottomView:self bottomClick:sender];
    }
}

#pragma mark - setter
-(void)setBottomTitle:(NSString *)bottomTitle{
    _bottomTitle = bottomTitle;
    [_bottomCenterButton setTitle:_bottomTitle forState:UIControlStateNormal];
    
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    [_bottomCenterButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}

-(void)setType:(BottomViewType)type{
     [_bottomCenterButton setTitle:_bottomTitle forState:UIControlStateNormal];
    switch (type) {
        case BottomDefaultType:{
        
        }
            break;
        case BottomAccountType:{
            _bottomCenterButton.layer.borderColor = RGBCOLOR(229, 229, 229).CGColor;
            [_bottomCenterButton setTitleColor:RGBCOLOR(64, 133, 201) forState:UIControlStateNormal];
            [_bottomCenterButton.layer setBorderWidth:1.0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_bottomCenterButton LZSetbuttonType:LZCategoryTypeRight];
            });
        }
            break;
        case BottomActivityType:
        case BottomUserInfoType:{
            [_bottomCenterButton setTitleColor:RGBCOLOR(80, 168, 255) forState:UIControlStateNormal];
            _bottomCenterButton.backgroundColor = [UIColor whiteColor];
        }
            break;
        default:
            break;
    }
}


@end
