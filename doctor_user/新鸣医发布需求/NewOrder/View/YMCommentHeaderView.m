//
//  YMCommentHeaderView.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCommentHeaderView.h"

@interface YMCommentHeaderView()

@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation YMCommentHeaderView

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
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = RGBCOLOR(80, 80, 80);
    _titleLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.right.equalTo(self);
    }];
    
    [self drawBottomLine:10 right:10];
}

-(void)setTitleName:(NSString *)titleName {
    _titleLabel.text = titleName;
}

@end
