//
//  YMMingyiViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//
#import "YMMingyiViewController.h"
#import "YMSwitchTableViewCell.h"
#import "YMMoneyTableViewCell.h"
#import "YMInputTableViewCell.h"
#import "YMInputTExtViewTableViewCell.h"
#import "KRShengTableViewController.h"
#import "AddressPickerView.h"
#import "YMPayView.h"
#import "DepartmentsView.h"
#import "YMOrderDetailViewController.h"

#import "YMUserInfoTableViewController.h"
#import "YMNetWorkTool.h"

@interface YMMingyiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, strong) NSMutableArray *dataParam;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;
@property (nonatomic, strong) NSDictionary *myData;
@property (nonatomic, strong) NSArray *sortArray;
@property (nonatomic, assign) NSInteger dateTag;
@property (nonatomic, strong) NSDictionary *sortDic;

@end

@implementation YMMingyiViewController
{
    BOOL isGuahao;
    CGFloat lowestPrice ;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    isGuahao = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"YMSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"switch"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YMMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"money"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YMInputTableViewCell" bundle:nil] forCellReuseIdentifier:@"input"];
    self.param = [NSMutableDictionary dictionary];
    self.param[@"ktime"] = @"0000年00月00日";
    self.param[@"jtime"] = @"0000年00月00日";
    self.param[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id;
    self.dataParam = [NSMutableArray array];
    //[self.dataParam addObject:@{@"lefttop":@"设置酬金:",@"leftbottom":@"注：执业医师最低酬金不得少于¥300.00",@"status":@"1"}];
    //[self.dataParam addObject:@{@"lefttop":[NSString stringWithFormat:@"平台挂号费:10.00¥"],@"leftbottom":@"平台代挂号收取服务费，可选择自行医保挂普通号",@"status":@"2"}];
    self.navigationItem.title = @"鸣医";
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addreeeChoice:) name:@"selectedAddress" object:nil];
    [self setDateView];
    [self loadData];
    [self loadOtherData];
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=release&op=hire" params:nil withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        NSLog(@"%@",showdata);
        if (showdata == nil) {
            return ;
        }
        [self.dataParam addObject:@{@"lefttop":@"设置服务费:",@"leftbottom":showdata[@"register"][@"register_title"],@"status":@"1"}];
        [self.dataParam addObject:@{@"lefttop":[NSString stringWithFormat:@"平台挂号费:%@¥",showdata[@"register"][@"register"]],@"leftbottom":showdata[@"register"][@"register_name"],@"status":@"2"}];
        self.myData = [showdata copy];
        [self.tableView reloadData];
    }];
    
}
- (void)loadOtherData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=doctor_personal&op=sys_enum" params:nil withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        NSLog(@"%@",showdata);
        if (showdata == nil) {
            return ;
        }
        self.sortArray = [showdata[@"departments"] copy];
        self.sortDic = [showdata copy];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)addreeeChoice:(NSNotification *)notify {
    NSLog(@"%@",notify.object);
    self.param[@"area_id"] = notify.object[@"area_id"];
    self.param[@"area_name"] = notify.object[@"area_name"];
    [self.tableView reloadData];
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
            self.tableView.scrollEnabled = YES;
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
        dateformatter.dateFormat = @"yyyy年MM月dd日";
        NSDateFormatter *dateformatter1 = [NSDateFormatter new];
        dateformatter1.dateFormat = @"yyyy-MM-dd";
        if (self.dateTag == 1) {
            self.param[@"ktime"] = [dateformatter stringFromDate:date];
            self.param[@"ktimes"] = [dateformatter1 stringFromDate:date];
            
        } else {
            self.param[@"jtime"] = [dateformatter stringFromDate:date];
            self.param[@"jtimes"] = [dateformatter1 stringFromDate:date];
        }
        [self.tableView reloadData];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isGuahao) {
        return 8;
    } else {
        return 7;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
           return 2;
        }
            break;
        case 4:
        {
            return 1;
        }
            break;
        case 5:
        {
            return 1;
        }
            break;
        case 6:
        {
            return 1;
        }
            break;
        case 7:
        {
            return 2;
        }
            break;
            
        default:
            return 0;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
            cell.canClick = @"1";
            cell.vcType = @"2";
            cell.textType = @"4";
            [cell setDetailWithDic:@{@"name":@"选择类目：",@"placeholder":@"必选"} dataDic:self.param];
            cell.block = ^(NSString *str) {
                //标题
                self.param[@"demand_sketch"] = str;
            };
            return cell;
            
        }
            break;
        case 1:
        {
            YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
            cell.canClick = nil;
            cell.vcType = nil;
            cell.textType = @"10";
            [cell setDetailWithDic:@{@"name":@"需求标题：",@"placeholder":@"必填"} dataDic:self.param];
            cell.block = ^(NSString *str) {
                //标题
                self.param[@"demand_sketch"] = str;
            };
            return cell;
        }
            break;
        case 2:
        {
            YMInputTExtViewTableViewCell *inputView = [tableView dequeueReusableCellWithIdentifier:@"inputView"];
            
            [inputView setUpWithDic:self.param];
            inputView.block = ^(NSString *str){
                
                self.param[@"demand_needs"] = str;
            };
            return inputView;
            
            
        }
            break;
        case 3:
        {
            if (indexPath.row == 0) {
                YMMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"money"];
                cell.vcType = @"1";
                [cell setTimeWithDic:self.param];
                typeof(self) weakSelf = self;
                cell.block = ^(NSInteger clickTag) {
                    [weakSelf.view endEditing:YES];
                    switch (clickTag) {
                        case 1:
                        {
                            //开始
                            self.dateTag = clickTag;
                            
                        }
                            break;
                            
                        default:
                        {
                            //结束
                            self.dateTag = clickTag;
                        }
                            break;
                    }
                    [self.view endEditing:YES];
                    [UIView animateWithDuration:0.2 animations:^{
                        CGRect rect = self.dateView.frame;
                        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                            self.tableView.scrollEnabled = NO;
                        }
                        else {
                            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                            self.tableView.scrollEnabled = YES;
                        }
                        self.dateView.frame = rect;
                    }];
                };
                return cell;
            }
            else {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.canClick = @"1";
                cell.vcType = @"1";
                cell.textType = @"1";
                [cell setDetailWithDic:@{@"name":@"就诊区域：",@"placeholder":@"点击选择"} dataDic:self.param];
                
                return cell;
            }
            
            
        }
            break;
        case 4:
        {
//            if (indexPath.row == 0) {
//                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
//                cell.canClick = @"1";
//                cell.vcType = @"1";
//                cell.textType = @"2";
//                [cell setDetailWithDic:@{@"name":@"商家筛选：",@"placeholder":@"必填"} dataDic:self.param];
//                
//                return cell;
//            } else {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.canClick = @"1";
                cell.vcType = @"1";
                cell.textType = @"3";
                [cell setDetailWithDic:@{@"name":@"职称筛选：",@"placeholder":@"必填"} dataDic:self.param];
                
                return cell;
            //}
           
        }
            break;
        case 5:
        {
            YMSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switch"];
            if (self.dataParam.count != 0) {
                [cell setDetailWithDic:self.dataParam[0] andDataDic:self.param];
            }
            
            cell.block = ^(BOOL isSwitch,NSString *str) {
                //酬金
                self.param[@"price"] = str;
            };

            return cell;
            
        }
            break;
        case 6:
        {
            YMSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switch"];
            if (self.dataParam.count != 0) {
                [cell setDetailWithDic:self.dataParam[1] andDataDic:self.param];
            }
            
            cell.block = ^(BOOL isSwitch,NSString *str) {
                //酬金
                NSLog(@"%@",self.param);
                self.param[@"register"] = str;
                isGuahao = [str integerValue];
                [self.tableView reloadData];
                
            };

            return cell;
        }
            break;
        case 7:
        {
            
            if (indexPath.row == 0) {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.vcType = nil;
                cell.textType = @"8";
                cell.canClick = nil;
                [cell setDetailWithDic:@{@"name":@"个人姓名：",@"placeholder":@"必填"} dataDic:self.param];
                cell.block = ^(NSString *str) {
                    //标题
                    self.param[@"demand_name"] = str;
                };
                return cell;
            } else {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.vcType = nil;
                cell.textType = @"9";
                cell.canClick = nil;
                [cell setDetailWithDic:@{@"name":@"身份证号：",@"placeholder":@"必填"} dataDic:self.param];
                cell.block = ^(NSString *str) {
                    //标题
                    if ([self verifyIDCardNumber:str]) {
                        self.param[@"demand_sid"] = str;
                    } else {
                        [self showErrorWithTitle:@"请输入正确身份证号" autoCloseTime:2];
                        [self.tableView reloadData];
                    }
                };
                return cell;
            }
            
        }
            break;
            
        default:
            return nil;
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //选择类目
        
            DepartmentsView *departView = [DepartmentsView DepartmentsViewWithDic:self.sortArray];
            departView.viewOffsetX = 150;
            departView.start_y = 0;
            [departView showOnSuperView:self.view subViewStartY:0];
            __weak typeof(self)weakSelf = self ;
            //request data
            departView.block = ^(id dic,NSString *departID) {
                weakSelf.param[@"demand_aid"] = dic[@"disorder"];
                weakSelf.param[@"demand_aid_name"] = dic[@"ename"];
                [weakSelf.tableView reloadData];
                //[weakSelf.headView setTitle:dic[@"ename"]];
                //[weakSelf.dicParams setObject:dic[@"disorder"] forKey:@"k"];
                //[weakSelf selectedRequest];
            };
    
        
    } else if (indexPath.section == 3) {
        if (indexPath.row == 1) {
            //选择地址
            KRShengTableViewController *controller = [[KRShengTableViewController alloc]init];
            controller.type = districtTypeProvince ;
            [self.navigationController pushViewController:controller animated:YES];
        }
    } else if (indexPath.section == 4) {
//        if (indexPath.row == 0) {
//            //找医生
//            AddressPickerView *address = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200) andType:1];
//            
//            NSMutableArray *mut = [NSMutableArray array];
//            NSArray *newArray = self.myData[@"_hire"];
//            for (NSDictionary *dic in newArray) {
//                [mut addObject:@{@"name":dic[@"type"],@"id":dic[@"id"]}];
//            }
//            address.block = ^(NSDictionary *dic) {
//                self.param[@"demand_genre"] = dic[@"id"];
//                self.param[@"demand_genre_name"] = dic[@"name"];
//                [self.tableView reloadData];
//            };
//            address.dataList = [mut copy];
//            [self.view addSubview:address];
//            [address open];
//        } else {
            //助理医生
            AddressPickerView *address = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200) andType:1];
            
            NSMutableArray *mut = [NSMutableArray array];
            NSArray *newArray = self.sortDic[@"doctor_type"];
            for (NSDictionary *dic in newArray) {
                [mut addObject:@{@"name":dic[@"ename"],@"id":dic[@"disorder"],@"money":dic[@"tariff"]}];
            }
            address.block = ^(NSDictionary *dic) {
                self.param[@"seniority"] = dic[@"id"];
                self.param[@"seniority_name"] = dic[@"name"];
                [self.dataParam removeAllObjects];
                [self.dataParam addObject:@{@"lefttop":@"设置服务费:",@"leftbottom":[NSString stringWithFormat:@"注：%@最低酬金不得少于¥%@",dic[@"name"],dic[@"money"]],@"status":@"1"}];
                [self.dataParam addObject:@{@"lefttop":[NSString stringWithFormat:@"平台挂号费:%@¥",self.myData[@"register"][@"register"]],@"leftbottom":self.myData[@"register"][@"register_name"],@"status":@"2"}];
                lowestPrice = [dic[@"money"]floatValue];
                [self.tableView reloadData];
            };
            address.dataList = [mut copy];
            [self.view addSubview:address];
            [address open];
        //}
    }
}
- (IBAction)finishBtnClick:(UIButton *)sender {
    
     __weak __typeof(self)weakSelf = self;
    
    if ([self.param[@"price"]floatValue] <lowestPrice) {
        
        [self showErrorWithTitle:@"酬金不得低于最低价格" autoCloseTime:2];
        return ;
    }
    [YMNetWorkTool sendRequstWith:@"act=release&op=demand" params:self.param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"hahhahhha %@",showdata);
        if (showdata == nil) {
            return ;
        }
        if ([showdata isKindOfClass:[NSString class]]) {
            if ([showdata isEqualToString: @"1"]) {
                
                //隐私资料
                YMUserInfoTableViewController *vc = [MAIN_STORBOARD instantiateViewControllerWithIdentifier:@"userInfoView"];
                vc.vcType = @"2";
                vc.block = ^(NSString * name,NSString * idNum){
                    NSLog(@"fhhklffghjkkl==%@..%@",name,idNum);
                    
                    self.param[@"demand_name"] = name;
                    self.param[@"demand_sid"] = idNum;
                    [self.tableView reloadData];
        };
                [weakSelf.navigationController pushViewController:vc animated:YES];
                return;
            }
        }

        if ([showdata isKindOfClass:[NSDictionary class]]) {
            [self showRightWithTitle:@"提交成功" autoCloseTime:1];
            YMPayView *payView = [[[NSBundle mainBundle]loadNibNamed:@"YMPayView" owner:self options:nil]firstObject];
            payView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            payView.block = ^(long long staus) {
                YMOrderDetailViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"orderDetailView"];
                vc.params = @{@"demand_id":@(staus),@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
                [self.navigationController pushViewController:vc animated:YES];
            };
            payView.superVC = self;
            [payView setDetailMoneyWith:showdata[@"order_list"][@"order_amount"] andData:showdata];
            [self.view.window addSubview:payView];
            [payView setAnimaltion];
        }
        
        
    }];
}

-(void)getuserInfo{
    NSString * path = @"act=users_personal&op=privates";
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:path params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.myData = [showdata mutableCopy];
        
        [self.tableView reloadData];
    }];

}



#pragma mark - 键盘事件

- (void)openKeyBoard:(NSNotification *)notification {
    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableViewBottom.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (void)closeKeyBoard:(NSNotification *)notification {
    
    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    self.tableViewBottom.constant = 50;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}

@end
