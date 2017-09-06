//
//  YMGuahaoInfoViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMGuahaoInfoViewController.h"
#import "YMGuahaoInfoTableViewCell.h"
#import "ZKSegment.h"
#import "YMGuahaoDetailTableViewController.h"

@interface YMGuahaoInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allData;
@property (nonatomic, strong) ZKSegment *zkSegment;
@property (nonatomic, strong) NSString *type; //1为未完成   2已完成

@end

@implementation YMGuahaoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"挂号信息";
    [self setHeadViewsWithDic:nil];
  
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:self.allData.count];
    return self.allData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YMGuahaoInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"guaHaoCell"];
    cell.type = self.type;
    [cell setDetailWithDic:self.allData[indexPath.row]];
    
    return cell;
}

- (void)setHeadViewsWithDic:(NSDictionary *)dic {
    if (self.zkSegment) {
        return;
    }
    self.zkSegment = [ZKSegment
                      zk_segmentWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)
                      style:0];
    //self.zkSegment.center = self.switchView.center;
    // 可手动设置各种颜色；
    // 如不设置则使用默认颜色
    self.zkSegment.zk_itemDefaultColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.zkSegment.zk_itemStyleSelectedColor = [UIColor colorWithRed:66.0 / 255.0 green:126 / 255.0 blue:214 / 255.0 alpha:1];
    self.zkSegment.zk_backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    typeof(self) weakSelf = self;
    self.zkSegment.zk_itemClickBlock = ^(NSString *itemName, NSInteger itemIndex) {
        
        [weakSelf selectAtIndexWith:itemIndex];
    };
    NSString *all = [NSString stringWithFormat:@"进行中"];
    NSString *image = [NSString stringWithFormat:@"已完成"];
    NSArray *mutArray = @[all,image] ;
    [self.zkSegment zk_setItems:mutArray];
    [self.btnView addSubview:self.zkSegment];
}

- (void)selectAtIndexWith:(NSInteger)index {
    //self.orderType = index;
    self.type = [NSString stringWithFormat:@"%ld",index + 1];
    [self loadData];
    
}

- (void)loadData {
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=doctor_page&op=register" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,@"type":self.type} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (showdata == nil) {
            return ;
        }
        self.allData = [showdata mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.allData[indexPath.row];
    
    YMGuahaoDetailTableViewController *vc = [MAIN_STORBOARD instantiateViewControllerWithIdentifier:@"guahaodetailView"];
    
    vc.guahaoID = [NSString stringWithFormat:@"%@",dic[@"demand_id"]];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
