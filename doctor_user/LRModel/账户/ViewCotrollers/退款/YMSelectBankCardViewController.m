//
//  YMSelectBankCardViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSelectBankCardViewController.h"
#import "YMAddAccountTableViewCell.h"
#import "YMSelfHomeTableViewCell.h"
#import "YMAddAlipayViewController.h"
#import "YMAddCradsViewController.h"

static NSString *const addAccountCell= @"AddAccountCell";
static NSString *const selfHomeCell = @"selfHomeCell";

@interface YMSelectBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray <YMWithdrawModel *> *listData;

@property(nonatomic,strong)UITableView *selectBankCardTableView;


@end

@implementation YMSelectBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帐户选择";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initView];
    [self initArry];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self requrtData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [self initTableView];
}

-(void)initArry{
    _listData = [[NSMutableArray alloc]init];
}

-(void)requrtData{
    NSDictionary *params = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=withdrawBank"
                                                params:params withModel:nil
                                              waitView:self.view
                                        complateHandle:^(id showdata, NSString *error) {
                                            if (!error) {
                                                if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
                                                    [weakSelf.listData removeAllObjects];
                                                    for (NSDictionary *dic in showdata) {
                                                        [weakSelf.listData addObject:[YMWithdrawModel modelWithJSON:dic]];
                                                    }
                                                    [_selectBankCardTableView reloadData];
                                                }
                                            }
                                            
                                        }];
}

-(void)initTableView{
    _selectBankCardTableView = [[UITableView alloc]init];
    _selectBankCardTableView.delegate = self;
    _selectBankCardTableView.dataSource = self;
    _selectBankCardTableView.backgroundColor = [UIColor clearColor];
    
    [_selectBankCardTableView registerClass:[YMAddAccountTableViewCell class] forCellReuseIdentifier:addAccountCell];
    
    [_selectBankCardTableView registerClass:[YMSelfHomeTableViewCell class] forCellReuseIdentifier:selfHomeCell];
    
    _selectBankCardTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_selectBankCardTableView];
    [_selectBankCardTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _listData.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    return 10;//section头部高度
}
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =[UIColor clearColor];
    if (section == 0) {
        UILabel *headerLabel = [[UILabel alloc]init];
        headerLabel.font = [UIFont systemFontOfSize:13];
        headerLabel.text = @"选择到账帐户";
        headerLabel.textColor = RGBCOLOR(80, 80, 80);
        [headerview addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerview.mas_left).offset(10);
            make.top.right.bottom.equalTo(headerview);
            
        }]; 
    }
    
    return headerview ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YMAddAccountTableViewCell *cell = [[YMAddAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addAccountCell];
        cell.model = _listData[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == _listData.count -1) {
            cell.lastOne = YES;
        }
        if (indexPath.row != 0) {
            cell.lineInterval = YES;
        }
        return cell;
    }else{
        YMSelfHomeTableViewCell *cell = [[YMSelfHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selfHomeCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hiddrightImage = YES;
        if (indexPath.section ==1) {
            cell.titleName = @"添加银行卡";
        }else{
            cell.titleName = @"添加支付宝";
        }
        cell.imageName = @"add_bank_icon";
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([self.delegate respondsToSelector:@selector(selectBankCard:withdraw:)]) {
            [self.delegate selectBankCard:self withdraw:_listData[indexPath.row]];
            
            UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
            if (ctrl == nil) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }else if(indexPath.section == 1){
        YMAddCradsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddCradsID"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YMAddAlipayViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddAlipayID"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }

}



@end
