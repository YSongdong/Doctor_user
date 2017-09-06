//
//  YMOrderDetailViewController.m
//  doctor_user
//
//  Created by kupurui on 2017/2/10.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderDetailViewController.h"
#import "YMOrderProgressCell.h"
#import "YMDoctorCell.h"
#import "YMNextCell.h"
#import "DemandOrderTableViewCell.h"
#import "YMProgressViewController.h"
#import "YMAddMoneyViewController.h"
#import "TextInputView.h"
#import "MessageView.h"
#import "DemandContentViewController.h"
#import "ContractViewController.h"
#import "TalkingViewController.h"
#import "YMDoctorDetailViewController.h"
#import "MJRefresh.h"
#import "YMDoctorHomePageViewController.h"

@interface YMOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,TextInputViewDelegate,MessageViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic,strong)NSDictionary *demands ;
@property (nonatomic,strong)NSArray *doctors ;
@property (nonatomic,strong)NSArray *data ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonLayout;

@end

@implementation YMOrderDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 10 ;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];

    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData {
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=issue&op=details" params:self.params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error){
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        if (!error) {
            self.doctors = showdata[@"_order"];
                self.demands = showdata[@"_demand"];
            [self.tableView reloadData];
        }
    }];
}
- (IBAction)addMoneyBtn:(id)sender {
    
    YMAddMoneyViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"addMoney"];
    vc.params[@"pay_sn"] = self.demands[@"demand_bh"];
    vc.money = self.demands[@"price"];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}
- (void)setDemands:(NSDictionary *)demands {
    _demands = demands ;
    
    for (NSDictionary *dic in self.doctors) {
        if ([dic[@"demand_schedule"] integerValue] > 1) {
            self.bottonLayout.constant = 45 ;
            self.leftBtn.hidden = NO ;
            self.rightBtn.hidden = NO ;
            [self.view setNeedsLayout];
            return ;
        }
    }
}

- (IBAction)closeOrder:(id)sender {
    
    TextInputView *view = [TextInputView textViewLoadFromXibWithTitleString:@"关闭订单"];
    [view setPlaceHolderText:@"请输入关闭订单原因"];
    [view inputViewShow];
    view.delegate = self ;
}
//用户关闭订单
- (void)didClickSureBtn:(NSString *)content {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (content) {
        dic[@"resson"] = content ;
    }
    if (self.demands[@"demand_id"]) {
        dic[@"demand_id"] = self.demands[@"demand_id"]  ;
    }
    if ([YMUserInfo sharedYMUserInfo].member_id) {
         dic[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id ;
    }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=issue&op=step2" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            [self.view showRightWithTitle:@"关闭订单成功" autoCloseTime:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.doctors count] + 3 ;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [NSString stringWithFormat:@"订单编号: %@",self.demands[@"demand_bh"]];
    }
    return nil ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        DemandOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCellIdentifeir"];
        cell.model = self.demands ;
        return cell ;
    }
    if (indexPath.section == 1) {
        YMOrderProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"progressCell"];
        cell.dic = [self.demands copy];
        return cell ;
    }
    if (indexPath.section == 2) {
        YMNextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demandNextCell"];
        return cell ;
    }
    if (indexPath.section >= 3) {
        YMDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doctorCell"];
        cell.dic = self.doctors[indexPath.section - 3];
        cell.contactBlock = ^(id value){
            MessageView *messageView = [MessageView messageWithXib];
        //[messageView setPhone:value[@"live_store_tel"]];
            messageView.dic = value;
            messageView.delegate = self ;
            [messageView messageShow];
        };
        cell.secondBtnBlock = ^(id value,NSInteger status){
            switch (status) {
                    //选标
                case 2:{
                    [self choiceDoctorWithTitle:@"是否确认投标该医生" andObjectID:value[@"store_id"]];
                }break;
                    //催促合同
                    case 3:{
                        NSDictionary *dic = @{@"store_id":value[@"store_id"],
                                              @"demand_id":self.demands[@"demand_id"]};
                        [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=issue&op=step4" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                            if (!error) {
                                [self.view showRightWithTitle:@"通知发送成功" autoCloseTime:2];
                            }
                        }];
                    }break;
                    //签订合同
                case 4:{
                    ContractViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"ContractViewController"];
                    vc.demand_id = [self.demands[@"demand_id"] copy];
                    vc.title = @"签订合同";
                    [self.navigationController pushViewController:vc animated:YES];
                }break;
                    //查看合同
                case 5:{
                    ContractViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"ContractViewController"];
                    vc.demand_id = [self.demands[@"demand_id"] copy];
                    vc.title = @"查看合同";
                    [self.navigationController pushViewController:vc animated:YES];
                }break;
                case 6:{
                    ContractViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"ContractViewController"];
                    vc.demand_id = [self.demands[@"demand_id"] copy];
                    vc.title = @"查看合同";
                    [self.navigationController pushViewController:vc animated:YES];
                }break;
                                    default:
                    break;
            }
        };
        cell.thirdBtnClickBlock = ^(id value) {
          
            [self performSegueWithIdentifier:@"progressview"
                                      sender:value];
        };
        
        cell.headBtnBlock = ^(id value) {
//            YMDoctorDetailViewController *vc = [MAIN_STORBOARD instantiateViewControllerWithIdentifier:@"doctorView"];
//            vc.doctorID = value[@"store_id"];
//            vc.fromVC = @"1";
//            [self.navigationController pushViewController:vc animated:YES];
            
            YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
            
            vc.doctorID = value[@"store_id"];
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell ;
    
    }
    return nil ;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section ==  0) {
        return 30 ;
    }
    return 0.0001 ;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 2) {
        DemandContentViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"contentView"];
        vc.demand_id = self.demands[@"demand_id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    if (indexPath.section > 2) {
//        [self performSegueWithIdentifier:@"progressview"
//                                  sender:self.doctors[indexPath.section - 3]];
//    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"progressview"]) {
        
        YMProgressViewController *vc = segue.destinationViewController ;
        vc.doctors = sender ;
        vc.demand_id = self.demands[@"demand_id"];
    }
    
}
//确认选标
-(void)choiceDoctorWithTitle:(NSString *)title
                 andObjectID:(NSString *)ojc_id{
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title
                                                                        message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        
        if (self.demands[@"demand_id"]) {
            dic[@"demand_id"] = self.demands[@"demand_id"] ;
        }
        if ([YMUserInfo sharedYMUserInfo].member_id) {
            dic[@"store_id"] = ojc_id;
        }
        KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
        tool.isShow = @"2";
        
        [tool sendRequstWith:@"act=issue&op=step_tb2" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            if (!error) {
                [self.view showRightWithTitle:@"选标成功" autoCloseTime:2];
                
                [self requestData];
            }
        }];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    [controller addAction:action1];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

//消息
- (void)callNumber:(NSString *)number {
    
    if (!number) {
       // [self.view showErrorWithTitle:@"未能获取到电话号码" autoCloseTime:2];
        [self.view showErrorWithTitle:@"医生的电话号码暂时保密" autoCloseTime:2];
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
