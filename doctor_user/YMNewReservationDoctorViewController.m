//
//  YMNewReservationDoctorViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMNewReservationDoctorViewController.h"
#import "YMBottomView.h"
#import "YMFaBuSubTitleTableViewCell.h"
#import "YMTitleAndTextFieldTableViewCell.h"
#import "YMContactAddressTableViewCell.h"
#import "YMCostEscrowCellTableViewCell.h"
#import "YMRegisteredViewTableViewCell.h"

#import "YMInfoBaseTableViewController.h"
#import "YMNewPlayerViewController.h"

static NSString *const faBuSubTitleTableCell = @"faBuSubTitleTableCell";
static NSString *const titleAndTextFieldTableCell = @"titleAndTextFieldTableCell";
static NSString *const contactAddressTableCell = @"contactAddressTableCell";
static NSString *const costEscrowCellTableCell = @"costEscrowCellTableCell"
;
static NSString *const registeredViewTableCell = @"registeredViewTableCell";

@interface YMNewReservationDoctorViewController ()<YMBottomViewDelegate,UITableViewDelegate,UITableViewDataSource,YMTitleAndTextFieldTableViewCellDelegate,YMContactAddressTableViewCellDelegate,YMCostEscrowCellTableViewCellDelegate,YMRegisteredViewTableViewCellDelegate,YMInfoBaseTableViewControllerDelegate>

@property(nonatomic,strong)UITableView *reservationDoctorTableView;

@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,strong)UIView *dateView;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)NSMutableDictionary *yuyueDic;

@property(nonatomic,strong)NSString *demand_time;//需求时间 //2017年5月23日 13:23:32

@property(nonatomic,strong)NSString *leaguer_Name;//成员名字

@end

@implementation YMNewReservationDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约医生";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    [self initVar];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initVar{
    _yuyueDic = [NSMutableDictionary dictionary];
    [_yuyueDic setObject:[YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
    [_yuyueDic setObject:[NSString isEmpty:_member_id]?@"":_member_id forKey:@"doctor_member_id"];
    [_yuyueDic setObject:self.member_aptitude_money forKey:@"money"];
    [_yuyueDic setObject:@"0" forKey:@"agent_regist"];
    _demand_time = @"";
    _leaguer_Name = @"";
}

-(void)initView{
    [self initBottomView];
    [self initTableView];
    [self setDateView];
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
            _reservationDoctorTableView.scrollEnabled = YES;
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
         _demand_time = [dateformatter stringFromDate:date];
        [_yuyueDic setObject:[dateformatter1 stringFromDate:date] forKey:@"demand_time"];
        [_reservationDoctorTableView reloadData];
    }
    
}

-(void)initTableView{
    _reservationDoctorTableView = [[UITableView alloc]init];
    _reservationDoctorTableView.backgroundColor = [UIColor clearColor];
    _reservationDoctorTableView.delegate = self;
    _reservationDoctorTableView.dataSource = self;
    _reservationDoctorTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_reservationDoctorTableView registerClass:
     [YMFaBuSubTitleTableViewCell class] forCellReuseIdentifier:faBuSubTitleTableCell];
    [_reservationDoctorTableView registerClass:[YMTitleAndTextFieldTableViewCell class] forCellReuseIdentifier:titleAndTextFieldTableCell];
    
    [_reservationDoctorTableView registerClass:[YMContactAddressTableViewCell class] forCellReuseIdentifier:contactAddressTableCell];
    [_reservationDoctorTableView registerClass:[YMCostEscrowCellTableViewCell class] forCellReuseIdentifier:costEscrowCellTableCell];
    [_reservationDoctorTableView registerClass:[YMRegisteredViewTableViewCell class] forCellReuseIdentifier:registeredViewTableCell];
    
    [self.view addSubview:_reservationDoctorTableView];
    [_reservationDoctorTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 80;
    }else if(indexPath.section== 3 ||indexPath.section ==4){
        return 60;
    }
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                YMFaBuSubTitleTableViewCell *cell = [[YMFaBuSubTitleTableViewCell alloc]init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleName = @"用户选择";
                cell.subTitleName = @"请选择需求用户";
                if (![NSString isEmpty:_leaguer_Name]) {
                    cell.subTitleName = _leaguer_Name;
                }
                [cell drawBottomLine:10 right:0];
                return cell;
            }else{
                YMTitleAndTextFieldTableViewCell *cell = [[YMTitleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleAndTextFieldTableCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                cell.titleName = @"主要症状:";
                cell.placeholder = @"请填写您的主要症状";
                if (![NSString isEmpty:_yuyueDic[@"title"]]) {
                    cell.subTitleName = _yuyueDic[@"title"];
                }
                return cell;
            }
        }
            break;
        case 1:{
            YMContactAddressTableViewCell *cell = [[YMContactAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactAddressTableCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.leftAlignment = YES;
            cell.titleName = @"详情描述:";
            cell.placeholder = @"请详细填写您的病情症状，例如，头疼发烧，体温38℃，体冒虚汗，还伴有时时的胃烧。";
            if (![NSString isEmpty:_yuyueDic[@"demand_content"]]) {
                cell.addressStr = _yuyueDic[@"demand_content"];
            }
            return cell;
        }
            break;
        case 2:{
            YMFaBuSubTitleTableViewCell *cell = [[YMFaBuSubTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:faBuSubTitleTableCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleName = @"需求时间:";
            cell.subTitleName = @"请选择时间";
            if (![NSString isEmpty:_demand_time]) {
                cell.subTitleName = _demand_time;
            }
            return cell;
        }
            break;
        case 3:{
            YMCostEscrowCellTableViewCell *cell =[[YMCostEscrowCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:costEscrowCellTableCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleName = @"服务费";
            cell.subText = self.member_aptitude_money;
//            cell.subText = _yuyueDic[@"money"];
//            NSString *placder = [NSString stringWithFormat:@"不得少于%@服务费",self.member_aptitude_money];
//            cell.subTextField.placeholder = placder;
            return cell;
        }
            break;
        case 4:{
            YMRegisteredViewTableViewCell *cell = [[YMRegisteredViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:registeredViewTableCell];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.On = _yuyueDic[@"agent_regist"]?NO:YES;
            cell.feiyong =  @"10";
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self keyboardWillHide];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row ==0) {
        YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 2){
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = self.dateView.frame;
            if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                _reservationDoctorTableView.scrollEnabled = NO;
            }
            else {
                rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                _reservationDoctorTableView.scrollEnabled = YES;
            }
            self.dateView.frame = rect;
        }];
    }
}



#pragma mark - YMTitleAndTextFieldTableViewCellDelegate
-(void)TitleAndTextFieldCell:(YMTitleAndTextFieldTableViewCell *)cell textField:(NSString *)content{
     [_yuyueDic setObject:[NSString isEmpty: content]?@"":content forKey:@"title"];
}

-(void)TitleAndTextFieldCell:(YMTitleAndTextFieldTableViewCell *)cell startEdit:(BOOL )startEdit{

}
#pragma mark - YMContactAddressTableViewCellDelegate
-(void)contactAddress:(YMContactAddressTableViewCell *)contactAddress startEdit:(BOOL)startEdit{

}

-(void)contactaddress:(UITextView *)textView editContent:(NSString *)editContent{
    [_yuyueDic setObject:[NSString isEmpty: editContent]?@"":editContent forKey:@"demand_content"];
}

#pragma mark - YMCostEscrowCellTableViewCellDelegate
-(void)constEscrowCell:(YMCostEscrowCellTableViewCell *)cell textField:(NSString *)content{
     [_yuyueDic setObject:[NSString isEmpty: content]?@"":content forKey:@"money"];
}

-(void)constEscrowCell:(YMCostEscrowCellTableViewCell *)contactAddress startEdit:(BOOL)startEdit{
    
}
#pragma mark - YMRegisteredViewTableViewCellDelegate
-(void)registeredViewCell:(YMRegisteredViewTableViewCell *)registeredViewCell setOn:(BOOL)On{
    
    [_yuyueDic setObject:On?@"10":@"0" forKey:@"agent_regist"];
}

#pragma mark - YMInfoBaseTableViewControllerDelegate
-(void)infoBaseController:(YMInfoBaseTableViewController *)infoBase userInfoModel:(YMUserInfoMemberModel *)informodel{
    [_yuyueDic setObject:informodel.leaguer_id forKey:@"leaguer_id"];
    _leaguer_Name = informodel.leagure_name;
    [_reservationDoctorTableView reloadData];
}


#pragma mark - YMBottomViewDelegate
-(void)bottomView:(YMBottomView *)bottomClick{
//    __weak typeof(self) weakSelf = self;
    NSString *meony = _yuyueDic[@"money"];
    if ([meony floatValue] >=  [self.member_aptitude_money floatValue]) {
        [[KRMainNetTool sharedKRMainNetTool]
         sendRequstWith:@"act=new_order&op=yuyue"
         params:_yuyueDic
         withModel:nil
         waitView:self.view
         complateHandle:^(id showdata, NSString *error) {
             if (showdata == nil) {
                 return ;
             }
             YMNewPlayerViewController *vc = [[YMNewPlayerViewController alloc]init];
             vc.payData = [showdata copy];
             [self.navigationController pushViewController:vc animated:YES];
         }];
        
    }else{
         NSString *placder = [NSString stringWithFormat:@"不得少于%@服务费",self.member_aptitude_money];
        [self.view showErrorWithTitle:placder autoCloseTime:2];
    
    }
    
   
}

-(void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSLog(@"%f",keyboardRect.size.height);
    [_reservationDoctorTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardRect.size.height);
    }];
}
-(void)setMember_aptitude_money:(NSString *)member_aptitude_money{

    _member_aptitude_money = member_aptitude_money;

}

-(void)keyboardWillHide{
    [_reservationDoctorTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
}

-(void)endEditing{
    [self keyboardWillHide];
    [self.view endEditing:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}


@end
