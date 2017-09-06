//
//  YMRegisterViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMRegisterViewController.h"
#import "LRMacroDefinitionHeader.h"
#import "KRUserProtocolViewController.h"
@interface YMRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thredView;
@property (weak, nonatomic) IBOutlet UIView *fouthView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *codetEXTfIELD;
@property (weak, nonatomic) IBOutlet UITextField *firstPwsTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondPwsTextField;
@property (weak, nonatomic) IBOutlet UIButton *getMessageBtn;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YMRegisterViewController
{
    int code;
    bool isRead;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户注册";
    code = 60;
    isRead = YES;
    LRViewBorderRadius(self.firstView,3,1,[UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]);
    LRViewBorderRadius(self.secondView,3,1,[UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]);
    LRViewBorderRadius(self.thredView,3,1,[UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]);
    LRViewBorderRadius(self.fouthView,3,1,[UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]);
    {
        NSString *str1 = @"   注册即代表阅读并同意";
        NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:str1];
        NSTextAttachment *attacgment1 = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        
        attacgment1.image = [UIImage imageNamed:@"选框1"];
        attacgment1.bounds = CGRectMake(0, -3, 15, 15);
        [attrString1 insertAttributedString:[NSAttributedString attributedStringWithAttachment:attacgment1] atIndex:0];
        [attrString1 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(1, str1.length)];
        [self.readBtn setAttributedTitle:attrString1 forState:UIControlStateNormal];
        NSString *str2 = @"   注册即代表阅读并同意";
        NSMutableAttributedString *attrString2 = [[NSMutableAttributedString alloc] initWithString:str2];
        NSTextAttachment *attacgment2 = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        
        attacgment2.image = [UIImage imageNamed:@"选框2"];
        attacgment2.bounds = CGRectMake(0, -3, 15, 15);
        [attrString2 insertAttributedString:[NSAttributedString attributedStringWithAttachment:attacgment2] atIndex:0];
        [attrString2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(1, str2.length)];
        [self.readBtn setSelected:YES];
        [self.readBtn setAttributedTitle:attrString2 forState:UIControlStateSelected];
    }
    {
        {
            self.phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
            self.codetEXTfIELD.leftViewMode = UITextFieldViewModeAlways;
            self.phoneNumTextField.placeholder = @"+86";
            self.codetEXTfIELD.placeholder = @"发送验证码到绑定手机";
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
            label3.text = @"手机号   ";
            label3.font = [UIFont systemFontOfSize:14];
            UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
            label4.text = @"验证码   ";
            label4.font = [UIFont systemFontOfSize:14];
            self.phoneNumTextField.leftView = label3;
            self.codetEXTfIELD.leftView = label4;
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
}
- (IBAction)readBtnClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    isRead = sender.selected;
}
- (IBAction)inputEnd:(UITextField *)sender {
    [self.view endEditing:YES];
}
- (IBAction)finishBtnClick:(id)sender {
    if (!isRead) {
        [self showErrorWithTitle:@"需要同意协议" autoCloseTime:2];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (![self.firstPwsTextField.text isEqualToString:self.secondPwsTextField.text]) {
        [self showErrorWithTitle:@"两次密码输入不一致" autoCloseTime:2];
        return;
    }
    param[@"password"] = self.firstPwsTextField.text;
    param[@"password_confirm"] = self.secondPwsTextField.text;
    param[@"code"] = self.codetEXTfIELD.text;
    param[@"phone"] = self.phoneNumTextField.text;
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    param[@"user_type"] = @1;
    [tool sendRequstWith:@"act=register&op=register_user2" params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self showRightWithTitle:@"注册成功" autoCloseTime:2];
        if ([self.delegate respondsToSelector:@selector(registSuccessDict:)]) {
            [self.delegate registSuccessDict:[param copy]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (IBAction)xieyiBtnClick:(id)sender {
    KRUserProtocolViewController *vc = [KRUserProtocolViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)getCodeBtnClick:(id)sender {
    //获取验证码
    [self.codetEXTfIELD becomeFirstResponder];
    typeof(self) weakSelf = self;
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=register&op=regist" params:@{@"phone":self.phoneNumTextField.text} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self showRightWithTitle:@"发送成功" autoCloseTime:1];
        weakSelf.getMessageBtn.enabled = NO;
        weakSelf.getMessageBtn.backgroundColor = [UIColor grayColor];
        weakSelf.timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countdown) userInfo:nil repeats:YES];
    }];
}

-(void)Countdown{
    code -- ;
    [self.getMessageBtn setTitle:[NSString stringWithFormat:@"%d",code] forState:UIControlStateDisabled];
    if (code == 0) {
        self.getMessageBtn.enabled = YES;
        [self.getMessageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        code = 60;
        [self.timer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
