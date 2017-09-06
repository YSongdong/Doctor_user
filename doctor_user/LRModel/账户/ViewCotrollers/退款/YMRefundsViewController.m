//
//  YMRefundsViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMRefundsViewController.h"
#import "WithDrawViewController.h"
#import "YMSelectBankCardViewController.h"
#import "PhoneView.h"
#import <objc/runtime.h>
#import "SuccessViewController.h"
#import "YMRefundsModel.h"
#import "SuccessViewCtrl.h"
#define  MEMBER_ID [YMUserInfo sharedYMUserInfo].member_id

@interface YMRefundsViewController ()<UITextFieldDelegate,YMSelectBankCardViewControllerDelegate>

@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *centerView;
@property(nonatomic,strong)UIButton *refundsButton;

@property(nonatomic,strong)UITextField *moneyTextField;

@property(nonatomic,strong)UILabel *cardNameAndNumberLabel;

@property(nonatomic,strong)UILabel *userNameLabel;

@property(nonatomic,strong)UILabel *RMBLabel ;

@property(nonatomic,assign)BOOL havePayPass;

@property(nonatomic,strong)YMRefundsModel *model;

@property(nonatomic,strong)UILabel *tipInforLabel;

@property(nonatomic,strong)YMWithdrawModel *withDrawModel;


@end

@implementation YMRefundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    // Do any additional setup after loading the view.
    self.title = @"退款";
    [self initView];
    [self initVar];
    [self requrtData];
    
}

-(void)viewWillAppear:(BOOL)animated{
//    [self requrtData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)initView{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKey)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self initHeaderView];
    [self initCenterView];
    [self initBottomView];
}

-(void)initVar{
    _havePayPass = [_is_paypwd integerValue] == 0 ? NO : YES;
}

-(void)requrtData{

    NSDictionary *params = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=withdraw"
                                                params:params withModel:nil
                                              waitView:self.view
                                        complateHandle:^(id showdata, NSString *error) {
                                                    if (!error) {
                                                        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
                                                            weakSelf.model = [YMRefundsModel modelWithJSON:showdata];
                                                            [weakSelf refreshController];
                                                        }
                                                    }
                                            
                                        }];
}


-(void)refreshController{
    
//    _moneyTextField.text = [NSString stringWithFormat:@"@",_model.money];
    
    _tipInforLabel.text = _model.tips;
    if (_model.bankInfor.card_num.length >0 && _model.bankInfor.name.length>0) {
        _cardNameAndNumberLabel.text = [NSString stringWithFormat:@"%@(%@)",_model.bankInfor.name,_model.bankInfor.card_num];
    }
    
    _userNameLabel.text = _model.bankInfor.mem_name;
}


- (NSMutableAttributedString *)setAttributeStringWithTitle:(NSString *)title {
 
 
 NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                       NSForegroundColorAttributeName:[UIColor textLabelColor]};
 NSMutableAttributedString *attr  = [[NSMutableAttributedString alloc]initWithString:title attributes:dic];
 return attr ;
}


-(void)initHeaderView{
    UIView *headerIntervalView = [[UIView alloc]init];
    headerIntervalView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headerIntervalView];
    [headerIntervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(10);
    }];
    _headerView = [[UIView alloc]init];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(headerIntervalView.mas_bottom);
        make.height.mas_equalTo(110);
    }];
    
    UILabel *plaseLabel = [[UILabel alloc]init];
    plaseLabel.textColor = RGBCOLOR(136, 136, 136);
    plaseLabel.font = [UIFont systemFontOfSize:20];
    plaseLabel.text = @"请输入退款金额:";
    [_headerView addSubview:plaseLabel];
    [plaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headerView.mas_centerY).offset(-10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo([plaseLabel intrinsicContentSize].width+10);
    }];
    
    UILabel *iconhLabel = [[UILabel alloc]init];
    iconhLabel.text = @"¥";
    iconhLabel.font = [UIFont systemFontOfSize:25];
    [_headerView addSubview:iconhLabel];
    [iconhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(plaseLabel.mas_right).offset(-5);
        make.centerY.equalTo(plaseLabel.mas_centerY);
    }];
    
    _moneyTextField = [[UITextField alloc]init];
    _moneyTextField.textColor = [UIColor redColor];
    _moneyTextField.placeholder = @"0.0";
    _moneyTextField.textAlignment = NSTextAlignmentRight;
    _moneyTextField.font = [UIFont systemFontOfSize:22];
    _moneyTextField.delegate = self;
    [_headerView addSubview:_moneyTextField];
    [_moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headerView.mas_right).offset(-10);
        make.centerY.equalTo(plaseLabel.mas_centerY);
        make.height.mas_equalTo(40);
        make.left.equalTo(iconhLabel.mas_right).offset(5);
    }];
    
    _tipInforLabel = [[UILabel alloc]init];
    _tipInforLabel.textColor = RGBCOLOR(80, 80, 80);
    _tipInforLabel.font = [UIFont systemFontOfSize:11];

    _tipInforLabel.textAlignment = NSTextAlignmentRight;
    [_headerView addSubview:_tipInforLabel];
    
    [_tipInforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_moneyTextField.mas_right);
        make.top.equalTo(_moneyTextField.mas_bottom).offset(10);
        make.left.equalTo(plaseLabel.mas_left);
    }];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [_headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_headerView);
        make.height.mas_equalTo(1);
    }];
    
}

-(void)initCenterView{
    
    _centerView = [[UIView alloc]init];
    _centerView.userInteractionEnabled = YES;
    _centerView.backgroundColor = RGBCOLOR(80, 168, 252);
    [self.view addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom).offset(10);
        make.height.mas_equalTo(80);
    }];
    
    
    UIButton *selctBanckButton = [[UIButton alloc]init];
    selctBanckButton.backgroundColor = [UIColor clearColor];
    [selctBanckButton addTarget:self action:@selector(selectBankClick:) forControlEvents:UIControlEventTouchUpInside];
    [_centerView addSubview:selctBanckButton];
    [selctBanckButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_centerView);
    }];

    UILabel *bankLabel = [[UILabel alloc]init];
    bankLabel.font = [UIFont systemFontOfSize:15];
    bankLabel.text = @"到账银行";
    bankLabel.textColor = [UIColor whiteColor];
    [_centerView addSubview:bankLabel];
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_centerView.mas_left).offset(10);
        make.centerY.equalTo(_centerView.mas_centerY).offset(-10);
        make.width.mas_equalTo([bankLabel intrinsicContentSize].width+10);
    }];
    
//    UILabel *feeLabel = [[UILabel alloc]init];
//    feeLabel.text = @"手续费 2.00/100.00";
//    feeLabel.textColor = [UIColor whiteColor];
//    feeLabel.font = [UIFont systemFontOfSize:13];
//    [_centerView addSubview:feeLabel];
//    [feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.centerY.equalTo(bankLabel.mas_bottom).offset(15);
//        make.width.mas_equalTo([feeLabel intrinsicContentSize].width+10);
//    }];
    UIImageView *rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"back_white_icon"];
    [_centerView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_centerView.mas_centerY);
        make.right.equalTo(_centerView.mas_right).offset(-10);
        make.width.height.mas_equalTo(22);
    }];
    
    _cardNameAndNumberLabel = [[UILabel alloc]init];
    _cardNameAndNumberLabel.text = @"选择银行卡";
    _cardNameAndNumberLabel.textAlignment = NSTextAlignmentRight;
    _cardNameAndNumberLabel.font = bankLabel.font ;
    _cardNameAndNumberLabel.textColor = [UIColor whiteColor];
    [_centerView addSubview:_cardNameAndNumberLabel];
    [_cardNameAndNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bankLabel.mas_right).offset(10);
        make.centerY.equalTo(bankLabel.mas_centerY);
        make.right.equalTo(rightImage.mas_left).offset(-10);
    }];
    
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.font = bankLabel.font ;
    _userNameLabel.textAlignment = NSTextAlignmentRight;
    _userNameLabel.textColor = [UIColor whiteColor];
    [_centerView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cardNameAndNumberLabel.mas_left);
        make.top.equalTo(_cardNameAndNumberLabel.mas_bottom).offset(5);
        make.right.equalTo(_cardNameAndNumberLabel.mas_right);
    }];
    
}
-(void)initBottomView{
    _refundsButton = [[UIButton alloc]init];
    _refundsButton.layer.masksToBounds = YES;
    _refundsButton.layer.cornerRadius = 5;
    [_refundsButton setTitle:@"退款" forState:UIControlStateNormal];
    _refundsButton.backgroundColor =RGBCOLOR(80, 168, 252);
    [_refundsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_refundsButton addTarget:self action:@selector(refundsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refundsButton];
    [_refundsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerView.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(45);
    }];
}

-(void)refundsButton:(UIButton *)sender{
    

    if ([_moneyTextField isFirstResponder]) {
        [_moneyTextField resignFirstResponder];
    }

    objc_setAssociatedObject(self, "card_idKey", _withDrawModel.card_id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        if (_moneyTextField.text.length == 0) {
            [self.view showErrorWithTitle:@"请输入提现金额" autoCloseTime:2];
            return ;
        }
        PhoneView *phoneView = [PhoneView phoneViewFromXIBWithTitle:@"请输入手机验证码"];
        phoneView.havePayPass = self.havePayPass ;
        [phoneView showView ];
        __weak typeof(self)weakSelf = self ;
        phoneView.block = ^() {
            NSDictionary *dic = @{@"member_id":MEMBER_ID};
            [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=register&op=send_auth_code" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            }];
        };
        //短信提现
        phoneView.messgeBlock = ^(NSString * code){
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (MEMBER_ID) {
                [dic setObject:MEMBER_ID forKey:@"member_id"];
            }if (objc_getAssociatedObject(weakSelf, "card_idKey")) {
                id value = objc_getAssociatedObject(weakSelf, "card_idKey");
                [dic setObject:value forKey:@"pdc_bank_id"];
            }
            [dic setObject:weakSelf.moneyTextField.text forKey:@"pdc_amount"];
            [dic setObject:code forKey:@"code"];
            dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_SERIAL), ^{
                
                [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=cash" params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
                    if (error) {
                        [self.view showErrorWithTitle:error autoCloseTime:2];
                    }else {
                        [self.view showRightWithTitle:@"已提交提现申请" autoCloseTime:2];
                        [phoneView disappearView];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
            });
        };
        
        //设置支付密码
        phoneView.setPaypassBlock = ^(id value){
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (MEMBER_ID) {
                [dic setObject:MEMBER_ID forKey:@"member_id"];
            }
            [dic setObject:value forKey:@"member_paypwd"];
            [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_account&op=account_zfmms" params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
                if (!error) {
                    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
                    if (MEMBER_ID) {
                        [mudic setObject:MEMBER_ID forKey:@"member_id"];
                    }if (objc_getAssociatedObject(weakSelf, "card_idKey")) {
                        id value = objc_getAssociatedObject(weakSelf, "card_idKey");
                        [mudic setObject:value forKey:@"pdc_bank_id"];
                    }
                    [mudic setObject:weakSelf.moneyTextField.text forKey:@"pdc_amount"];
                    [mudic setObject:value forKey:@"member_paypwd"];
                    NSLog(@"%@",mudic);
                    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_account&op=cashs" params:mudic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                        
                    }];
                }
            }];
        };
        //支付密码提现
        phoneView.paypassBlock = ^(NSString *value) {
            NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
            if (MEMBER_ID) {
                [mudic setObject:MEMBER_ID forKey:@"member_id"];
            }if (objc_getAssociatedObject(weakSelf, "card_idKey")) {
                id value = objc_getAssociatedObject(weakSelf, "card_idKey");
                [mudic setObject:value forKey:@"pdc_bank_id"];
            }
            [mudic setObject:weakSelf.moneyTextField.text forKey:@"pdc_amount"];
            [mudic setObject:value forKey:@"member_paypwd"];
            [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_account&op=cashs" params:mudic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                if (!error) {
                    [phoneView disappearView];
                    [self successViewController];
                }
            }];
            
        };

}


-(void)selectBankClick:(UIButton *)sender{
    NSLog(@"选择银行卡");
//    WithDrawViewController *vc = [[UIStoryboard storyboardWithName:@"Second" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"selectBankCard"];
    YMSelectBankCardViewController *vc = [[YMSelectBankCardViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - YMSelectBankCardViewControllerDelegate

-(void)selectBankCard:(YMSelectBankCardViewController *) selectBankCard withdraw:(YMWithdrawModel *)model{
    
    _withDrawModel = model;
    
    _cardNameAndNumberLabel.text = [NSString stringWithFormat:@"%@...(%@)",model.name,model.card_num];
    _userNameLabel.text = _withDrawModel.mem_name;
    
}


#pragma mark - UITextFieldDelegate



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if ([self validateNumber:string]) {
        return YES;
    }else{
        [self.view showRightWithTitle:@"只能输入数字" autoCloseTime:1];
        return NO;
    }
    

}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
- (void)successViewController {
    
    SuccessViewCtrl *vc = [[UIStoryboard storyboardWithName:@"Success"
                                                           bundle:nil]instantiateViewControllerWithIdentifier:@"SuccessViewCtrl"];
    vc.type = withDraw ;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)hiddenKey{
    [_moneyTextField resignFirstResponder];
}


@end
