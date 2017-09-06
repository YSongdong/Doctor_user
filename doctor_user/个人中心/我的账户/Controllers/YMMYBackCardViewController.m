//
//  YMMYBackCardViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMYBackCardViewController.h"
#import "YMMyBackCardTableViewCell.h"
#import "YMActivityBottomView.h"
#import "YMAddAccountViewController.h"

#import "YMIdCardListModel.h"

static NSString *const myBackCardCell = @"myBackCardCell";

@interface YMMYBackCardViewController ()<UITableViewDelegate,UITableViewDataSource,YMActivityBottomViewDelegate,YMMyBackCardTableViewCellDelegate>

@property(nonatomic,strong)UITableView *backCardTableView;
@property(nonatomic,strong)YMActivityBottomView *bottomView;

@property(nonatomic,assign)BOOL rightButtonClick;

@property(nonatomic,strong)YMIdCardListModel *listModel;

@property(nonatomic,strong)NSMutableArray *selctBackArry;

@property(nonatomic,strong)UIButton *rightBtnBigger ;



@end

@implementation YMMYBackCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"我的银行卡";
    [self initView];
    [self initVar];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self requrtData];
}

-(void)initView{
    [self addNavigationRightButton];
    [self initBottomView];
    [self initTableView];
}

-(void)initVar{
    _selctBackArry = [[NSMutableArray alloc]init];
}


-(void)addNavigationRightButton{
    UIView *rightBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22 *2)];
    [rightBtnView setBackgroundColor:[UIColor clearColor]];
    
    _rightBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    _rightBtnBigger.backgroundColor = [UIColor clearColor];
    _rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:17];
    [_rightBtnBigger setTitle:@"管理" forState:UIControlStateNormal];
    [_rightBtnBigger addTarget:self action:@selector(scanitClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnView addSubview:_rightBtnBigger];
    [_rightBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightBtnView);
    }];
    [_rightBtnBigger LZSetbuttonType:LZCategoryTypeBottom];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -17;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightBarButtonItem];
    } else {
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=cardsList" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSDictionary class]]||[showdata isKindOfClass:[NSMutableDictionary  class]]) {
            weakSelf.listModel = [YMIdCardListModel modelWithJSON:showdata];
            [weakSelf.backCardTableView reloadData];
        }
    }];

}

-(void)initTableView{
    
    _backCardTableView = [[UITableView alloc]init];
    _backCardTableView.delegate = self;
    _backCardTableView.dataSource = self;
    _backCardTableView.backgroundColor = [UIColor clearColor];
    
    [_backCardTableView registerClass:[YMMyBackCardTableViewCell class] forCellReuseIdentifier:myBackCardCell];
    
    _backCardTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_backCardTableView];
    [_backCardTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

-(void)initBottomView{
    _bottomView = [[YMActivityBottomView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.bottomTitle = @"添加新帐户";
    _bottomView.imageName = @"my_addBank_icon";
    _bottomView.delegate = self;
    _bottomView.type = BottomAccountType;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [_bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_bottomView);
        make.height.mas_equalTo(1);
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _listModel.bank_list.count;
    }else{
        return _listModel.zfb_list.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        return 80;
    }
    return 90;
}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (_listModel.bank_list.count == 0) {
            return 0;
        }
    }else{
        if (_listModel.zfb_list.count == 0) {
            return 0;
        }
    }
    return 30;//section头部高度
}
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =RGBCOLOR(229, 229, 229);
    UILabel *titleLabel = [[UILabel alloc]init];
    if (section == 0) {
        titleLabel.text = @"银行卡帐户";
    }else{
        titleLabel.text = @"支付宝帐户";
    }
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor =RGBCOLOR(51, 51, 51);
    [headerview addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.bottom.right.equalTo(headerview);
    }];
    return headerview ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMMyBackCardTableViewCell *cell = [[YMMyBackCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myBackCardCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showSelectButton = _rightButtonClick;
    cell.delegate = self;
    if (indexPath.row == 0) {
        cell.firstCell = YES;
    }
    
    if(indexPath.section == 0){
        cell.type = bankType;
        cell.bankInfoModel = _listModel.myBankArry[indexPath.row];
    }else{
        cell.type = alipayType;
        cell.alipayInfoModel = _listModel.alipayArry[indexPath.row];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 20;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}


-(void)MyBackCardViewCell:(YMMyBackCardTableViewCell *)MyBackCardViewCell  alipayModel:(YMAlipayInfoModel *)alipayModel add:(BOOL)add{
    if (add) {
        [_selctBackArry addObject:alipayModel];
    }else{
        [_selctBackArry removeObject:alipayModel];
    }
}

-(void)MyBackCardViewCell:(YMMyBackCardTableViewCell *)MyBackCardViewCell  bankModel:(YMMyBankInfoModel *)bankModel add:(BOOL)add{
    if (add) {
        [_selctBackArry addObject:bankModel];
    }else{
        [_selctBackArry removeObject:bankModel];
    }
}


#pragma mark - NavigationRightClick
-(void)scanitClick:(UIButton *)sender{
    _rightButtonClick = !_rightButtonClick;
    if (_rightButtonClick) {
        [_rightBtnBigger setTitle:@"完成" forState:UIControlStateNormal];
        _bottomView.bottomTitle = @"删除";
        _bottomView.imageName = @"";
    }else{
        [_rightBtnBigger setTitle:@"管理" forState:UIControlStateNormal];
        _bottomView.bottomTitle = @"添加新帐户";
        _bottomView.imageName = @"my_addBank_icon";
    }
    [_backCardTableView reloadData];
}

-(void)removeBankRequrt{
    if (_selctBackArry.count == 0) {
//        [_rightBtnBigger setTitle:@"管理" forState:UIControlStateNormal];
        return ;
    }
    NSString *delCarIDStr = @"";//拼接字符串
    for (id dic in _selctBackArry) {
        NSString *deleteID = @"";
        if ([dic isKindOfClass:[YMAlipayInfoModel class]]) {
            YMAlipayInfoModel *alipayModel = (YMAlipayInfoModel *)dic ;
            deleteID  = alipayModel.alipayId;
        }else if([dic isKindOfClass:[YMMyBankInfoModel class]]){
            YMMyBankInfoModel *bankModel = (YMMyBankInfoModel *)dic;
            deleteID = bankModel.bankId;
        }
        if (![NSString isEmpty:deleteID]) {
            if (![NSString isEmpty:delCarIDStr]) {
                delCarIDStr = [NSString stringWithFormat:@"%@,%@",delCarIDStr,deleteID];
            }else{
                delCarIDStr = deleteID;
            }
        }
    }
    
    NSDictionary *params = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                             @"card_id":delCarIDStr};
    
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=cardDel" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [weakSelf requrtData];
        [weakSelf.rightBtnBigger setTitle:@"管理" forState:UIControlStateNormal];
    }];
}

#pragma mark -  YMActivityBottomViewDelegate

-(void)activityBottomView:(YMActivityBottomView *)ActivityBottomView bottomClick:(UIButton *)sender{
    if (_rightButtonClick) {
        [self removeBankRequrt];
    }else{
        YMAddAccountViewController *addVc = [[YMAddAccountViewController alloc]init];
        [self.navigationController pushViewController:addVc animated:YES];
    }
}

@end
