//
//  WithDrawSureViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "WithDrawSureViewController.h"
#import "WithDrawViewController.h"
#import "PassView.h"
#import "PhoneView.h"
#import <objc/runtime.h>
#define  MEMBER_ID [YMUserInfo sharedYMUserInfo].member_id
@interface WithDrawSureViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn; //确认提现按钮
@property (weak, nonatomic) IBOutlet UILabel *feeLabel; //手续费
@property (weak, nonatomic) IBOutlet UITextField *moneyTextfield;

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIButton *bankName;
@property (nonatomic,strong)NSString *bankString;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (nonatomic,assign)BOOL havePayPass ;

@end
@implementation WithDrawSureViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"alipayNotification" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
//    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayChoiced:) name:@"alipayNotification" object:nil];
}
- (void)setup {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([YMUserInfo sharedYMUserInfo].member_id){
        [dic setObject:[YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
    }
    self.bankString = @"选择卡号";
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=index"
                                    params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                                        if (!error) {
              self.moneyTextfield.attributedPlaceholder =[self setAttributeStringWithTitle:[NSString stringWithFormat:@"可退款%@元",showdata[@"money"][@"available_predeposit"]]];
                self.havePayPass = [showdata[@"money"][@"is_paypwd"] integerValue];
        }
}];
    _moneyTextfield.delegate = self ;
}

- (NSMutableAttributedString *)setAttributeStringWithTitle:(NSString *)title {
    
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor textLabelColor]};
    NSMutableAttributedString *attr  = [[NSMutableAttributedString alloc]initWithString:title attributes:dic];
    return attr ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if ([textField.text floatValue] - [self.money floatValue] < 0) {

    }
    return YES ;
}
- (void)viewWillDisappear:(BOOL)animated {
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     self.moneyTextfield.placeholder = @"请输入提现金额";
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor textLabelColor]};
    NSMutableAttributedString *attr  = [[NSMutableAttributedString alloc]initWithString:@"请输入提现金额" attributes:dic];
    self.moneyTextfield.attributedPlaceholder = attr ;
    self.feeLabel.hidden = YES ;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.sureBtn.layer.cornerRadius = 4 ;
    self.sureBtn.layer.masksToBounds = YES ;
    self.bankName.tintColor = [UIColor whiteColor];
}

-(NSMutableAttributedString *)attributeStringWithStr:(NSString *)str{
    
    NSTextAttachment *attch = [[NSTextAttachment alloc]init];
    attch.image = [UIImage imageNamed:@"next1.png"];
    attch.bounds = CGRectMake(0, 0, 15, 15);
   NSAttributedString *attribte = [NSAttributedString attributedStringWithAttachment:attch];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [att setAttributes:dic range:NSMakeRange(0, att.length)];
    [att appendAttributedString:attribte];
     return att ;
}
- (void)setBankString:(NSString *)bankString {
    _bankString = bankString ;
      [self.bankName setAttributedTitle:[self attributeStringWithStr:bankString] forState:UIControlStateNormal];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"shoDrawIdentifier"]) {
        
        
        WithDrawViewController *vc = segue.destinationViewController ;
        __weak typeof(self)weakSelf = self ;
        vc.ways = 1 ;
        [vc choiceBankName:^(id value) {
    objc_setAssociatedObject(self, "card_idKey", value[@"card_id"], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                NSString *str= [value[@"card_num"]
                    substringFromIndex:[value[@"card_num"] length] - 4];
             self.bankString =  [@"" stringByAppendingFormat:@"(....%@)",str];

        }];
    }
}
//选择支付宝提现
- (void)alipayChoiced:(NSNotification *)notify {
    
     NSDictionary *dic = notify.object ;
    objc_setAssociatedObject(self, "card_idKey", dic[@"card_id"], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.bankString = dic[@"card_num"];
    self.bankNameLabel.text = dic[@"mem_name"];
}
- (IBAction)drawEvent:(id)sender {

    if ([_moneyTextfield isFirstResponder]) {
        [_moneyTextfield resignFirstResponder];
    }
    if (_moneyTextfield.text.length == 0) {
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
        [dic setObject:weakSelf.moneyTextfield.text forKey:@"pdc_amount"];
        [dic setObject:code forKey:@"code"];
        dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_SERIAL), ^{
            
            [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=cash" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                if (error) {
                    [self.view showErrorWithTitle:error autoCloseTime:2];
                }else {
                    [self.view showRightWithTitle:@"已提交提现申请" autoCloseTime:2];
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
                [mudic setObject:weakSelf.moneyTextfield.text forKey:@"pdc_amount"];
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
        [mudic setObject:weakSelf.moneyTextfield.text forKey:@"pdc_amount"];
        [mudic setObject:value forKey:@"member_paypwd"];
        [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_account&op=cashs" params:mudic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            
            
        }];

    };
}


@end
