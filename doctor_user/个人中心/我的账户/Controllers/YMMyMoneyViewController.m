//
//  YMMyMoneyViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyMoneyViewController.h"
#import "YMZhangdanDetailTableViewCell.h"
#import "BankListViewController.h"
#import "BillViewController.h"
#import "WithDrawSureViewController.h"
#import "AccountManagerViewController.h"
@interface YMMyMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>
//余额
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allData;
@property (nonatomic, strong) NSDictionary *myData;
@end

@implementation YMMyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的账户";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.allData = [NSMutableArray array];
    [self loadData];
    
}
- (void)loadData {
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem  alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(didClickChangePayPass)];
    
    self.navigationItem.rightBarButtonItem = rightBtn ;
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=index" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        self.myData = [showdata copy];
        self.allData = [showdata[@"order"] copy];
        self.yueLabel.text = [NSString stringWithFormat:@"%.2lf",[showdata[@"money"][@"available_predeposit"] doubleValue]];
        [self.tableView reloadData];
    }];
}


- (void)didClickChangePayPass{
    
    UIViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"AccountManagerViewController"];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//退款
- (IBAction)tuikuanBtnClick:(UITapGestureRecognizer *)sender {
    WithDrawSureViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"withDrawSureView"];
    [self.navigationController pushViewController:vc animated:YES];
}
//银行卡
- (IBAction)yinhangkaBtnClick:(UITapGestureRecognizer *)sender {
    BankListViewController *vc = [[UIStoryboard storyboardWithName:@"Second" bundle:nil] instantiateViewControllerWithIdentifier:@"bankListIdentifier"];
    [self.navigationController pushViewController:vc animated:YES];
}
//账单记录
- (IBAction)zhangdanJilu:(UIButton *)sender {
    BillViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"bankView"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:self.allData.count];
    return self.allData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMZhangdanDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhangdanDetailCell"];
    [cell setDetailWithDic:self.allData[indexPath.row]];
    return cell;
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
