//
//  YMForgetPasswordViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMForgetPasswordViewController.h"

@interface YMForgetPasswordViewController ()
//电话号码输入框
@property (weak, nonatomic) IBOutlet UITextField *telPhoneInputTextField;
//验证码输入框
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
//第一次输入密码
@property (weak, nonatomic) IBOutlet UITextField *firstPwsTextField;
//第二次输入密码
@property (weak, nonatomic) IBOutlet UITextField *secondPwsTextField;
@property (weak, nonatomic) IBOutlet UIButton *getMessageBtn;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YMForgetPasswordViewController
{
    int code;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    code = 60;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishInput)];
    {
    self.telPhoneInputTextField.leftViewMode = UITextFieldViewModeAlways;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.telPhoneInputTextField.placeholder = @"请您输入手机号码";
    self.codeTextField.placeholder = @"发送验证码到绑定手机";
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    label3.text = @"手机号   ";
    label3.font = [UIFont systemFontOfSize:14];
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    label4.text = @"验证码   ";
    label4.font = [UIFont systemFontOfSize:14];
    self.telPhoneInputTextField.leftView = label3;
    self.codeTextField.leftView = label4;
    }
    {
        self.firstPwsTextField.leftViewMode = UITextFieldViewModeAlways;
        self.secondPwsTextField.leftViewMode = UITextFieldViewModeAlways;
        self.firstPwsTextField.placeholder = @"请输入2~9位字符";
        self.secondPwsTextField.placeholder = @"为了保险请再输一遍";
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        label3.text = @"新密码   ";
        label3.font = [UIFont systemFontOfSize:14];
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        label4.text = @"确认密码  ";
        label4.font = [UIFont systemFontOfSize:14];
        self.firstPwsTextField.leftView = label3;
        self.secondPwsTextField.leftView = label4;
    }
}
- (void)finishInput {
    if (![self.firstPwsTextField.text isEqualToString:self.secondPwsTextField.text]) {
        [self showErrorWithTitle:@"两次密码输入不一致" autoCloseTime:2];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = self.telPhoneInputTextField.text;
    param[@"code"] = self.codeTextField.text;
    param[@"password"] = self.firstPwsTextField.text;
    param[@"password_confirm"] = self.secondPwsTextField.text;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=register&op=forgetpas" params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
            
        }
        [self showRightWithTitle:@"修改成功" autoCloseTime:2];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (IBAction)getCodeBtnClick:(id)sender {
    //获取验证码
    typeof(self) weakSelf = self;
    [self.codeTextField becomeFirstResponder];
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=register&op=password_send" params:@{@"phone":self.telPhoneInputTextField.text} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self showRightWithTitle:@"发送成功" autoCloseTime:2];
        weakSelf.getMessageBtn.enabled = NO;
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            code -- ;
            [weakSelf.getMessageBtn setTitle:[NSString stringWithFormat:@"%d",code] forState:UIControlStateDisabled];
            if (code == 0) {
                weakSelf.getMessageBtn.enabled = YES;
                code = 60;
                [timer invalidate];
            }
            
        }];
    }];
}
- (IBAction)endInput:(UITextField *)sender {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
