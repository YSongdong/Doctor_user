//
//  YMLoginAndRegisterViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMLoginAndRegisterViewController.h"
#import "YMForgetPasswordViewController.h"
#import "YMRegisterViewController.h"
#import "JPUSHService.h"
#import "NSObject+YMUserInfo.h"
#import "LoginBtn.h"

#import "KRWebViewController.h"
#import "YMGuidePageViewController.h"
#import "YMHomeViewController.h"

#import "KRAllViewController.h"

static NSString *const FirstEnterTheHomepage = @"FirstEnterTheHomepage";

static NSString *const inputadvertisingClick = @"inputadvertisingClick";

@interface YMLoginAndRegisterViewController ()<YMRegisterViewControllerDelegate>

//登录按钮距离下面的位置,监控键盘弹起事件
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBottom;

//用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFiled;
@property (weak, nonatomic) IBOutlet LoginBtn *vertiBtn;//验证码按钮
//密码输入框
@property (nonatomic,strong)UIButton *rightViewBtn ;
@property (nonatomic,assign)BOOL vertiLogin ;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) NSTimer *timer;

//保存密码按钮
//@property (weak, nonatomic) IBOutlet UIButton *savePwsBtn;

@end

@implementation YMLoginAndRegisterViewController
{
    bool isRemenber;
    
    int  code ;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self inputWebView];
    isRemenber = NO;
    code = 60;
    
    NSDictionary *dic = [[self readDic] objectForKey:@"remenberName"];
    self.userNameTextFiled.text = dic[@"username"];
    self.passwordTextField.text = dic[@"pws"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];

    [self setUp];
    
}
- (UIButton *)rightViewBtn {
    if (!_rightViewBtn) {
        _rightViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightViewBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _rightViewBtn.frame = CGRectMake(0, 0, 75, 25);
        [_rightViewBtn setTitleColor:[UIColor bluesColor] forState:UIControlStateNormal];
        _rightViewBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_rightViewBtn addTarget:self action:@selector(getVeritification_Event) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightViewBtn ;
}
//获取验证码
- (void)getVeritification_Event {

    typeof(self) weakSelf = self;
    [self.passwordTextField becomeFirstResponder];
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=register&op=entry"
                  params:@{@"phone":self.userNameTextFiled.text}
               withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self showRightWithTitle:@"发送成功" autoCloseTime:2];
        weakSelf.timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CountdownLogin) userInfo:nil repeats:YES];
    }];
}

-(void)CountdownLogin{
    code -- ;
    [self.rightViewBtn setTitle:[NSString stringWithFormat:@"%d",code] forState:UIControlStateNormal];
    if (code == 0) {
        self.rightViewBtn.enabled = YES;
        [self.rightViewBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        code = 60;
        [self.timer invalidate];
    }
}


- (IBAction)change_Event:(id)sender {
    
    
}

- (void)setUp{
    
    
        __weak typeof(self)weakSelf = self ;
        _vertiBtn.block = ^(BOOL selected) {
            //选中
            if (selected) {
                
                weakSelf.userNameTextFiled.text = nil ;
                weakSelf.userNameTextFiled.placeholder = @"手机号";
                weakSelf.passwordTextField.placeholder = @"验证码";
                weakSelf.passwordTextField.rightView = weakSelf.rightViewBtn;
                weakSelf.passwordTextField.rightViewMode = UITextFieldViewModeAlways ;
                weakSelf.passwordTextField.secureTextEntry = NO ;
                weakSelf.passwordTextField.keyboardType = UIKeyboardTypeNumberPad ;
                weakSelf.passwordTextField.text = nil ;
                weakSelf.vertiLogin = YES ;
            }
            else {
                weakSelf.userNameTextFiled.placeholder = @"账号";
                weakSelf.passwordTextField.placeholder = @"密码";
                weakSelf.vertiLogin =NO;
                weakSelf.passwordTextField.secureTextEntry = YES ;
                weakSelf.passwordTextField.keyboardType = UIKeyboardTypeDefault ;
                weakSelf.passwordTextField.text = nil ;
                weakSelf.passwordTextField.rightView = nil;
            }
        };
}

- (IBAction)inputEnd:(UITextField *)sender {
    
    //输入框点击完成按钮
    [self.view endEditing:YES];
}
- (IBAction)savePwsBtnClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    if (sender.selected) {
        //保存
        isRemenber = sender.selected;
    } else {
        //不保存
        isRemenber = sender.selected;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (IBAction)loginBtnClick:(id)sender {
    //登录
    [self.view endEditing:YES];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *type ;
    if (self.vertiLogin) {
        type = @"2";
    }else
    {
        type = @"1";
    }
    param[@"type"]= type ;
    param[@"seller_name"] = self.userNameTextFiled.text;
    param[@"password"] = self.passwordTextField.text;
    typeof(self) weakSelf = self;
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    param[@"user_type"] = @1;
    [tool sendRequstWith:@"act=login&op=login2" params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        NSLog(@"%@",showdata);
        [weakSelf showRightWithTitle:@"登录成功" autoCloseTime:2];
        [JPUSHService setTags:[NSSet setWithObject:showdata[@"member_id"]] aliasInbackground:nil];
        [weakSelf performSelector:@selector(push:) withObject:showdata afterDelay:1];
        
    }];
}
- (void)push:(id)showdata {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] setObject:[self deleteNull:showdata] forKey:@"userInfo"];
    NSMutableDictionary *mut = [NSMutableDictionary dictionary];
    mut[@"userInfo"] = [[self deleteNull:showdata] mutableCopy];
    mut[@"login"] = @"1";
    if (isRemenber) {
        mut[@"remenberName"] = @{@"username":self.userNameTextFiled.text,@"pws":self.passwordTextField.text};
        [[NSUserDefaults standardUserDefaults] setObject:@{@"username":self.userNameTextFiled.text,@"pws":self.passwordTextField.text} forKey:@"remenberName"];
    } else {
        if (mut[@"remenberName"]) {
            [mut removeObjectForKey:@"remenberName"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:@{@"username":@"",@"pws":@""} forKey:@"remenberName"];
    }
    [self whriteToFielWith:[mut copy]];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[YMUserInfo sharedYMUserInfo] setValuesForKeysWithDictionary:showdata];
     [self getRongyunToken];
    
    
    NSNotification *notifi =[NSNotification notificationWithName:@"kJPFNetworkDidLoginNotificationo" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notifi];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:FirstEnterTheHomepage]){
        NSNotification *notification =[NSNotification notificationWithName:@"longinSuccess" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }else{
        KRAllViewController *homeView = [[KRAllViewController alloc]init];
        self.view.window.rootViewController = homeView;
    }

}
//忘记密码按钮点击
- (IBAction)forgetBtnClick:(id)sender {
    YMForgetPasswordViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"forgetView"];
    [self.navigationController pushViewController:vc animated:YES];
}
//注册按钮点击
- (IBAction)registerBtnClick:(id)sender {
    YMRegisterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"registerView"];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void) registSuccessDict:(NSDictionary*)dict
{
    self.userNameTextFiled.text = dict[@"phone"];
    self.passwordTextField.text = dict[@"password"];
    //登录
    [self loginBtnClick:_loginBottom];

}


#pragma mark - 键盘事件

- (void)openKeyBoard:(NSNotification *)notification {
    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.loginBottom.constant = keyboardFrame.size.height;
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        
        [weakSelf.view layoutIfNeeded];
    } completion:nil];
}
- (void)closeKeyBoard:(NSNotification *)notification {
    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    self.loginBottom.constant = 60;
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        [weakSelf.view layoutIfNeeded];
    } completion:nil];
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

-(void)inputWebView{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:inputadvertisingClick]) {
        
        NSString *strUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"webUrl"];
        KRWebViewController *webVC = [[KRWebViewController alloc]init];
        webVC.saoceUrl = strUrl;
        [self.navigationController pushViewController:webVC animated:YES];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:inputadvertisingClick];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

//#pragma mark -
//-(void)GuidePageController:(YMGuidePageViewController *)GuidePageController IKnow:(BOOL)IKnow{
////    self.view.window.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
//}
//
//-(void)GuidePageController:(YMGuidePageViewController *)GuidePageController inputPerson:(BOOL)inputPerson{
////     self.view.window.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
//}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}

@end
