//
//  YMOrderViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderViewController.h"
#import "YMMiYiOrderViewCell.h"
#import "YMOfficialActivityTopView.h"
#import "YMOrderStatusView.h"
#import "MJRefreshAutoNormalFooter.h"

#import "YMNewOrderModel.h"
#import "YMSeekingConsultationViewController.h"
#import "YMSelectBidViewController.h"

#import "YMHomeViewController.h"
#import "YMUserCenterTableViewController.h"

#import "YMYuYueOrderViewController.h"

#import "SDYINanDetailViewController.h"

#import "MSCustomTabBar.h"

static NSString *const MiYiOrderCell = @"MiYiOrderCell";

@interface YMOrderViewController ()<UITableViewDelegate,UITableViewDataSource,YMOfficialActivityTopViewDelegate,YMOrderStatusViewDelegate>


@property(nonatomic,strong)UITableView *orderTabelView;

@property(nonatomic,strong)YMOfficialActivityTopView *orderTopView;

@property(nonatomic,strong)YMOrderStatusView *orderStatusView;

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,assign)NSInteger order_type;

@property(nonatomic,copy)NSString *status_mark;

@property(nonatomic,assign)NSInteger curpage;

@property(nonatomic,strong)NSMutableArray<YMNewOrderModel*> *OrderArry;

@end

@implementation YMOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"鸣医订单";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self leftNavigationBar];
    [self initVar];
    [self initView];
    
    
}
- (void)leftNavigationBar {
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonOperator)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    if (_type == 1) {
        [self requrtData];
    }else{
        [self requestDiseasesListData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initVar{
    _curpage = 1;
    _type = 1;
    _status_mark = @"all";
    _OrderArry = [NSMutableArray array];
}

-(void)initView{
    [self initOrderTopView];
    [self initOrderStatusView];
    [self initTableView];
}
-(void)setIsFuzhen:(BOOL)isFuzhen{
    _isFuzhen = isFuzhen;
    _order_type = 1;
}
-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=orderList"
     params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
              @"type":@(_type),
              @"status_mark":_status_mark,
              @"curpage":@(_curpage),
              @"order_type":@(_order_type)}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
    if (showdata == nil) {
        return ;
    }
    if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
        if (weakSelf.curpage == 1 && weakSelf.OrderArry.count>0) {
            [weakSelf.OrderArry removeAllObjects];
        }
        for (NSDictionary *dic in showdata) {
            [weakSelf.OrderArry addObject:[YMNewOrderModel modelWithJSON:dic]];
        }
        if ([self.orderTabelView.footer isRefreshing]) {
            [self.orderTabelView.footer endRefreshing];
        }
        
        [weakSelf.orderTabelView reloadData];
    }
        
    }];
}

-(void)initOrderTopView{
    _orderTopView = [[YMOfficialActivityTopView alloc]init];
    _orderTopView.backgroundColor = [UIColor whiteColor];
    _orderTopView.delegate = self;
    _orderTopView.lefName = @"鸣医订单";
    _orderTopView.rightName = @"疑难杂症";
    if (self.isYiNan) {
        self.orderTopView.isRightBtn = YES;
    }
    [self.view addSubview:_orderTopView];
    [_orderTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.left.top.right.equalTo(self.view);
    }];
}

-(void)initOrderStatusView{
    _orderStatusView = [[YMOrderStatusView alloc]init];
    _orderStatusView.delegate = self;
    [_orderStatusView selectOrderStatus:allOrderTag];
    _orderStatusView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_orderStatusView];
    [_orderStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_orderTopView.mas_bottom);
        make.height.equalTo(@40);
    }];
}

-(void)initTableView{
    _orderTabelView = [[UITableView alloc]init];
    _orderTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _orderTabelView.backgroundColor = [UIColor clearColor];
    _orderTabelView.delegate = self;
    _orderTabelView.dataSource = self;
    [_orderTabelView registerClass:[YMMiYiOrderViewCell class] forCellReuseIdentifier:MiYiOrderCell];
    
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    _orderTabelView.footer = footer;
    [self.view addSubview:_orderTabelView];
    
    [_orderTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_orderStatusView.mas_bottom);
    }];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _OrderArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type == 1) {
        YMMiYiOrderViewCell *cell = [[YMMiYiOrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MiYiOrderCell];
        [cell drawBottomLine:0 right:0];
        cell.model = _OrderArry[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        YMMiYiOrderViewCell *cell = [[YMMiYiOrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MiYiOrderCell];
        [cell drawBottomLine:0 right:0];
        cell.hideMonay = YES;
        cell.model = _OrderArry[indexPath.row];
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ([self.delegate respondsToSelector:@selector(orderView:andNSDict:)]) {
            YMNewOrderModel *model = _OrderArry[indexPath.row];
            NSMutableDictionary *dic= [NSMutableDictionary dictionary];
            dic[@"member_id"] = model.member_id;
            dic[@"demand_type"] = model.demand_type;
            dic[@"leaguer_id"] = model.leaguer_id;
            dic[@"big_ks"] = model.big_ks;
            dic[@"small_ks"] = model.small_ks;
            dic[@"small_kss"] = model.small_kss;
            dic[@"title"] = model.title;
            dic[@"demand_content"] = model.demand_content;
            dic[@"demand_time"] = model.demand_time;
            dic[@"hospital_id"] = model.hospital_id;
            dic[@"hospital_name"] = model.hospital_name;
            dic[@"aptitude"] = model.aptitude;
            dic[@"aptitudes"] = model.aptitudes;
            dic[@"leaguer_name"] = model.leaguer_name;
            dic[@"order_id"] = model.demand_id;
            dic[@"leaguer_id"] = model.leaguer_id;
            dic[@"money"] = model.money;
            //返回的的复诊的订单名字
            dic[@"fuzhen"] = model.demand_sn;
            
            
            [self.delegate orderView:self andNSDict:dic.copy];
            UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
            if (ctrl == nil) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            return;
        }
        
        /**
         *
         *
         
         *
         *
         *
         */
        YMNewOrderModel *model = _OrderArry[indexPath.row];
        switch ([model.order_type integerValue]) {// 订单类型
            case 1:{//鸣医订单
                if ([model.user_signed integerValue] == 0) {//没有签订合同进入选标界面
                    YMSelectBidViewController *vc = [[YMSelectBidViewController alloc]init];
                    vc.demand_id = model.demand_id;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    YMSeekingConsultationViewController *vc =[[YMSeekingConsultationViewController alloc]init];
                    vc.demand_type = model.demand_type;
                    vc.order_id = model.order_id;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
                break;
            case 2:{
                YMYuYueOrderViewController *vc = [[YMYuYueOrderViewController alloc]init];
                vc.order_id = model.order_id;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
  
    }else{
       //疑难杂症
        SDYINanDetailViewController *yinanDetaVC = [[SDYINanDetailViewController alloc]init];
        YMNewOrderModel *model = _OrderArry[indexPath.row];
        yinanDetaVC.diseasesId = model.diseases_id;
        [self.navigationController pushViewController:yinanDetaVC animated:YES];
    
    }
    
    
}

#pragma mark - YMOfficialActivityTopViewDelegate
-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView hallButton:(UIButton *)sender{
    if (_type == 1) {
        return;
    }
    _curpage = 1;
    _type = 1;
    [self requrtData];
}

-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView participateButton:(UIButton *)sender{
    if (_type == 2) {
        return;
    }
    _curpage = 1;
    _type = 2;
    [self requestDiseasesListData];
}
#pragma mark  -- 是否跳到疑难杂症------
-(void)setIsYiNan:(BOOL)isYiNan{

    _isYiNan = isYiNan;
   
}

#pragma mark - YMOrderStatusViewDelegate
-(void)orderStatusView:(YMOrderStatusView *)orderStatus clickTag:(OrderTag)clickTag{
    switch (clickTag) {
        case allOrderTag:{
            if ([_status_mark isEqual:@"all"]) {
                return;
            }
            _status_mark = @"all";
            }
            break;
        case processingOrderTag:{
            if ([_status_mark isEqual:@"going"]) {
                return;
            }
            _status_mark = @"going";
        }
            break;
        case completedOrderTag:{
            if ([_status_mark isEqual:@"over"]) {
                return;
            }
            _status_mark = @"over";
        }
            break;
        case failureOrderTag:{
            if ([_status_mark isEqual:@"fail"]) {
                return;
            }
            _status_mark = @"fail";
        }
            break;
        default:
            break;
    }
    _curpage = 1;
    
    if (_type == 1) {
        
       [self requrtData];
        
    }else{
        
        [self requestDiseasesListData];
    }
   
    
}

-(void)loadMoreData{
    _curpage ++;
    
    if (_type == 1) {
        
        [self requrtData];
        
    }else{
        [self requestDiseasesListData];
    }
    
}

- (BOOL)navigationShouldPopOnBackButton{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if (_returnRoot) {
            if([controller isKindOfClass:[YMHomeViewController class]]){
                YMHomeViewController* vc = (YMHomeViewController *)controller;
                [self.navigationController popToViewController:vc animated:YES];
                return YES;
            }
            if([controller isKindOfClass:[YMUserCenterTableViewController class]]){
                YMUserCenterTableViewController* vc = (YMUserCenterTableViewController *)controller;
                [self.navigationController popToViewController:vc animated:YES];
                return YES;
            }
        }
        
    }
    return YES;
}
-(void)setReturnRoot:(BOOL)returnRoot{

    _returnRoot = returnRoot;

}
- (void)leftButtonOperator {
    if (self.returnRoot) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //跳级tabbar
        MSCustomTabBar *tabBar =(MSCustomTabBar *) self.tabBarController.tabBar;
        tabBar.tabBarView.itemIndex = 3;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
   
}

#pragma mark---------数据相关-------

-(void)requestDiseasesListData{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    param[@"member_id"] =[YMUserInfo sharedYMUserInfo].member_id;
    param[@"status_mark"] =_status_mark;
    param[@"curpage"] = @(_curpage);
    
    [[KRMainNetTool sharedKRMainNetTool]sendNowRequstWith:DiseasesList_Url params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
            if (weakSelf.curpage == 1 && weakSelf.OrderArry.count>0) {
                
                [weakSelf.OrderArry removeAllObjects];
            }
            for (NSDictionary *dic in showdata) {
                
                [weakSelf.OrderArry addObject:[YMNewOrderModel modelWithJSON:dic]];
                
            }
            
            if ([self.orderTabelView.footer isRefreshing]) {
                [self.orderTabelView.footer endRefreshing];
            }
            
            [weakSelf.orderTabelView reloadData];
        }
    }];

}





@end
