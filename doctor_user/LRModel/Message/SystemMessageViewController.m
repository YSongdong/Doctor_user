//
//  SystemMessageViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/7.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "SystemMessageViewController.h"
#import "SystemMessageCellTableViewCell.h"
#import "MJRefresh.h"

@interface SystemMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataList ;
@property (nonatomic,assign)NSInteger page ;

@end

@implementation SystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate  = self ;
    _tableView.dataSource = self ;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    self.title = @"系统消息";
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.tableView.footer = footer ;
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES ;
    self.page = 1 ;
    [self requestData];
}

- (void)requestData {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([YMUserInfo sharedYMUserInfo].member_id) {
        dic[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id ;
    }
     dic[@"curpage"] = @(self.page);
        [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=message&op=messages"  params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            
            if (!error) {
                self.dataList = showdata[@"_message"];
                
                NSLog(@"%@",self.dataList);
                [self.tableView reloadData];
            }
    }];
}
- (void)refreshData {
    self.page = 1 ;
}
- (void)loadMoreData {
    self.page += 1;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMessageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"systemeMessageTableViewCellIdentifier"];
    cell.model = self.dataList[indexPath.row];
    
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [SystemMessageCellTableViewCell calcuteHeihtWithWIthModel:self.dataList[indexPath.row]];
    
}

@end
