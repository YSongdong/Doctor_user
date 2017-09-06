//
//  YMGuyongDoctorViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMGuyongDoctorViewController.h"
#import "YMSwitchTableViewCell.h"
#import "YMMoneyTableViewCell.h"
#import "YMInputTableViewCell.h"
#import "YMInputTExtViewTableViewCell.h"
#import "YMPayView.h"
#import "YMOrderDetailViewController.h"

#import "YMUserInfoTableViewController.h"
#import "YMNetWorkTool.h"

@interface YMGuyongDoctorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, strong) NSMutableArray *dataParam;
@property (nonatomic, strong) UIView *dateView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;
@property (nonatomic, assign) NSInteger dateTag;
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation YMGuyongDoctorViewController
{
    BOOL isGuahao;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    isGuahao = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    self.param = [NSMutableDictionary dictionary];
    
    self.dataParam = [NSMutableArray array];
    self.param[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id;
    self.param[@"ktime"] = @"    年  月  日";
    self.param[@"jtime"] = @"    年  月  日";
    self.param[@"store_id"] = self.doctorId;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"YMSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"switch"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YMInputTableViewCell" bundle:nil] forCellReuseIdentifier:@"input"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YMMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"money"];
    self.navigationItem.title = @"预约医生";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self loadData];
    [self setDateView];
}
- (void)setDateView {
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 315)];
    _dateView.backgroundColor = [UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 270)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
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
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=release_hire&op=hire" params:@{@"store_id":self.doctorId} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        NSLog(@"%@",showdata);
        [self.dataParam addObject:@{@"lefttop":@"设置服务费:",@"leftbottom":showdata[@"_hire"][@"physician_name"],@"status":@"1"}];
        [self.dataParam addObject:@{@"lefttop":[NSString stringWithFormat:@"平台挂号费:%@¥",showdata[@"_hire"][@"register"]],@"leftbottom":showdata[@"_hire"][@"register_name"],@"status":@"2"}];
        [self.tableView reloadData];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isGuahao) {
        return 6;
    } else {
        return 5;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 5) {
        return 2;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
            cell.canClick = nil;
            cell.vcType = nil;
            cell.textType = @"10";
            [cell setDetailWithDic:@{@"name":@"需求标题：",@"placeholder":@"请在此填写需求标题（必填）"} dataDic:self.param];
            cell.block = ^(NSString *str) {
                //标题
                self.param[@"demand_sketch"] = str;
            };
            return cell;
        }
            break;
        case 1:
        {
            YMInputTExtViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inputView"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell setUpWithDic:self.param];
            cell.block = ^(NSString *str){
                self.param[@"demand_needs"] = str;
            };
            return cell;
        }
            break;
        case 2:
        {
            YMMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"money"];
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
            break;
        case 3:
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
        case 4:
        {
            YMSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switch"];
            if (self.dataParam.count != 0) {
                [cell setDetailWithDic:self.dataParam[1] andDataDic:self.param];
            }
            cell.block = ^(BOOL isSwitch,NSString *str) {
                //是否挂号费
                self.param[@"register"] = str;
                isGuahao = [str integerValue];
                [self.tableView reloadData];
            };
            return cell;
        }
            break;
        case 5:
        {
            if (indexPath.row == 0) {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.vcType = nil;
                cell.textType = @"8";
                cell.canClick = nil;
                [cell setDetailWithDic:@{@"name":@"个人姓名：",@"placeholder":@"（必填）"} dataDic:self.param];
                cell.block = ^(NSString *str) {
                    //姓名
                    self.param[@"demand_name"] = str;
                };
                return cell;
            } else {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.vcType = nil;
                cell.textType = @"9";
                cell.canClick = nil;
                [cell setDetailWithDic:@{@"name":@"身份证号：",@"placeholder":@"（必填）"} dataDic:self.param];
                cell.block = ^(NSString *str) {
                    //身份证号
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
            break;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
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
    self.tableViewBottom.constant = 0;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
//提交
- (IBAction)tijiaoBtnClick:(id)sender {
    
    __weak __typeof(self)weakSelf = self;
    
    NSLog(@"%@",self.param);
    
//    if ([self.param[@"price"]floatValue] < 200) {
//        [self showErrorWithTitle:@"酬金不得低于200元" autoCloseTime:2];
//        return ;
//    }
//    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
//    tool.isShow = @"2";
    self.param[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id;
    [YMNetWorkTool sendRequstWith:@"act=release_hire&op=demand" params:self.param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
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
            
        }
        
        
        [self showRightWithTitle:@"提交成功" autoCloseTime:1];
        //弹出支付页面
        YMPayView *payView = [[[NSBundle mainBundle]loadNibNamed:@"YMPayView" owner:self options:nil]firstObject];
        payView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        payView.superVC = self;
        payView.block = ^(long long staus) {
            YMOrderDetailViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"orderDetailView"];
            vc.params = @{@"demand_id":@(staus),@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
            [self.navigationController pushViewController:vc animated:YES];
        };
        [payView setDetailMoneyWith:showdata[@"order_list"][@"order_amount"] andData:showdata];
        [self.view.window addSubview:payView];
        [payView setAnimaltion];
        
    }];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}

@end
