//
//  YMUserInfoTableViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMUserInfoTableViewController.h"
#import "YMuSERiNFOTableViewCell.h"
#import "NSObject+YMUserInfo.h"

@interface YMUserInfoTableViewController ()
@property (nonatomic, strong) NSMutableDictionary *myData;
@property (nonatomic, assign) BOOL canEdit;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *iDNumberLabel;

@end

@implementation YMUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canEdit = NO;
    if ([self.vcType isEqualToString:@"1"]) {
        self.navigationItem.title = @"基本资料";
    } else {
        self.navigationItem.title = @"隐私信息";
    }
    
    self.myData = [NSMutableDictionary dictionary];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(repareInfo)];
    self.tableView.tableFooterView = [UIView new];
    [self loadData];
}
- (void)loadData {
    NSString *path = nil;
    if ([self.vcType isEqualToString:@"1"]) {
        path = @"act=users_personal&op=indexs";
    } else {
        path = @"act=users_personal&op=privates";
    }
//  NSString * path = @"act=users_personal&op=privates";
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:path params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.myData = [showdata mutableCopy];
        if (![self.vcType isEqualToString:@"1"]) {
            self.myData[@"member_names"] = self.myData[@"member_truename"];
        }
        
        [self.tableView reloadData];
    }];
}

- (void)repareInfo {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
    self.canEdit = YES;
    [self.tableView reloadData];
}

- (void)finish {
    
    __weak __typeof(self)weakSelf = self;
    
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    NSString *path = nil;
    if ([self.vcType isEqualToString:@"1"]) {
        path = @"act=users_personal&op=index";
    } else
    {
        path = @"act=users_personal&op=private";
        
        if (self.block) {
            self.block(weakSelf.myData[@"member_names"], weakSelf.myData[@"member_number"]);
        }
    }
    [tool sendRequstWith:path params:self.myData withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
                
        [self showRightWithTitle:@"修改成功" autoCloseTime:2];
        //[self getRongyunToken];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(repareInfo)];
        
        [self loadData];
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([self.vcType isEqualToString:@"1"]) {
        return 2;
    } else {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.vcType isEqualToString:@"1"]) {
        return 2;
    } else {
        if (section == 2) {
            return 1;
        } else {
            return 2;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMuSERiNFOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
    cell.canEdit = self.canEdit;
    cell.vcType = self.vcType;
    cell.block = ^(NSIndexPath *indexPath,NSString *info) {
        if ([self.vcType isEqualToString:@"1"]) {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    self.myData[@"member_name"] = info;
                } else {
                    
                }
            } else {
                if (indexPath.row == 0) {
                    self.myData[@"member_areainfo"] = info;
                } else {
                    self.myData[@"member_occupation"] = info;
                }
            }
        } else {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    self.myData[@"member_names"] = info;
                } else {
                    self.myData[@"member_number"] = info;
                }
            } else if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    self.myData[@"member_phone"] = info;
                } else {
                    self.myData[@"member_email"] = info;
                }
            } else {
                self.myData[@"member_address"] = info;
            }
        }
        
    };
    [cell setDetailWithIndexpath:indexPath andDic:self.myData];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.vcType isEqualToString:@"1"]) {
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                if (self.canEdit) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择性别" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //退出登录
                        self.myData[@"member_sex"] = @"1";
                        [self.tableView reloadData];
                    }];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //退出登录
                        self.myData[@"member_sex"] = @"2";
                        [self.tableView reloadData];
                    }];
                    [alert addAction:action];
                    [alert addAction:action1];
                    [self.navigationController presentViewController:alert animated:YES completion:nil];
                }
                
            }
        }
    }
    
}


@end
