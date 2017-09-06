//
//  KRUserProtocolViewController.m
//  Dntrench
//
//  Created by kupurui on 16/10/31.
//  Copyright © 2016年 CoderDX. All rights reserved.
//

#import "KRUserProtocolViewController.h"
#import "KRMainNetTool.h"
//#import "MBProgressHUD+KR.h"
@interface KRUserProtocolViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation KRUserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    self.navigationItem.title = @"用户协议";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ys9958.com/api/index.php?act=demand&op=gvrp"]]];
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
