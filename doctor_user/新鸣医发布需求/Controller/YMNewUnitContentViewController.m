//
//  YMNewUnitContentViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMNewUnitContentViewController.h"
#import "YMBottomView.h"

#import "YMTitleAndTextFieldTableViewCell.h"
#import "YMFaBuSubTitleTableViewCell.h"

#import "YMContactAddressTableViewCell.h"
#import "YMRegisteredViewTableViewCell.h"

#import "YMCostEscrowCellTableViewCell.h"
#import "YMHospitalListViewController.h"
#import "YMPayView.h"

#import "YMNewPlayerViewController.h"

static NSString *const titleAndTextFieldCell = @"titleAndTextFieldCell";

static NSString *const contentTitleCell = @"contentTitleCell";

static NSString *const descriptionContentCell = @"descriptionContentCell";

static NSString *const registeredViewCell = @"registeredViewCell";

static NSString *const costEscrowCell = @"costEscrowCell";



@interface YMNewUnitContentViewController ()<YMBottomViewDelegate,UITableViewDelegate,UITableViewDataSource,YMTitleAndTextFieldTableViewCellDelegate,YMRegisteredViewTableViewCellDelegate,YMCostEscrowCellTableViewCellDelegate,YMContactAddressTableViewCellDelegate,YMHospitalListViewControllerDelegate>

@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,strong)UITableView *contentTableView;

@property(nonatomic,copy)NSString *treatmentHospital;//就诊医院

@property(nonatomic,copy)NSString *ename;

@property(nonatomic,strong)NSMutableArray *forumDatalist;

@property(nonatomic,strong)NSString *treatmentTime;

@property(nonatomic,strong)UIView *dateView;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)UIAlertController *controller;

@property(nonatomic,strong)NSString *agent_regist_money;

@property(nonatomic,assign)BOOL startEdit;

@property(nonatomic,assign) BOOL startTime;

@end

@implementation YMNewUnitContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    self.title = @"需求内容";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _treatmentHospital = @"";
    _ename = @"";
    
    [self initBottomView];
    [self initTableView];
    [self requestPageContent];
    [self setDateView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertControllerView{
    _controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSDictionary *dic in _forumDatalist) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:dic[@"ename"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _ename = dic[@"ename"];
            [_orderDic setObject:dic[@"disorder"] forKey:@"aptitude"];
            [_orderDic setObject:dic[@"money_limit"] forKey:@"money"];
            [_contentTableView reloadData];
        }];
        [_controller addAction:action];
    }
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }];
    [_controller addAction:action3];
}

- (void)setDateView {
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 315)];
    _dateView.backgroundColor = [UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 270)];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.backgroundColor = [UIColor whiteColor];
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 45)];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    cancle.titleLabel.textColor = [UIColor whiteColor];
    cancle.titleLabel.font = [UIFont systemFontOfSize:15];
    //[cancle setTitleColor:[UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1] forState:UIControlStateNormal];
    cancle.backgroundColor = [UIColor clearColor];
    cancle.tag = 100;
    [cancle addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 50, 0, 50, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tag = 101;
    button.titleLabel.textColor = [UIColor whiteColor];
    //_dateView.backgroundColor = [UIColor whiteColor];
    UIView *linview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    linview.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview];
    UIView *linview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 1)];
    linview1.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview1];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    //[button setTitleColor:[UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:button];
    [self.dateView addSubview:cancle];
    [self.dateView addSubview:self.datePicker];
    [self.view addSubview:self.dateView];
    UILabel *titlesLabel = [[UILabel alloc]init];
    [self.dateView addSubview:titlesLabel];
    titlesLabel.font = [UIFont systemFontOfSize:15];
    titlesLabel.text = @"请选择时间";
    titlesLabel.textColor = [UIColor whiteColor];
    [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(self.dateView.mas_top);
        make.centerX.equalTo(self.dateView.mas_centerX);
        make.width.lessThanOrEqualTo(@250);
    }];
    
}

- (void)selected:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.dateView.frame;
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
        }
        else {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
            _contentTableView.scrollEnabled = YES;
        }
        self.dateView.frame = rect;
    }];
    if (sender.tag == 101) {
        NSDate *date = self.datePicker.date;
        if ([date timeIntervalSinceNow] < 0) {
            [self showErrorWithTitle:@"请选择正确时间" autoCloseTime:2];
            return;
        }
        NSDateFormatter *dateformatter = [NSDateFormatter new];
        dateformatter.dateFormat = @"yyyy年MM月dd日 hh时mm分ss";
        NSDateFormatter *dateformatter1 = [NSDateFormatter new];
        dateformatter1.dateFormat = @"yyyy-MM-dd hh:mm:ss";
        _treatmentTime = [dateformatter stringFromDate:date];
        if (_startTime) {
            [_orderDic setObject:[dateformatter1 stringFromDate:date] forKey:@"demand_time"];
        }else{
            [_orderDic setObject:[dateformatter1 stringFromDate:date] forKey:@"demand_time2"];
        }
        
        [_contentTableView reloadData];
    }
    
}


- (void)requestPageContent {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=new_order&op=mingyiPage" params:@{@"demand_type":_orderDic[@"demand_type"]} withModel:nil complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            _agent_regist_money = showdata[@"agent_regist_money"];
            self.forumDatalist = showdata[@"doctor_type"] ;
            [self alertControllerView];
        }
    }];
    
}

//发布需求
- (void)requestFaBuXuQiu {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=new_order&op=mingyi" params:_orderDic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            [self playView:showdata];
        }
    }];
    
}

-(void)playView:(NSDictionary *)dic{
    YMNewPlayerViewController *vc = [[YMNewPlayerViewController alloc]init];
    vc.payData = [dic copy];
    [self.navigationController pushViewController:vc animated:YES];
//    NSString *order_id =[NSString isEmpty:dic[@"sn"]]?@"":dic[@"sn"];
//    NSString *order_amount = [NSString isEmpty:dic[@"should_pay"]]?@"":dic[@"should_pay"];
//    
//    NSDictionary *payDic = @{@"order_list":@{@"pay_sn":order_id,
//                                             @"order_amount":order_amount}};
//    
//    YMPayView *payView = [[[NSBundle mainBundle]loadNibNamed:@"YMPayView" owner:self options:nil]firstObject];
//    payView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    payView.block = ^(long long staus) {
//        //        YMOrderDetailViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"orderDetailView"];
//        //        vc.params = @{@"demand_id":@(staus),@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
//        //        [self.navigationController pushViewController:vc animated:YES];
//    };
//    payView.superVC = self;
//    [payView setDetailMoneyWith:order_amount andData:payDic];
//    [self.view.window addSubview:payView];
//    [payView setAnimaltion];
}

-(void)initBottomView{
    _bottomView = [[YMBottomView alloc]init];
    _bottomView.type = MYBottomBlueType;
    _bottomView.bottomTitle = @"提交";
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

-(void)initTableView{
    _contentTableView = [[UITableView alloc]init];
    _contentTableView.backgroundColor = [UIColor clearColor];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentTableView registerClass:
     [YMTitleAndTextFieldTableViewCell class] forCellReuseIdentifier:titleAndTextFieldCell];
    [_contentTableView registerClass:[YMFaBuSubTitleTableViewCell class] forCellReuseIdentifier:contentTitleCell];
    [_contentTableView registerClass:[YMContactAddressTableViewCell class] forCellReuseIdentifier:descriptionContentCell];
    
    [_contentTableView registerClass:[YMRegisteredViewTableViewCell class] forCellReuseIdentifier:registeredViewCell];
    
    [_contentTableView registerClass:[YMCostEscrowCellTableViewCell class] forCellReuseIdentifier:costEscrowCell];
    [self.view addSubview:_contentTableView];
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 2) {
        return 1;
    }
    
    if (section == 3) {
        return 3;
    }
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 150;
    }
    if (indexPath.section == 4 && indexPath.row == 1) {
        return 60;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            YMTitleAndTextFieldTableViewCell *cell = [[YMTitleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleAndTextFieldCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.titleName = @"需求描述:";
            cell.placeholder = @"请简短描述您的需求";
            if (![NSString isEmpty:_orderDic[@"title"]]) {
                cell.subTitleName = _orderDic[@"title"];
            }
            return cell;
        }
            break;
        case 1:{
            YMTitleAndTextFieldTableViewCell *cell = [[YMTitleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleAndTextFieldCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            if (indexPath.row == 0) {
                cell.titleName = @"需求单位:";
                cell.placeholder = @"请在此填写您的单位名称";
                if (![NSString isEmpty:_orderDic[@"demand_company"]]) {
                    cell.subTitleName = _orderDic[@"demand_company"];
                }
                [cell drawBottomLine:0 right:0];
            }else{
                cell.titleName = @"单位电话:";
                cell.placeholder = @"请填写单位联系电话";
                if (![NSString isEmpty:_orderDic[@"demand_company_tel"]]) {
                    cell.subTitleName = _orderDic[@"demand_company_tel"];
                }
            }
            
            return cell;
        }
            break;
            
        case 2:{
            YMContactAddressTableViewCell *cell = [[YMContactAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:descriptionContentCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.leftAlignment = YES;
            cell.titleName = @"详情描述:";
            cell.placeholder = @"请填写需求的内容，例如，讲座的地点，参与人群，大概参与人数、其他需要医生做的准备等！";
            if (![NSString isEmpty:_orderDic[@"demand_content"]]) {
                cell.addressStr = _orderDic[@"demand_content"];
            }
            return cell;
        }
            break;
        case 3:{
            YMFaBuSubTitleTableViewCell *cell = [[YMFaBuSubTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentTitleCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            switch (indexPath.row) {
                case 0:{
                    cell.titleName = @"需求时间:";
                    if (![NSString isEmpty:_orderDic[@"demand_time"]]) {
                        cell.subTitleName = _orderDic[@"demand_time"];
                    }else{
                        cell.subTitleName = @"";
                    }
                    [cell drawBottomLine:10 right:0];
                }
                    break;
                case 1:{
                    cell.titleName = @"";
                    if (![NSString isEmpty:_orderDic[@"demand_time2"]]) {
                        cell.subTitleName = [NSString stringWithFormat:@"至        %@", _orderDic[@"demand_time2"]];
                    }else{
                        cell.subTitleName = @"";
                    }
                    [cell drawBottomLine:10 right:0];
                }
                    break;
                case 2:{
                    cell.titleName = @"就诊医院";
                    if (![NSString isEmpty:_treatmentHospital]) {
                        cell.subTitleName = _treatmentHospital;
                    }else{
                        cell.subTitleName = @"非必选";
                    }
                }
                    break;
                default:
                    break;
            }
            
            return cell;
            
        }
    
        case 4:{
            if (indexPath.row == 0) {
                YMFaBuSubTitleTableViewCell *cell = [[YMFaBuSubTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentTitleCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleName = @"职称筛选";
                if ([NSString isEmpty:_ename]) {
                    cell.subTitleName = @"请选择医师职称";
                }else{
                    cell.subTitleName = _ename;
                }
                
                [cell drawBottomLine:10 right:0];
                return cell;
            }else{
                YMCostEscrowCellTableViewCell *cell =[[YMCostEscrowCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:costEscrowCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString *moneyStr = _orderDic[@"money"];
                cell.subText =moneyStr;
//                cell.delegate = self;
//                if (![NSString isEmpty: _orderDic[@"money"]]) {
//                    cell.subText =_orderDic[@"money"];
//                }
//                if (![NSString isEmpty:_ename]) {
//                    
//                    for (NSDictionary *dic in _forumDatalist) {
//                        if ([_ename isEqualToString:dic[@"ename"]]) {
//                            cell.minimumAmount = dic[@"money_limit"];
//                            break;
//                        }
//                    }
//                }
                return cell;
            }
        }
            break;
        default:
            return nil;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self keyboardWillHide];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 3:
            switch (indexPath.row) {
                case 0:{
                    _startTime = YES;
                    [self.view endEditing:YES];
                    [UIView animateWithDuration:0.2 animations:^{
                        CGRect rect = self.dateView.frame;
                        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                            _contentTableView.scrollEnabled = NO;
                        }
                        else {
                            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                            _contentTableView.scrollEnabled = YES;
                        }
                        self.dateView.frame = rect;
                    }];
                }
                    break;
                case 1:{
                    _startTime = NO;
                    [self.view endEditing:YES];
                    [UIView animateWithDuration:0.2 animations:^{
                        CGRect rect = self.dateView.frame;
                        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                            _contentTableView.scrollEnabled = NO;
                        }
                        else {
                            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                            _contentTableView.scrollEnabled = YES;
                        }
                        self.dateView.frame = rect;
                    }];
                }
                    break;
                case 2:{
                    YMHospitalListViewController *vc = [[YMHospitalListViewController alloc]init];
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            break;
        case 4:
            if (indexPath.row ==0) {
                [self.navigationController presentViewController:_controller animated:YES completion:nil];
            }
            break;
        default:
            break;
    }
}


#pragma mark - YMBottomViewDelegate

-(void)bottomView:(YMBottomView *)bottomClick{
    [self requestFaBuXuQiu];
}

#pragma mark - YMTitleAndTextFieldTableViewCellDelegate

-(void)TitleAndTextFieldCell:(YMTitleAndTextFieldTableViewCell *)cell textField:(NSString *)content{
    NSIndexPath *indexPath = [_contentTableView indexPathForCell:cell];
    switch (indexPath.section) {
        case 0:
            [_orderDic setObject:content forKey:@"title"];
            break;
        case 1:{
            if (indexPath.row == 0) {
                [_orderDic setObject:content forKey:@"demand_company"];
            }else{
                [_orderDic setObject:content forKey:@"demand_company_tel"];
            }
        }
        default:
            break;
    }
    
}


#pragma mark - YMContactAddressTableViewCellDelegate
-(void)contactaddress:(UITextView *)textView editContent:(NSString *)editContent{
    [_orderDic setObject:editContent.length==0?@"":editContent forKey:@"demand_content"];
}


#pragma mark - YMCostEscrowCellTableViewCellDelegate
-(void)constEscrowCell:(YMCostEscrowCellTableViewCell *)cell textField:(NSString *)content{
    [_orderDic setObject:content.length==0?@"":content forKey:@"money"];
}

#pragma mark - YMRegisteredViewTableViewCellDelegate
-(void)registeredViewCell:(YMRegisteredViewTableViewCell *)registeredViewCell setOn:(BOOL)On{
    [_orderDic setObject:On?@"10":@"0" forKey:@"agent_regist"];
}

#pragma mark - YMHospitalListViewControllerDelegate
-(void)hospitalList:(YMHospitalListViewController *)hospitalList hospitalModel:(YMHospitalModel *)hospitalModel{
    _treatmentHospital = hospitalModel.hospital_name;
    [_orderDic setObject:hospitalModel.hospital_id forKey:@"hospital_id"];
    [_contentTableView reloadData];
}


-(void)endEditing{
    [self keyboardWillHide];
    [self.view endEditing:YES];
}

-(void)keyboardWillShow:(NSNotification *)aNotification{
    [self selected:nil];
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSLog(@"%f",keyboardRect.size.height);
    [_contentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardRect.size.height);
    }];
}



-(void)keyboardWillHide{
    [_contentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}

@end

