//
//  DemandOrderViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandOrderViewController.h"
#import "DemandOrderTableViewCell.h"
#import "OrderHeadView.h"
#import "MJRefresh.h"
#import "YMOrderDetailViewController.h"
#import "YMOrderDetailViewController.h"
//#import "DemandOrderDetailViewController.h"
#import "YMPayView.h"

@interface DemandOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderHeadViewDelegate>
@property (weak, nonatomic) IBOutlet OrderHeadView *headOrderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DemandOrderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        self.title = @"需求订单";
    }else {
        self.title = @"疑难杂症订单";
    }
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self setUp];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES ;
    [self.tableView.header beginRefreshing];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

//刷新
- (void)refreshData {
   self.page = 1;
    [self requestDataWithUrl];
}

//加载
- (void)loadMoreData {
    self.page += 1 ;
    [self requestDataWithUrl];
}
- (void)setUp {
    _selectedIndex = 0;
    _tableView.sectionFooterHeight = 10 ;
    [_headOrderView setTitles:@[@"进行中",@"已完成",@"已失效",@"未托管酬金"]];
    _headOrderView.selectedIndex = 0 ;
    _headOrderView.delegate = self ;    
       self.selectedIndex = _headOrderView.selectedIndex ;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.tableView.footer = footer ;
}


- (void)requestDataWithUrl {
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        if ( [YMUserInfo sharedYMUserInfo].member_id) {
//       [dic setObject: [YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
//    }
    
    NSDictionary *dic = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                          @"screen":@(self.selectedIndex + 1),
                          @"curpage":@(self.page),
                          @"classify":@(self.type)};
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=issue&op=index" params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        
        if (self.page == 1) {
            self.dataList = showdata[@"_order"];
        }
        else {
            
            NSMutableArray *array = [self.dataList mutableCopy];
            [array addObjectsFromArray:showdata[@"_order"]];
            self.dataList = array ;
        }
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        [self.tableView reloadData];
    }];
}

- (void)selectedIndexChangeRequest {
    
    _selectedIndex = _headOrderView.selectedIndex ;
    [self.tableView.header beginRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    [tableView tableViewDisplayWitMsg:@"暂时没有订单" ifNecessaryForRowCount:[_dataList count]];
    return [self.dataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DemandOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCellIdentifeir"];
    cell.model = self.dataList[indexPath.section];
    return cell ;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10 ;
    }
    return 0.0001f ;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.dataList[indexPath.section];
    
    if (_selectedIndex+1==4) {
        
        NSString *order_id =[NSString isEmpty:dic[@"demand_id"]]?@"":dic[@"demand_id"];
        NSString *order_amount = [NSString isEmpty:dic[@"order_amount"]]?@"":dic[@"order_amount"];
        
        NSDictionary *payDic = @{@"order_list":@{@"pay_sn":order_id,
                                                 @"order_amount":order_amount}};
        
        YMPayView *payView = [[[NSBundle mainBundle]loadNibNamed:@"YMPayView" owner:self options:nil]firstObject];
        payView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        payView.block = ^(long long staus) {
            YMOrderDetailViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"orderDetailView"];
            vc.params = @{@"demand_id":@(staus),@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
            [self.navigationController pushViewController:vc animated:YES];
        };
        payView.superVC = self;
        [payView setDetailMoneyWith:dic[@"order_amount"] andData:payDic];
        [self.view.window addSubview:payView];
        [payView setAnimaltion];
    }else{
        [self performSegueWithIdentifier:@"pushDetailOrder" sender:[dic copy]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    YMOrderDetailViewController *progress = segue.destinationViewController ;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([YMUserInfo sharedYMUserInfo].member_id) {
        [dic setObject:[YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
    }
    if (sender[@"demand_id"]) {
        [dic setObject:sender[@"demand_id"] forKey:@"demand_id"];
    }
    progress.params = [dic mutableCopy] ;
}

- (void)requestDataFailureWithReason:(NSString *)failure {
    
   
   // [self alertViewShow:failure];
}
@end
