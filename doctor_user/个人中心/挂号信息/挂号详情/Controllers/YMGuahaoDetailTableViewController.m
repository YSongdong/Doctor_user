//
//  YMGuahaoDetailTableViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMGuahaoDetailTableViewController.h"
#import "YMLabelTableViewCell.h"

@interface YMGuahaoDetailTableViewController ()

@property (nonatomic, strong) NSDictionary *myData;

@end

@implementation YMGuahaoDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详细信息";
    self.tableView.backgroundColor = [UIColor colorWithRed:233.0/255 green:233.0/255 blue:243.0/255 alpha:1];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self loadData];
}

- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=doctor_page&op=registers" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,@"demand_id":self.guahaoID} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.myData = [showdata copy];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 2;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
        case 4:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.section == 0) {
            cell.textLabel.text = @"当前状态：";
            cell.detailTextLabel.text = self.myData[@"demand_ghstate"];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"姓名：";
                
                id str = self.myData[@"demand_name"];
                NSLog(@"%@",str);
                
                if ([str isEqual:[NSNull null]]) {
                    str = @"";
                }
                
                cell.detailTextLabel.text = str;
                cell.detailTextLabel.textColor = [UIColor blackColor];
            } else {
                cell.textLabel.text = @"身份证号：";
                cell.detailTextLabel.text = self.myData[@"demand_sid"];
                cell.detailTextLabel.textColor = [UIColor blackColor];
            }
        } else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"挂号医院：";
                cell.detailTextLabel.text = self.myData[@"occupation"];
                cell.detailTextLabel.textColor = [UIColor blackColor];
            } else {
                cell.textLabel.text = @"科室：";
                cell.detailTextLabel.text = self.myData[@"demand_aid"];
                cell.detailTextLabel.textColor = [UIColor blackColor];
            }
        } else if (indexPath.section == 3) {
            cell.textLabel.text = @"就诊时间";
            cell.detailTextLabel.text = self.myData[@"ht_time"];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }
        cell.selectionStyle = 0;
        
        return cell;
    } else {
        
        YMLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelCell"];
        [cell setDetailWith:self.myData[@"demand_sm"]];
        return cell;
    }
}

@end
