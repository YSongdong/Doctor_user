//
//  YMNewPlayerViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMNewPlayerViewController.h"
#import "YMBottomView.h"
#import "YMNewPalyTableViewCell.h"
#import "YMPlayerManager.h"
#import "YMNewPayView.h"
#import "YMNewPayView.h"
#import "YMUserInforModel.h"
#import "YMOrderViewController.h"

//typedef enum : NSUInteger {
//    AlipayPlayTpe =0,//支付宝
//    WXPlayType,//微信
//    banalcePlayType,//余额
//} playType;

static NSString *const NewPalyViewCell = @"NewPalyViewCell";

static NSString *const payResultFinish = @"payResultFinish";

@interface YMNewPlayerViewController ()<YMBottomViewDelegate,UITableViewDelegate,UITableViewDataSource,YMNewPayViewDelegate,YMPlayerManagerDelegate>

@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)UILabel *playNumberLabel;

@property(nonatomic,strong)UITableView *playTableView;
@property(nonatomic,strong)NSArray *playShowData;

@property(nonatomic,assign)payType payType;

@property(nonatomic,strong)UIView *backBalanceView;

@property(nonatomic,strong)YMNewPayView *payView;

@property(nonatomic,strong)YMUserInforModel *model;

@property(nonatomic,copy)NSString *payPassworld;

@property(nonatomic,strong)YMPlayerManager *manager ;
@end

@implementation YMNewPlayerViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"支付选择";
    [self initVar];
    [self initHeaderView];
    [self initBottomView];
    [self initTableView];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WXpayResultFinish:) name:payResultFinish object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"test" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initVar{
    _playShowData = @[@{@"headerImageName":@"play_Alipay_icon",
                     @"titleName":@"支付宝"},
                   @{@"headerImageName":@"play_wx_icon",
                     @"titleName":@"微信支付"},
                   @{@"headerImageName":@"play_balance_icon",
                     @"titleName":@"帐户支付"}];
    _payType = AplayPayType;
    _model = [YMUserInforModel currentUser];
    _payPassworld = @"";
    NSLog(@"%@",_model);
}

-(void)initHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    _headerView.backgroundColor = RGBCOLOR(75, 166, 255);
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"金额";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView.mas_centerX);
        make.top.equalTo(_headerView.mas_top).offset(20);
    }];
    _playNumberLabel = [[UILabel alloc]init];
   
    _playNumberLabel.text =[NSString stringWithFormat:@"¥%@", [NSString isEmpty:_payData[@"should_pay"]]?@"":_payData[@"should_pay"]];
    _playNumberLabel.textColor = [UIColor whiteColor];
    _playNumberLabel.font = [UIFont systemFontOfSize:35];
    _playNumberLabel.textAlignment = NSTextAlignmentCenter;
    _playNumberLabel.adjustsFontSizeToFitWidth = YES;
    [_headerView addSubview:_playNumberLabel];
    [_playNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView.mas_centerX);
        make.top.equalTo(tipLabel.mas_bottom).offset(10);
        make.left.right.equalTo(_headerView);
    }];
    
    UILabel *tip2Label = [[UILabel alloc]init];
    tip2Label.text = @"请选择支付方式";
    tip2Label.textColor = [UIColor whiteColor];
    tip2Label.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:tip2Label];
    [tip2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView.mas_centerX);
        make.top.equalTo(_playNumberLabel.mas_bottom).offset(10);
    }];
    
}

-(void)initBottomView{
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    _bottomView = [[YMBottomView alloc]init];
    _bottomView.type = MYBottomBlueAndwhiteType;
    _bottomView.bottomTitle = @"确定支付";
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

-(void)initTableView{
    _playTableView = [[UITableView alloc]init];
    _playTableView.backgroundColor = [UIColor clearColor];
    _playTableView.delegate = self;
    _playTableView.dataSource = self;
    _playTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _playTableView.tableHeaderView = _headerView;
    [_playTableView registerClass:
     [YMNewPalyTableViewCell class] forCellReuseIdentifier:NewPalyViewCell];
    [self.view addSubview:_playTableView];
    [_playTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

#pragma mark - YMBottomViewDelegate
-(void)bottomView:(YMBottomView *)bottomClick{
   
   _manager  = [[YMPlayerManager alloc]initManagerView:self.view];
    _manager.delegate = self;
    _manager.dic = _payData;
    _manager.type = _payType;
    if (_payType == banalcePlayType) {
        [self banalceView];
    }else{
        [_manager startPay];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _playShowData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMNewPalyTableViewCell *cell = [[YMNewPalyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewPalyViewCell];
    cell.dataDic = _playShowData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != _playShowData.count-1) {
        [cell drawBottomLine:10 right:0];
    }else{
        [cell drawBottomLine:0 right:0];
    }
    if (indexPath.row == _payType) {
        cell.select = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == _payType) {
        return;
    }
    _payType = indexPath.row;
    [_playTableView reloadData];
}


#pragma mark - balance
-(void)banalceView{
    _backBalanceView  = [[UIView alloc]init];
    [self.view addSubview:_backBalanceView];
    
    [UIView animateWithDuration:0.2 animations:^{
        [_backBalanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            self.navigationController.navigationBarHidden = YES;
        }];
    } completion:^(BOOL finished) {
        _backBalanceView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBalance:)];
    [_backBalanceView addGestureRecognizer:tap];
    
    _payView = [[YMNewPayView alloc]init];
    _payView.delegate = self;
    _payView.type = [_model.is_paypwd integerValue] == 1?TitlePassworldType:TitleNoSetPassworldType;
    _payView.backgroundColor = [UIColor whiteColor];
    
    [_backBalanceView addSubview:_payView];
    
    [_payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_backBalanceView);
        make.height.equalTo(@300);
    }];

}

-(void)hiddenBalance:(UITapGestureRecognizer *)tapGesture{
    self.navigationController.navigationBarHidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [_backBalanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
    } completion:^(BOOL finished) {
        [_backBalanceView removeAllSubviews];
        [_backBalanceView removeFromSuperview];
        
    }];
}

#pragma mark - YMNewPayViewDelegate
//返回按钮
-(void)newPayView:(YMNewPayView *)payView backButton:(UIButton *)sender{
    [self hiddenBalance:nil];
}
//完成按钮
-(void)newPayView:(YMNewPayView *)payView fulfillButton:(UIButton *)sender{
    if ([_model.is_paypwd integerValue] == 1) {
        NSLog(@"支付");
        
        [self balanceAplay];
    }else{
        NSLog(@"添加支付密码");
        [self addPayPassWorld];
    }
}
//忘记密码按钮
-(void)newPayView:(YMNewPayView *)payView forgetPasdButton:(UIButton *)sender{
    
}
//textField发生改变
-(void)newPayView:(YMNewPayView *)payView textField:(NSString *)text{
    _payPassworld = text;
}


#pragma mark - 余额支付

-(void)balanceAplay{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=new_order&op=payByBalance" params:@{@"sn":!_payData[@"sn"]?@"":[NSString isEmpty:_payData[@"sn"]]?@"":_payData[@"sn"],@"member_paypwd":_payPassworld} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSMutableArray class]] || [showdata isKindOfClass:[NSArray class]]){
            [self checkPayed];
        }
    }];
}


//添加支付密码
- (void)addPayPassWorld {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_account&op=account_zfmms" params:@{@"member_id":_model.member_id,@"member_paypwd":_payPassworld} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            _payPassworld = @"";
            _payView.type = TitlePassworldType;
            YMOrderViewController *vc = [[YMOrderViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}
#pragma mark - 验证接口
-(void)checkPayed{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=new_order&op=checkPayed" params:@{@"sn":!_payData[@"sn"]?@"":[NSString isEmpty:_payData[@"sn"]]?@"":_payData[@"sn"]} withModel:nil complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            if ([showdata[@"is_payed"] integerValue] ==1) {
                [self.view showRightWithTitle:@"已支付成功" autoCloseTime:2];
            }else{
                [self.view showErrorWithTitle:@"未支付" autoCloseTime:2];
            }
            if (_noJump) {
                [[self navigationController] popViewControllerAnimated:YES];
            }else{
                self.navigationController.navigationBarHidden = NO;
    
                YMOrderViewController *vc = [[YMOrderViewController alloc]init];
                vc.returnRoot = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
}

#pragma mark - YMPlayerManagerDelegate
-(void)playSuccess:(YMPlayerManager *)manager{
    if (_noJump) {
        [[self navigationController] popViewControllerAnimated:YES];
    }else{
        self.navigationController.navigationBarHidden = NO;
        YMOrderViewController *vc = [[YMOrderViewController alloc]init];
        vc.returnRoot = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)WXpayResultFinish:(NSNotification*)sender{
    NSDictionary *dic = sender.userInfo;
    if ([dic[@"pay"] isEqualToString:@"1"]) {
        [self checkPayed];
    } else {
        [self showErrorWithTitle:@"支付失败" autoCloseTime:2];
    }
}

@end
