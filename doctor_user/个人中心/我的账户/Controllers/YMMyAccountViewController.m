//
//  YMMyAccountViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyAccountViewController.h"
#import "YMSelfHomeTableViewCell.h"
#import "YMAccountTopTableViewCell.h"
#import "YMAccountInformationTableViewCell.h"
#import "WithDrawSureViewController.h"
#import "BankListViewController.h"
#import "BillViewController.h"

#import "YMMYBackCardViewController.h"
#import "YMRefundsViewController.h"

#import "YMMyAccountModel.h"

#import "YMBillRecordInfoViewController.h"

static NSString *const selfHomeCell = @"selfHomeCell";
static NSString *const accountTopCell = @"accountTopCell";
static NSString *const accountInformationCell =@"accountInformationCell";

@interface YMMyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *balanceNumberLabel;

@property(nonatomic,strong)UITableView *accountTableView;

@property(nonatomic,strong)YMMyAccountModel *model;

@end

@implementation YMMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =RGBCOLOR(245, 245, 245);
    self.title = @"我的帐户";
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requrtData];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)initView{
    [self initHeaderView];
    [self initTableView];
}
-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=index" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSDictionary class]]||[showdata isKindOfClass:[NSMutableDictionary class]]) {
            weakSelf.model = [YMMyAccountModel modelWithJSON:showdata];
            [weakSelf refreshData];
        }
    }];
}

-(void)initHeaderView{
    _headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 174)];
    _headerView.backgroundColor = [UIColor colorWithHexString:@"#3d85cc"];
    
    UILabel *balanceLabel =[[UILabel alloc]init];
    balanceLabel.text = @"余额";
    balanceLabel.textColor = [UIColor whiteColor];
    balanceLabel.font = [UIFont systemFontOfSize:17];
    [_headerView addSubview:balanceLabel];
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView.mas_centerX);
        make.top.equalTo(_headerView.mas_top).offset(10);
    }];
    
    _balanceNumberLabel  =[[UILabel alloc]init];
//    _balanceNumberLabel.text = @"¥200.00";
    _balanceNumberLabel.textColor = balanceLabel.textColor;
    _balanceNumberLabel.font = [UIFont systemFontOfSize:40];
    [_headerView addSubview:_balanceNumberLabel];
    [_balanceNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView.mas_centerX);
        make.top.equalTo(balanceLabel.mas_bottom).offset(20);
    }];
    
    UIButton *refundsButton =[[UIButton alloc]init];
    refundsButton.backgroundColor =balanceLabel.textColor ;
    refundsButton.titleLabel.font = balanceLabel.font;
    [refundsButton setTitle:@"退款" forState:UIControlStateNormal];
    [refundsButton setTitleColor:RGBCOLOR(80, 168, 252) forState:UIControlStateNormal];
    [refundsButton addTarget:self action:@selector(refundsClick:) forControlEvents:UIControlEventTouchUpInside];
    refundsButton.layer.masksToBounds = YES;
    refundsButton.layer.cornerRadius = 5;
    [_headerView addSubview:refundsButton];
    [refundsButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(_headerView.mas_centerX);
        make.top.equalTo(_balanceNumberLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
}

-(void)refreshData{
    _balanceNumberLabel.text = [NSString stringWithFormat:@"¥%@",[_model moneyModel].available_predeposit];
    [_accountTableView reloadData];
}

-(void)initTableView{
    
    _accountTableView = [[UITableView alloc]init];
    _accountTableView.delegate = self;
    _accountTableView.dataSource = self;
    _accountTableView.backgroundColor = [UIColor clearColor];
    _accountTableView.tableHeaderView = _headerView;
    
    [_accountTableView registerClass:[YMSelfHomeTableViewCell class] forCellReuseIdentifier:selfHomeCell];
    
     [_accountTableView registerClass:[YMAccountTopTableViewCell class] forCellReuseIdentifier:accountTopCell];
    
     [_accountTableView registerClass:[YMAccountInformationTableViewCell class] forCellReuseIdentifier:accountInformationCell];
    
    _accountTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_accountTableView];
    [_accountTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 2+_model.order.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YMSelfHomeTableViewCell *cell = [[YMSelfHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selfHomeCell];
        cell.titleName = @"我的银行卡";
        cell.imageName = @"bankCard_icon";
        cell.subTitlename = [_model moneyModel].card_num;
        cell.lastOne =YES;
        return cell;
    }else{
        
        NSLog(@"index row ==%ld",(long)indexPath.row);
        switch (indexPath.row) {
            case 0:{
                YMSelfHomeTableViewCell *cell = [[YMSelfHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selfHomeCell];
                cell.titleName = @"账单纪录";
                cell.imageName = @"billrecord_icon";
                cell.lastOne =YES;
                return cell;
            }
                break;
            case 1:{
                YMAccountTopTableViewCell *cell =[[YMAccountTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountTopCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
                
            default:{
                YMAccountInformationTableViewCell *cell = [[YMAccountInformationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountInformationCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = _model.billRecordArray[indexPath.row-2];
                return cell;
            }
                
                break;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSLog(@"我的银行卡");
        YMMYBackCardViewController *vc = [[YMMYBackCardViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:{

                    YMBillRecordInfoViewController *vc = [[YMBillRecordInfoViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];

                }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;//section头部高度
}
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =[UIColor clearColor];
    return headerview ;
}

#pragma mark - clickButton
-(void)refundsClick:(UIButton *)sender{

    YMRefundsViewController *vc = [[YMRefundsViewController alloc]init];
    vc.is_paypwd = _model.moneyModel.is_paypwd;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
