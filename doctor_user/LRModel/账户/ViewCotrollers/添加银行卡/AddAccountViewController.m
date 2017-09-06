//
//  AddAccountViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AddAccountViewController.h"
#import "NSString+LK.h"

//#import "PersonViewModel.h"
@interface AddAccountViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *belongBankLabel; //所属银行
@property (nonatomic,strong)NSMutableDictionary *params ;


@end

@implementation AddAccountViewController


- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = myButton;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)clickEvent {
      if (!self.nameLabel.text ||[[self.nameLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {

          [self.view showErrorWithTitle:@"请输入持卡人姓名" autoCloseTime:2];
                return ;
            }
            if ([[self.cardNumberLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
                [self.view showErrorWithTitle:@"请输入银行卡卡号" autoCloseTime:2];
                return ;
            }
            if ([[self.belongBankLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
                [self.view showErrorWithTitle:@"请输入银行名称" autoCloseTime:2];

                return ;
            }
     [self.params setObject:_nameLabel.text forKey:@"mem_name"];
       [self.params setObject:_cardNumberLabel.text forKey:@"card_num"] ;
        [self.params setObject:_belongBankLabel.text forKey:@"name"];
    
        [self.params setObject:[YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
        [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=cards" params:self.params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
            [self performSegueWithIdentifier:@"addbankSucess" sender:nil];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self textFieldResign];
    
    return YES ;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
   
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    [self textFieldResign];
}


- (void)textFieldResign {
    
    
    if ([_nameLabel isFirstResponder]) {
        [_cardNumberLabel resignFirstResponder];
    }
    
    if ([_cardNumberLabel isFirstResponder]){
 
        [_cardNumberLabel resignFirstResponder];
    }
    if ([_belongBankLabel isFirstResponder]) {
        [_belongBankLabel resignFirstResponder];
  
    }
}
- (IBAction)click_showDoctor_protocal:(id)sender {
    
    
}


- (void)operateFailure:(NSString *)failureReason {
    
}

- (void)operateSuccess:(NSString *)successTitle {
    [self performSegueWithIdentifier:@"successIdentifier" sender:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"successIdentifier"]) {

//        segue.destinationViewController.title = @"添加银行卡";
    }
}

@end
