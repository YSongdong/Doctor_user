//
//  BillViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BillViewController.h"
#import "BillTableCell.h"
#import "NSObject+YMUserInfo.h"
//#import "PersonViewModel.h"
@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataList ;



@end
//CellReuseIdentifier
//cellTitleIdentifier
@implementation BillViewController

- (void)dealloc {
  //  [_viewModel removeObserver:self forKeyPath:@"billLists"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单记录";
    [self setUp];
}

- (void)setUp {

    _tableView.sectionFooterHeight = 0.0001f ;
    }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *dic = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=demand" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            NSMutableArray *mutaArray  = [NSMutableArray array];
            [showdata enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                   NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj[@"zhangdan"]) {
                    [mutaArray addObject:obj];
                }
            }];
            self.dataList = mutaArray ;
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    [tableView tableViewDisplayWitMsg:@"获取不到数据"
               ifNecessaryForRowCount:[self.dataList count]];
    if ([self.dataList count] > 0) {
        return [self.dataList[section][@"zhangdan"] count] +1 ;
    }
    return 0 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BillTableCell *cell ;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellTitleIdentifier"];
    }
    else {
        NSArray *cellArray = self.dataList[indexPath.section][@"zhangdan"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellReuseIdentifier"];
        cell.model = cellArray[indexPath.row -1] ;
    }
    return cell ;
    
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
        
    return 40 ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        return 40 ;
    }
    return 64 ;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    
    BillTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sectionTitleIdentifier"];
    [cell setHeadSectionDic:self.dataList[section]];
    
    return cell ;
//    UIView *view = [UIView new];
//    view.bounds = CGRectMake(0, 0, WIDTH, 40);
//    UILabel *title = [UILabel new];
//    title.text = self.dataList[section][@"finnshed_time"];
//    title.font = [UIFont systemFontOfSize:14];
//    title.textColor = [UIColor darkTextColor];
//    [title sizeToFit];
//    
//    title.center = CGPointMake(20 + title.width/2, 40 /2);
//    UILabel *detail = [UILabel new];
//    detail.text = [NSString stringWithFormat:@"消费:%@",self.dataList[section][@"order_amoun"]];
//    detail.font = [UIFont systemFontOfSize:14];
//    detail.textColor = [UIColor darkTextColor];
//    [detail sizeToFit];    
//    detail.center = CGPointMake(WIDTH - 20 - detail.width/2, 40 /2);
//    [view addSubview:title];
//    [view addSubview:detail];
//    return nil;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    
//    if ([keyPath isEqualToString:@"billLists"]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_tableView reloadData];
//        });
//    }
//}
@end
