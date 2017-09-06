//
//  YMHelperCenterDetailViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHelperCenterDetailViewController.h"

@interface YMHelperCenterDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation YMHelperCenterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createWebView];
    [self requrtData];
    
}


-(void)createWebView{
    _webView = [[UIWebView alloc]init];
    _webView.scrollView.backgroundColor = self.view.backgroundColor;
    _webView.opaque = NO;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.top.bottom.equalTo(self.view);
    }];
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=helpContent" params:@{@"article_id":self.article_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            
            weakSelf.title =showdata[@"title"];
            [weakSelf.webView loadHTMLString:showdata[@"content"] baseURL:nil];
        }
        
    }];
}


@end
