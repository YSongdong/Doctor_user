//
//  ChangePayPassViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChangePayPassViewController.h"

@interface ChangePayPassViewController ()

@end

@implementation ChangePayPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付密码修改";
}

- (void)rightButtonClickOperation {
    
    UITextField *vertiTextfield = [self.view viewWithTag:1000];
    UITextField *newpass = [self.view viewWithTag:1001];
    UITextField *surePass = [self.view viewWithTag:1002];
    if (vertiTextfield.text.length == 0) {
        
        [self.view showErrorWithTitle:@"请输入验证码" autoCloseTime:2];
        return ;
    }
    if (newpass.text.length < 6) {
        [self.view showErrorWithTitle:@"请输入至少6位密码" autoCloseTime:2];
        return ;
    }
    if (surePass.text.length == 0) {
        [self.view showErrorWithTitle:@"请输入确认密码" autoCloseTime:2];
        return ;
    }if (![surePass.text isEqualToString:newpass.text]) {
        [self.view showErrorWithTitle:@"两次密码不一致请重新输入" autoCloseTime:2];
        return ;
    }
    self.step = 2 ;
    NSDictionary *dic = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                          @"code":vertiTextfield.text,
                          @"member_paypwd":newpass.text};    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=account_zfmm" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            
            //修改秘密成功
            if (self.step == 2) {
                [self.view showRightWithTitle:@"登录密码修改成" autoCloseTime:2];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController popViewControllerAnimated:YES];
                
                //重新登录
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
                    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
                    window.rootViewController = storyBoard.instantiateInitialViewController;
                
                });
            }
           
        }else{
            
            [self.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];
}
@end
