//
//  YMNewPlayView.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMNewPayView.h"

#import "YMPayKeyBoardView.h"

@interface YMNewPayView()<YMPayKeyBoardViewDelegate>

@property(nonatomic,strong)UITextField *passworldTextField;

@property(nonatomic,strong)UIButton *backButton;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIButton *fulfillButton;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)UIButton *forgetPassworldButton;

@property(nonatomic,strong)YMPayKeyBoardView *keyBoardView;

@end

@implementation YMNewPayView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initHeaderView];
    [self initTextFieldView];
    [self initKeyView];
    
}
-(void)initHeaderView{
    _headerView = [[UIView  alloc]init];
    [self addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@50);
    }];
    _backButton = [[UIButton alloc]init];
    [_backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(_headerView);
        make.width.equalTo(@50);
    }];
    
    _fulfillButton = [[UIButton alloc]init];
    [_fulfillButton setTitle:@"完成" forState:UIControlStateNormal];
    [_fulfillButton setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
    _fulfillButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_headerView addSubview:_fulfillButton];
    [_fulfillButton addTarget:self action:@selector(fulfillClick:) forControlEvents:UIControlEventTouchUpInside];
    [_fulfillButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(_headerView);
        make.width.equalTo(@50);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"帐户支付";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor =RGBCOLOR(51, 51, 51);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_headerView);
    }];
    
    [_headerView drawBottomLine:10 right:10];
}

-(void)initTextFieldView{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyBoard)];
    [self addGestureRecognizer:tap];
    
    _passworldTextField = [[UITextField alloc]init];
    _passworldTextField.font = [UIFont systemFontOfSize:15];
    _passworldTextField.placeholder = @"请输入您的支付密码";
    [_passworldTextField becomeFirstResponder];
    [self addSubview:_passworldTextField];
    _passworldTextField.secureTextEntry = YES;
    [_passworldTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_headerView.mas_bottom).offset(10);
        make.height.equalTo(@20);
    }];
    
    _forgetPassworldButton = [[UIButton alloc]init];
    _forgetPassworldButton.backgroundColor = [UIColor clearColor];
    _forgetPassworldButton.hidden = YES;
    [_forgetPassworldButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetPassworldButton setTitleColor:RGBCOLOR(105, 176, 255) forState:UIControlStateNormal];
    [_forgetPassworldButton addTarget:self action:@selector(orgetPassworldClick:) forControlEvents:UIControlEventTouchUpInside];
    _forgetPassworldButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_forgetPassworldButton];
//    [_forgetPassworldButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-5);
//        make.top.equalTo(_passworldTextField.mas_bottom).offset(5);
//        make.width.mas_equalTo(_forgetPassworldButton.titleLabel.intrinsicContentSize.width);
//        make.height.equalTo(@20);
//    }];
}

-(void)initKeyView{
    _keyBoardView = [[YMPayKeyBoardView alloc]init];
    _keyBoardView.delegate = self;
    _passworldTextField.inputView = _keyBoardView;
    [_passworldTextField reloadInputViews];
}


#pragma mark - setter 
-(void)setType:(TitleType)type{
    switch (type) {
        case TitlePassworldType:{
            _passworldTextField.text = @"";
            _titleLabel.text = @"帐户支付";
//            _forgetPassworldButton.hidden = NO;
            _passworldTextField.placeholder = @"请输入您的支付密码";
            [_forgetPassworldButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-5);
                make.top.equalTo(_passworldTextField.mas_bottom).offset(5);
                make.width.mas_equalTo(_forgetPassworldButton.titleLabel.intrinsicContentSize.width);
                make.height.equalTo(@20);
            }];
        }
            break;
        case TitleNoSetPassworldType:{
            _titleLabel.text = @"设置支付密码";
//            _forgetPassworldButton.hidden = YES;
            _passworldTextField.placeholder = @"添加支付密码";
        }
            break;
        default:
            break;
    }
}


//返回数字
- (void)numberKeyBoard:(NSInteger) number{
    NSString *str = self.passworldTextField.text;
    self.passworldTextField.text = [NSString stringWithFormat:@"%@%ld",str,(long)number];
    if ([self.delegate respondsToSelector:@selector(newPayView:textField:)]) {
        [self.delegate newPayView:self textField:self.passworldTextField.text];
    }
}
-(void)clearKeyBoard{
    NSMutableString *muStr = [[NSMutableString alloc] initWithString:self.passworldTextField.text];
    if (muStr.length <= 0) {
        return;
    }
    [muStr deleteCharactersInRange:NSMakeRange([muStr length] - 1, 1)];
    self.passworldTextField.text = muStr;
    if ([self.delegate respondsToSelector:@selector(newPayView:textField:)]) {
        [self.delegate newPayView:self textField:self.passworldTextField.text];
    }
}

-(void)orgetPassworldClick:(UIButton *)sender{
    NSLog(@"忘记密码");
    if ([self.delegate respondsToSelector:@selector(newPayView:forgetPasdButton:)]) {
        [self.delegate newPayView:self forgetPasdButton:sender];
    }
}


-(void)hidenKeyBoard{
    NSLog(@"键盘隐藏");
    [self.passworldTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"显示键盘");
}


-(void)fulfillClick:(UIButton *)sender{
    NSLog(@"完成按钮点击");
    if ([self.delegate respondsToSelector:@selector(newPayView:fulfillButton:)]) {
        [self.delegate newPayView:self fulfillButton:sender];
    }
}

-(void)backClick:(UIButton*)sender{
    NSLog(@"返回按钮");
    if ([self.delegate respondsToSelector:@selector(newPayView:backButton:)]) {
        [self.delegate newPayView:self backButton:sender];
    }
}


@end
