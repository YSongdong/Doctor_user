//
//  YMSelectBidViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSelectBidViewController.h"
#import "YMDoctorInfoTableViewCell.h"
#import "YMBottomView.h"
#import "YMOrderInforView.h"

#import "YMOrderSectionView.h"

#import "YMDemandBidSelectionModel.h"

#import "YMContractViewController.h"
#import "YMNewPlayerViewController.h"
#import "YMOrderDetailsViewController.h"
#import "YMDoctorHomePageViewController.h"

static NSString *const doctorInfoViewCell = @"doctorInfoViewCell";

@interface YMSelectBidViewController ()<YMOrderInforViewDelegate,YMBottomViewDelegate,UITableViewDelegate,UITableViewDataSource,YMDoctorInfoTableViewCellDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *selectBidTableView;

@property(nonatomic,strong)YMBottomView *bottomView;
@property(nonatomic,strong)YMOrderInforView *orderInfoView;

@property(nonatomic,strong)YMOrderSectionView *orderSectionViewHeader;

@property(nonatomic,strong)NSMutableArray *arry;

@property(nonatomic,strong)YMDemandBidSelectionModel *model;


@end

@implementation YMSelectBidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requrtData];
}

-(void)initView{
    [self initOrderInfoView];
    [self initBottomView];
    [self initOrderSectionViewHeader];
    [self initTableView];
}

-(void)initOrderInfoView{
    _orderInfoView = [[YMOrderInforView alloc]init];
    _orderInfoView.delegate = self;
    _orderInfoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_orderInfoView];
    [_orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@80);
    }];
}

-(void)initBottomView{
    _bottomView = [[YMBottomView alloc]init];
    _bottomView.type = MYBottomWhiteBackAndGrayTextAndLeftIconType;
    _bottomView.bottomTitle = @"关闭订单";
    _bottomView.bottomImageName = @"power-button";
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

-(void)initOrderSectionViewHeader{
    _orderSectionViewHeader = [[YMOrderSectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    _orderSectionViewHeader.titleLeftStr = @"选标阶段";
    _orderSectionViewHeader.titleNumberStr = @"01";
    _orderSectionViewHeader.titleRightStr = @"共0位医生参与了投标";
   
}

-(void)initTableView{
    _selectBidTableView = [[UITableView alloc]init];
    _selectBidTableView.backgroundColor = [UIColor clearColor];
    _selectBidTableView.delegate = self;
    _selectBidTableView.dataSource = self;
    _selectBidTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _selectBidTableView.tableHeaderView = _orderSectionViewHeader;
    [_selectBidTableView registerClass:[YMDoctorInfoTableViewCell class] forCellReuseIdentifier:doctorInfoViewCell];
    
    [self.view addSubview:_selectBidTableView];
    [_selectBidTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_orderInfoView.mas_bottom).offset(10);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=demandBidSelection"
     params:@{@"demand_id":[NSString isEmpty:_demand_id]?@"":_demand_id}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         
         if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
             weakSelf.model = [YMDemandBidSelectionModel modelWithJSON:showdata];
             [weakSelf refreshData];
         }
     }];
}


-(void)refreshData{
    _orderInfoView.model = _model;
    if ([_model.status integerValue] == 0) {
        _bottomView.bottomTitle = @"托管酬金";
        _bottomView.bottomImageName = @"";
        _orderSectionViewHeader.hidden = YES;
    }else{
        _bottomView.bottomTitle = @"关闭订单";
        _bottomView.bottomImageName = @"power-button";
        _orderSectionViewHeader.hidden = NO;
    }
    _orderSectionViewHeader.titleRightStr = [NSString stringWithFormat:@"共%@位医生参与了投标",_model.bid_num];
    
    [self.selectBidTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - YMBottomViewDelegate
-(void)bottomView:(YMBottomView *)bottomClick{
    if ([_model.status integerValue] == 0) {
        NSLog(@"去支付");
        YMNewPlayerViewController *vc = [[YMNewPlayerViewController alloc]init];
        vc.payData = @{@"sn":_model.demand_sn,@"should_pay":_model.should_pay};
        vc.noJump = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@"关闭订单");
        UIAlertView *altkf = [[UIAlertView alloc]initWithTitle:@"是否关闭订单" message:@"关闭订单，费用将返回个人帐户如有延迟请耐心等待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [altkf show];
    }
    
}

#pragma mark - YMOrderInforViewDelegate

-(void)orderInfoView:(YMOrderInforView *)orderView orderDetails:(UIButton *)sender{
    NSLog(@"需求详情");
    YMOrderDetailsViewController *vc = [[YMOrderDetailsViewController alloc]init];
    vc.demand_id = _model.demand_id;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_model.status integerValue] == 0) {
        return 0;
    }
    return _model.bid_list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMDoctorInfoTableViewCell *cell = [[YMDoctorInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:doctorInfoViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell drawBottomLine:0 right:0];
    cell.model = _model.bidListArry[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YMBidListModel *bidListmodel  =  _model.bidListArry[indexPath.row];
    YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
    vc.doctorID = bidListmodel.doctor_store_id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - YMDoctorInfoTableViewCellDelegate
-(void)doctorInfoCell:(YMDoctorInfoTableViewCell *)cell bidModel:(YMBidListModel *)bidModel{
    YMContractViewController *vc = [[YMContractViewController alloc]init];
    vc.order_id = bidModel.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        __weak typeof(self) weakSelf = self;
        [[KRMainNetTool sharedKRMainNetTool]
         sendRequstWith:@"act=new_order&op=closeDemand"
         params:@{@"demand_id":[NSString isEmpty:_demand_id]?@"":_demand_id}
         withModel:nil
         waitView:self.view
         complateHandle:^(id showdata, NSString *error) {
             if (showdata == nil) {
                 return ;
             }
             
             if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
                 UIViewController *ctrl = [[weakSelf navigationController] popViewControllerAnimated:YES];
                 if (ctrl == nil) {
                     [weakSelf dismissViewControllerAnimated:YES completion:nil];
                 }
             }
             
         }];
    }
}

@end
