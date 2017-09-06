//
//  YMAddCradsViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAddCradsViewController.h"
#import "YMDoctorLibaryViewController.h"

@interface YMAddCradsViewController ()
//名字
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
//卡号
@property (weak, nonatomic) IBOutlet UITextField *cardsNumTextField;
//银行名字
@property (weak, nonatomic) IBOutlet UITextField *bankNameTextFierld;
@property (weak, nonatomic) IBOutlet UIImageView *selectProtocolImageView;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;

@property(nonatomic,assign) BOOL slectStatus;

@end

@implementation YMAddCradsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title = @"添加银行卡";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep)];
    _slectStatus = YES;
    [self addButtonUnderline];
}

-(void)addButtonUnderline{
    
    NSString *title= _protocolButton.titleLabel.text;
    NSMutableAttributedString *titleAttr = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange titleRange = {0,[titleAttr length]};
    [titleAttr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [_protocolButton setAttributedTitle:titleAttr
                                   forState:UIControlStateNormal];
    
}
- (void)nextStep {
    //下一步
    if ([NSString isEmpty:_nameTextField.text]) {
        [self.view showErrorWithTitle:@"请输入持卡人姓名" autoCloseTime:2];
    }
    
    if ([NSString isEmpty:_cardsNumTextField.text]) {
        [self.view showErrorWithTitle:@"请输入卡号" autoCloseTime:2];
    }
    
    if ([NSString isEmpty:_bankNameTextFierld.text]) {
        [self.view showErrorWithTitle:@"请输入所属银行" autoCloseTime:2];
    }
    NSDictionary *params = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                             @"mem_name":_nameTextField.text,
                             @"card_num":_cardsNumTextField.text,
                             @"name":_bankNameTextFierld.text};

    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=cards" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
      
        YMDoctorLibaryViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"SuccessViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)protocolClick:(id)sender {
    
}
- (IBAction)selctClick:(id)sender {
    _slectStatus = !_slectStatus;
    if (_slectStatus) {
        _selectProtocolImageView.image = [UIImage imageNamed:@"user_protocol_Yes_icon"];
    }else{
        _selectProtocolImageView.image = [UIImage imageNamed:@"user_protocol_No_icon"];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
