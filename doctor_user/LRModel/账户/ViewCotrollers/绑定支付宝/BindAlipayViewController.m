//
//  BindAlipayViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BindAlipayViewController.h"
//#import "PersonViewModel.h"

#define MEMBER_ID [YMUserInfo sharedYMUserInfo].member_id

@interface BindAlipayViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (nonatomic,strong)NSDictionary *params ;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

@implementation BindAlipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = myButton;
    self.title = @"绑定支付宝";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}
- (void)requestData {
    
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=cards_listz" params:@{@"member_id":MEMBER_ID} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            _nameTextField.text = showdata[@"mem_name"];
            _accountTextField.text = showdata[@"card_num"];
            _nameTextField.enabled = NO ;
            _accountTextField.enabled = NO ;
            self.params = showdata ;
            self.ways = 1;
        }
  }];
}
//点击下一步的时候
- (void)clickEvent{
    if (self.ways == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayNotification"
                                                               object:self.params userInfo:nil];
            [self returnBack];
        return ;
    }
    if ([_nameTextField.text isEqualToString:@""]) {
        [self.view showErrorWithTitle:@"请输入真实姓名" autoCloseTime:2];
        return ;
    }
    if ([_accountTextField.text isEqualToString:@""]) {
        [self.view showErrorWithTitle:@"请输入支付宝账号" autoCloseTime:2];
        return ;
    }
    [self showAlert];
}

//提示用户
- (void)showAlert {
    
    [self alertViewControllerShowWithTitle:@"支付宝账号一旦绑定将不可修改" message:nil sureTitle:@"确认" cancelTitle:@"取消" andHandleBlock:^(id value, NSString *error) {
        if (value) {
            [self bindAlipay];
        }
    }];
}
//绑定支付宝账号
- (void)bindAlipay {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (MEMBER_ID){
        [dic setObject:MEMBER_ID forKey:@"member_id"];
    }
    [dic setObject:_nameTextField.text forKey:@"memz_name"];
    [dic setObject:_accountTextField.text forKey:@"cardz_num"];
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=cardz" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            
            [self.view showRightWithTitle:@"支付宝绑定成功" autoCloseTime:3];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                         (int64_t)(3 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                               [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayNotification"
                                                                                  object:self.params userInfo:nil];
                               [self returnBack];
            
                           });
        }
        
    }];
}
- (void)returnBack {
    
    UIViewController *vc = self.navigationController.viewControllers[2];
    [self.navigationController popToViewController:vc animated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {

    [_nameTextField resignFirstResponder];
    [_accountTextField resignFirstResponder];
}
- (void)alertViewControllerShowWithTitle:(NSString *)title message:(NSString *)message sureTitle:(NSString *)sureTitle cancelTitle:(NSString *) cancelTitle andHandleBlock:(void(^)(id  value,NSString  *error))commplete {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        commplete(@(1),nil);
        
    }];
    [alertVC addAction:action];
    
    if (cancelTitle != nil) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            commplete(nil,@"0");
        }];
        [alertVC addAction:action1];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
    
}



@end
