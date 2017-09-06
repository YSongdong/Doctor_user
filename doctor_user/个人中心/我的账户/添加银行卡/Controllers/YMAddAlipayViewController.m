//
//  YMAddAlipayViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAddAlipayViewController.h"
#import "YMDoctorLibaryViewController.h"

@interface YMAddAlipayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *userProtocolButton;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *userAlipayAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *userAlipayNick;

@property(nonatomic,assign) BOOL slectStatus;

@end

@implementation YMAddAlipayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加支付宝";
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep)];

    _slectStatus = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextStep {
    //下一步
    if ([NSString isEmpty:_userNameTextField.text]) {
        [self.view showErrorWithTitle:@"请输入姓名" autoCloseTime:2];
        return;
    }
    
    if ([NSString isEmpty:_userAlipayAccountTextField.text]) {
        [self.view showErrorWithTitle:@"请输入支付宝帐号" autoCloseTime:2];
        return;
    }
    
    NSDictionary *params = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                             @"memz_name":_userNameTextField.text,
                             @"cardz_num":_userAlipayAccountTextField.text};
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=cardz" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        YMDoctorLibaryViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"SuccessViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (IBAction)sellectClick:(id)sender {
    _slectStatus = !_slectStatus;
    if (_slectStatus) {
        _selectImageView.image = [UIImage imageNamed:@"user_protocol_Yes_icon"];
    }else{
        _selectImageView.image = [UIImage imageNamed:@"user_protocol_No_icon"];
    }
}
- (IBAction)userProtocolClick:(id)sender {
    
    
}


@end
