//
//  SDTranspView.m
//  doctor_user
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

       //透明view

#import "SDTranspView.h"

@interface SDTranspView ()

@property (nonatomic,strong) UIView *transpView; //背景透明view
@property (nonatomic,strong) UIButton *cancelBtn; //取消按钮
@property (nonatomic,strong) UIView *btnView; //按钮view
@property (nonatomic,strong) UIButton *makePhoneBtn; //拨打电话
@property (nonatomic,strong) UIButton *chatBtn; //在线聊天


@end


@implementation SDTranspView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;

}
-(void) createView
{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor =[UIColor clearColor];
    
    //透明view
    self.transpView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:self.transpView];
    self.transpView.alpha = 0.3;
    self.transpView.backgroundColor = [UIColor blackColor];
    //取消按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [self addSubview:self.cancelBtn];
    [self.cancelBtn setTitle:@"取消"forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = [UIColor btnBlueColor];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //按钮view
    self.btnView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-160, SCREEN_WIDTH, 100)];
    self.btnView.backgroundColor = [UIColor whiteColor];
    [self  addSubview:self.btnView];
    UIView *lineView =[[UIView alloc]init];
    //中间线条
    [self.btnView addSubview:lineView];
    lineView.backgroundColor =[UIColor light_GrayColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.btnView).offset(50);
        make.left.right.equalTo(weakSelf.btnView);
        make.height.equalTo(@1);
    }];
    
    //拨打电话
    self.makePhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnView addSubview:self.makePhoneBtn];
    [self.makePhoneBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    [self.makePhoneBtn setTitleColor:[UIColor btnBlueColor] forState:UIControlStateNormal];
    [self.makePhoneBtn addTarget:self action:@selector(makePhoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.makePhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.btnView);
        make.width.equalTo(weakSelf.btnView.mas_width);
        make.bottom.equalTo(lineView.mas_top).offset(0);
    }];
    //在线聊天
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnView addSubview:self.chatBtn];
    [self.chatBtn setTitle:@"在线聊天" forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.width.equalTo(weakSelf.makePhoneBtn.mas_width);
        make.bottom.equalTo(weakSelf.btnView.mas_bottom);
    }];
    [self.chatBtn addTarget:self action:@selector(chatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{

    _indexPath = indexPath;
}
#pragma mark ---- 按钮点击方法
//取消
-(void)cancelBtnClick:(UIButton *) sender
{
    [self removeFromSuperview];

}

//拨打电话
-(void)makePhoneBtnClick:(UIButton *) sender
{
    if ([self.delegate respondsToSelector:@selector(selectdMakePhoneBtnClick:)]) {
        [self.delegate selectdMakePhoneBtnClick:self.indexPath];
    }
}
//在线聊天
-(void)chatBtnClick:(UIButton *) sender
{
    if ([self.delegate respondsToSelector:@selector(selectdChatBtnClick:)]) {
        [self.delegate selectdChatBtnClick:self.indexPath];
    }

}

@end
