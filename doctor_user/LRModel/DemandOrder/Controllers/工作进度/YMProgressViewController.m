//
//  YMProgressViewController.m
//  doctor_user
//
//  Created by kupurui on 2017/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMProgressViewController.h"
#import "YMDoctorCell.h"
#import "DemandProgressTableViewCell.h"
#import "MessageView.h"
#import "YMAddMoneyViewController.h"
#import "ContractViewController.h"
#import "TextInputView.h"
#import "EvaluateViewController.h"
#import "TAEvaluateViewController.h"
#import "YMDoctorDetailViewController.h"
#import "TalkingViewController.h"
#import "MJRefresh.h"

#import "YMDoctorHomePageViewController.h"

@interface YMProgressViewController ()<UITableViewDelegate,UITableViewDataSource,DemandProgressTableViewCellDelegate,TextInputViewDelegate,MessageViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSDictionary *dataList ;
@property (nonatomic,strong)NSArray *data ;



@end

@implementation YMProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 0.0001 ;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
        [self setUp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    
}
- (void)loadData {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.demand_id) {
        dic[@"demand_id"] = self.demand_id ;
    }
    if (self.doctors[@"store_id"]) {
        dic[@"store_id"] = self.doctors[@"store_id"];
    }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=issue&op=schedule"
                                                params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                                                    if ([self.tableView.header isRefreshing]) {
                                                        [self.tableView.header endRefreshing];
                                                    }
                                                    if (!error) {
                                                        self.dataList = showdata[@"_order"];
                                                        [self.tableView reloadData];
                                                    }
                                                }];
}
- (void)getListData {
    
    NSArray *array = @[@"报名投标",@"洽谈需求",@"签订合同 开始工作",@"完成工作 确认付款",@"订单完成 双方互评"];
    NSArray *contentArray = @[@"医生投标参与了您的需求",@"洽谈成功 ，您可以选TA签单位你服务",@"签单成功，等待发起合同",@"医生完成工作，申请付款，如有异议申请医盟仲裁，如有异议申请鸣医仲裁。",@"订单完成，双方互评"];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i = 0; i < [contentArray count]; i ++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:contentArray[i] forKey:@"content"];
        [dic setObject:array[i] forKey:@"title"];
        [dic setObject:[NSString stringWithFormat:@"%d",i+1] forKey:@"step"];
        [mutArray addObject:dic];
    }
    self.data = [mutArray mutableCopy];
    [_tableView reloadData];
}

- (void)setUp {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self getListData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (section ==  0) {
        return 1 ;
    }
    return 5 ;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        YMDoctorCell *doctorCell = [tableView dequeueReusableCellWithIdentifier:@"doctorCell"];
        doctorCell.dic = self.dataList ;
        return doctorCell ;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        DemandProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgressIdentifier"];
        cell.dataList = self.data[indexPath.row];
        cell.model = self.dataList ;
        cell.delegate = self ;
        return cell ;
    }
    if (indexPath.section == 1 && indexPath.row > 0) {
        DemandProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgressIdentifierWithButton"];
        cell.dataList = self.data[indexPath.row];
        cell.model = self.dataList ;
        cell.delegate = self;        
        return cell ;
    }
    return nil ;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1 ;
    }
    if (section == 1) {
        return 15 ;
    }
    return 0.0001 ;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
        
        vc.doctorID = self.dataList[@"store_id"];
        [self.navigationController pushViewController:vc animated:YES];
        
//        YMDoctorDetailViewController *vc = [MAIN_STORBOARD instantiateViewControllerWithIdentifier:@"doctorView"];
//        vc.doctorID = self.dataList[@"store_id"];
//        vc.fromVC = @"1";
//        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)didClickWithDifferentType:(OperateType)type {
    switch (type) {
        case operateUnknow:{}break ;
        case operateContact:{
            MessageView *message = [MessageView messageWithXib];
            message.delegate = self ;
            [message setPhone:self.dataList[@"live_store_tel"]];
            message.dic = self.dataList ;
            [message messageShow];
            
        }break;
            //选他签标
        case operateChoice:{
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"demand_id"] = self.demand_id ;
            if (self.dataList[@"store_id"]) {
                dic[@"store_id"] = self.dataList[@"store_id"];
            }
            KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
            tool.isShow = @"2";
            [tool sendRequstWith:@"act=issue&op=step_tb2" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                if (!error) {
                    [self.view showRightWithTitle:@"选标成功" autoCloseTime:2];
                    [self performSelector:@selector(loadData) withObject:nil afterDelay:2];
                }
            }];
        }break ;
            //增加酬金
        case operateAddMoney:{
            YMAddMoneyViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"addMoney"];
        vc.params[@"pay_sn"] = self.dataList[@"demand_bh"];
            //money 没有
            vc.money = self.dataList[@"price"];
            [self.navigationController pushViewController:vc animated:YES];
        }break ;
            //签订合同
        case operateContract:{
            
            ContractViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"ContractViewController"];
            vc.demand_id = [self.demand_id copy];
            vc.title = @"签订合同";
            [self.navigationController pushViewController:vc animated:YES];
            
        }break ;
            //通知开始工作
        case operateNotifyWork:{
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (self.demand_id) {
                dic[@"demand_id"]= self.demand_id ;
            }
            if (self.dataList[@"store_id"]) {
                dic[@"store_id"] = self.dataList[@"store_id"];
            }
            KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
            tool.isShow = @"2";
            [tool sendRequstWith:@"act=issue&op=step5" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                if (!error) {
                    [self.view showRightWithTitle:@"通知已发送成功" autoCloseTime:2];
                }
            }];
        }break ;
            //确认付款
        case operateSurePay:{
            [self surePay];
        }break ;
            //申请仲裁
        case operateArbitration:{
            TextInputView *textView = [TextInputView textViewLoadFromXibWithTitleString:@"申请仲裁"];
            textView.delegate = self ;
            [textView  inputViewShow];
        }break ;
            //评价
        case operateEvaluate:{
            
            if ([self.dataList[@"order_isEvaluate"]integerValue] == 1) {
                TAEvaluateViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"TAEvaluateViewControlellerIdentifier"];
                vc.order_id = self.dataList[@"order_id"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                
                EvaluateViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"EvaluateViewController"];
                vc.order_id = self.dataList[@"order_id"];
                vc.store_id = self.dataList[@"store_id"];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }break ;
            //查看评价
        case operateShowEvaluate:{
            TAEvaluateViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"TAEvaluateViewControlellerIdentifier"];
            vc.order_id = self.dataList[@"order_id"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }break ;
        default:
            break;
    }
}
//申请仲裁
- (void)didClickSureBtn:(NSString *)content {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (content) {
        dic[@"arbitration"] = content ;
    }
    if (self.demand_id) {
        dic[@"demand_id"] = self.demand_id ;
    }
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=issue&op=step7" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            [self.view showRightWithTitle:@"你的申请已提交成功" autoCloseTime:2];
            [self performSelector:@selector(loadData) withObject:nil afterDelay:2];
            //[self loadData];
        }
    }];
}

//确认付款
-(void)surePay {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"是否确认付款" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.demand_id) {
            dic[@"demand_id"] = self.demand_id ;
        }
        if ([YMUserInfo sharedYMUserInfo].member_id) {
            dic[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id;
        }
        KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
        tool.isShow = @"2";
        
        NSString *url  ;
        if ([self.dataList[@"order_qb"] integerValue] == 3) {
            url = @"act=release_diseases&op=real_diseases6";
        }else {
            url = @"act=issue&op=step6";
        }
        [tool sendRequstWith:url params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            if (!error) {
                [self.view showRightWithTitle:@"确认付款申请成功" autoCloseTime:2];
                [self performSelector:@selector(loadData) withObject:nil afterDelay:2];
            }
            
            
        }];
    }];

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    [controller addAction:action1];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

#pragma mark---MessageDelegate
// call
- (void)callNumber:(NSString *)number {
    
    if (!number) {
        [self.view showErrorWithTitle:@"未能获取到电话号码" autoCloseTime:2];
    return ;
    }
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]options:nil completionHandler:nil];
}
- (void)sendMessageOperator:(id)value {
    
    TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:value[@"ry_id"]];
    vc.title = value[@"member_names"];
    vc.portraint = value[@"store_avatar"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
