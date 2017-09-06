//
//  ChangePassViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChangePassViewController.h"
#import "CommonTextField.h"
#import "UIButton+CommonButton.h"

#define YMColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define Global_mainBackgroundColor YMColor(248, 248, 248, 1)

#define WIDTH [UIScreen mainScreen].bounds.size.width  

@interface ChangePassViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)NSMutableArray *dataList ;
@property (nonatomic,strong)UIButton *vertificationBtn ; //获取验证码

@end

@implementation ChangePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithRGBHex:0xEAEAF4];    
}

- (void)viewWillLayoutSubviews {
    
    for (int i = 0; i < [_dataList count]; i ++) {
        CommonTextField *textField = (CommonTextField *)_dataList[i];
        textField.width = WIDTH ;
        textField.x = 0 ;
        if (i == 0) {
            _vertificationBtn.centerY = textField.centerY ;
            _vertificationBtn.centerX = WIDTH - 10 - _vertificationBtn.width/2 ;
        }
    }
}

- (void)setup{

    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = myButton;

    NSArray *titles = @[@"验证码",@"新密码",@"确认密码"];
    NSArray *placeHolders =@[@"发送验证码到您的手机",@"请输入新密码字符",@"确认密码"];
    _dataList = [NSMutableArray array];
    for (int i = 0; i < [titles count]; i ++) {
        CommonTextField *textField = [[CommonTextField alloc]initWithPosition_Y: 20  + (i * 60)  andHeight:50];
        [self.view addSubview:textField];
        textField.tag = 1000 + i;
        textField.title = titles[i];
        textField.placeHolder = placeHolders[i];
        textField.titleFont = [UIFont systemFontOfSize:16];
        textField.delegate = self ;
        [textField addLine];
        if (i == 1 || i == 2) {
            textField.secureTextEntry = YES ;
        }
        [_dataList addObject:textField];
    }
    _vertificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_vertificationBtn setTitleColor:[UIColor colorWithRGBHex:0x0091ff] forState:UIControlStateNormal];
    [_vertificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _vertificationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_vertificationBtn];
    [_vertificationBtn sizeToFit];
    [_vertificationBtn addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside ];
}

//完成
- (void)clickEvent{
    UITextField *vertiTextfield = [self.view viewWithTag:1000];
    UITextField *newpass = [self.view viewWithTag:1001];
    UITextField *surePass = [self.view viewWithTag:1002];
    
    if (vertiTextfield.text.length == 0) {
        [self.view showErrorWithTitle:@"请输入验证码" autoCloseTime:1];
        
        return ;
    }
    if (newpass.text.length < 6) {
        [self.view showErrorWithTitle:@"请输入至少6位密码" autoCloseTime:1];
        return ;
    }
    
    if (surePass.text.length == 0) {
        [self.view showErrorWithTitle:@"请输入确认密码" autoCloseTime:1];
        return ;
    }if (![surePass.text isEqualToString:newpass.text]) {
        [self.view showErrorWithTitle:@"两次密码不一致请重新输入" autoCloseTime:1];
        return ;
    }
    self.step = 2 ;

    
    NSString *url = @"act=doctor_page&op=forgetpas";
    NSDictionary *dic =@{};
    if (_type == changePayType) {
        url = @"act=users_account&op=account_zfmm";
        
        dic = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                @"code":vertiTextfield.text,
                @"member_paypwd":surePass.text};
    }else{
        dic = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                @"code":vertiTextfield.text,
                @"password":newpass.text,
                @"password_confirm":surePass.text};
    }
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:url params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            if (_type == changePayType) {
//                [self.view showRightWithTitle:@"修改支付密码成功" autoCloseTime:5];
                [self navBackAction];
                
            }else{
                [self.view showRightWithTitle:@"修改密码成功" autoCloseTime:2];
                 //重新登录
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
                    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
                    window.rootViewController = storyBoard.instantiateInitialViewController;
                });
            }
            
           
           

        }else {
            [self.view showErrorWithTitle:error autoCloseTime:2];
        }
    }];
}

//获取验证码
- (void)didClick {
    self.step = 1 ;
    [_vertificationBtn vertificationButtonClickedAnimationWithTimeStart:60 beginString:@"获取验证码" block:^{
    }];
    NSDictionary *dic = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
    
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=doctor_page&op=password_send"
     params:dic withModel:nil waitView:self.view
  complateHandle:^(id showdata, NSString *error) {
      if (!error) {
          [self.view showRightWithTitle:@"验证码发送成功" autoCloseTime:2];
      }else {
          [self.view showErrorWithTitle:error autoCloseTime:2];
      }

    }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES ;
}

#pragma mark -dismis
- (void)navBackAction
{
    UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
    if (ctrl == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
