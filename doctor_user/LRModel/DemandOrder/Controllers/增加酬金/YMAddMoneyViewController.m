//
//  YMAddMoneyViewController.m
//  doctor_user
//
//  Created by kupurui on 2017/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAddMoneyViewController.h"
#import "YMSwitchTableViewCell.h"
#import "YMPayView.h"
@interface YMAddMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation YMAddMoneyViewController


- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}

- (void)viewDidAppear:(BOOL)animated {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"YMSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.sectionHeaderHeight = 15 ;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"当前酬金:";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  ¥",self
                                     .money];
        return cell ;
    }
    else {
        YMSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell setDetailWithDic:@{@"lefttop":@"增加酬金:",
                                 @"leftbottom":@"注:提高酬金，可以极大的增加服务商接单率",
                                 @"status":@"1"} andDataDic:nil];
        cell.block = ^(BOOL isSwitch,NSString *str){
            self.params[@"remuneration"] =str ;
        };
        return cell ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 15 ;
    }
    return 0.001 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 ;
}
- (IBAction)btnClicked:(id)sender {
    
    //提交
    self.params[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id ;
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=issue&op=remuneration" params:self.params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        NSLog(@"%@",showdata);
        YMPayView *payView = [[[NSBundle mainBundle]loadNibNamed:@"YMPayView" owner:self options:nil]firstObject];
        payView.block = ^(long long statu) {
            [self.navigationController popViewControllerAnimated:YES];
        };
        payView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [payView setDetailMoneyWith:showdata[@"_order_list"][@"order_amount"] andData:showdata];
        [self.view.window addSubview:payView];
        
    }];
    
    
}
@end
