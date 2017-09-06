//
//  YMMingDoctorsActivityViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMingDoctorsActivityViewController.h"
#import "YMActivityBottomView.h"
#import "YMMingDoctorTableViewCell.h"
#import "YMRegisteredViewTableViewCell.h"

#import "YMDoctorActivityModel.h"

#import "YMDropDownView.h"
#import "YMSignUpAndDorctorModel.h"
#import "YMPayView.h"
#import "YMOrderDetailViewController.h"

static NSString *const MingDoctorTableViewCell = @"MingDoctorTableViewCell";

static NSString *const RegisteredViewTableViewCell = @"RegisteredViewTableViewCell";

@interface YMMingDoctorsActivityViewController ()<YMActivityBottomViewDelegate,UITableViewDelegate,UITableViewDataSource,YMRegisteredViewTableViewCellDelegate,YMDropDownViewDelegate>
@property(nonatomic,strong)YMActivityBottomView *bottomView;

@property(nonatomic,strong)UITableView *doctorActivityTableview;
@property(nonatomic,strong)YMDoctorActivityModel *model;

@property(nonatomic,strong)UIView *dateView;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)NSDate *selectDate;//选择的时间

@property(nonatomic,strong)YMDropDownView *dropDownView;

@property(nonatomic,strong)YMSignUpAndDorctorModel *hospitalmodel;

@property(nonatomic,assign)BOOL registeredSwitch;


@end

@implementation YMMingDoctorsActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    self.view.backgroundColor = RGBCOLOR(239, 239, 246);
    [self requrtData];
    [self initVar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [self initBottomView];
    [self initTableView];
}

-(void)initVar{
    _registeredSwitch = YES;
}


-(void)requrtData{
    
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=activities&op=participate"
                                                 params:@{@"member_id":@([[YMUserInfo sharedYMUserInfo].member_id integerValue]),
                                                          @"activity_id":[NSString isEmpty:self.activityId]?@"":self.activityId} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                                                     if (showdata == nil) {
                                                         return ;
                                                     }
                                                      if ([showdata isKindOfClass:[NSDictionary class]]||[showdata isKindOfClass:[NSMutableDictionary class]]) {
                                                          weakSelf.model = [YMDoctorActivityModel modelWithJSON:showdata];
                                                          [weakSelf.doctorActivityTableview reloadData];
                                                      }
    }];
}

-(void)initBottomView{
    _bottomView = [[YMActivityBottomView alloc]init];
    _bottomView.backgroundColor = RGBCOLOR(64, 133, 201);
    _bottomView.bottomTitle = @"提交";
    _bottomView.delegate = self;
    _bottomView.type = BottomActivityType;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

-(void)initTableView{
    _doctorActivityTableview = [[UITableView alloc]init];
    _doctorActivityTableview.delegate = self;
    _doctorActivityTableview.dataSource = self;
    _doctorActivityTableview.backgroundColor = [UIColor clearColor];
    [_doctorActivityTableview registerClass:[YMMingDoctorTableViewCell class] forCellReuseIdentifier:MingDoctorTableViewCell];

    
    [_doctorActivityTableview registerClass:[YMRegisteredViewTableViewCell class] forCellReuseIdentifier:RegisteredViewTableViewCell];
    _doctorActivityTableview.separatorStyle = UITableViewCellSelectionStyleNone;

    [self.view addSubview:_doctorActivityTableview];
    [_doctorActivityTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor = [UIColor clearColor];
    return headerview ;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 60;
    }
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1){
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section !=2 ) {
        YMMingDoctorTableViewCell *cell = [[YMMingDoctorTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MingDoctorTableViewCell];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section ==0) {
            cell.titleName = @"参与对象：";
            cell.subTitleName = _model.leagure_name;
            cell.showImage = YES;
            cell.lastOne = YES;
        }else{
            cell.showImage = NO;
            if (indexPath.row ==1) {
                cell.lineInterval = YES;
                cell.lastOne =YES;
                cell.titleName = @"需求时间：";
                if (_selectDate) {
                    NSDateFormatter *dateformatter = [NSDateFormatter new];
                    dateformatter.dateFormat = @"yyyy年MM月dd日 hh:mm";
                    cell.subTitleName = [dateformatter stringFromDate:_selectDate];
                }else{
                  cell.subTitleName = @"必选";
                }
            }else{
                cell.titleName = @"就诊医院：";
                if (_hospitalmodel) {
                    cell.subTitleName = _hospitalmodel.hospital_name;
                }
                cell.subTitleName = @"非必选";
            }
            
        }
        
        return cell;
    }else{
        YMRegisteredViewTableViewCell *cell = [[YMRegisteredViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisteredViewTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                [self setDateView];
                [self.view endEditing:YES];
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect rect = self.dateView.frame;
                    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                        rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                        self.doctorActivityTableview.scrollEnabled = NO;
                    }
                    else {
                        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                        self.doctorActivityTableview.scrollEnabled = YES;
                    }
                    self.dateView.frame = rect;
                }];
            }
                
                break;
            case 1:{
                
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - YMActivityBottomViewDelegate
-(void)activityBottomView:(YMActivityBottomView *)ActivityBottomView bottomClick:(UIButton *)sender{
    
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd hh:mm";
  NSString *data =  [dateformatter stringFromDate:_selectDate];
    
    NSDictionary *params = @{@"member_id":@([[YMUserInfo sharedYMUserInfo].member_id integerValue]),
                             @"activity_id":@([self.activityId integerValue])?:@0,
                             @"demand_time":![NSString isEmpty:data]?data:@"",
                             @"hospital_id":_hospitalmodel.hospital_id?:@"",
                             @"is_register":_registeredSwitch?@1:@2,
                             };
    
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=activities&op=participateSubmit"
                                                 params:params
                                              withModel:nil
                                               waitView:self.view
                                         complateHandle:^(id showdata, NSString *error) {
                                                              if (showdata == nil) {
                                                                  return ;
                                                              }
                                             NSLog(@"跳支付功能");
                                             
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
                                             
                                                          }
     ];
}

#pragma mark - YMRegisteredViewTableViewCellDelegate
-(void)registeredViewCell:(YMRegisteredViewTableViewCell *)registeredViewCell setOn:(BOOL)On{
    _registeredSwitch = On;
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
    
    cancle.backgroundColor = [UIColor clearColor];
    cancle.tag = 100;
    [cancle addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 50, 0, 50, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tag = 101;
    button.titleLabel.textColor = [UIColor whiteColor];

    UIView *linview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    linview.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview];
    UIView *linview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 1)];
    linview1.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview1];
    [button setTitle:@"确定" forState:UIControlStateNormal];

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
            self.doctorActivityTableview.scrollEnabled = YES;
        }
        self.dateView.frame = rect;
    }];
    
    if (sender.tag == 100) {
        return;
    }
    
    NSDate *date = self.datePicker.date;
    if ([date timeIntervalSinceNow] < 0) {
        [self showErrorWithTitle:@"请选择正确时间" autoCloseTime:2];
        return;
    }
    _selectDate = date;
    [_doctorActivityTableview reloadData];
}

-(void)selectButton:(UIButton *)sender{
    NSLog(@"跳转选择用户界面");
    if (!_dropDownView) {
        _dropDownView = [[YMDropDownView alloc]init];
        _dropDownView.backgroundColor =[UIColor clearColor];
        [self.view addSubview:_dropDownView];
        [_dropDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDropDown:)];
        [_dropDownView addGestureRecognizer:gesture];
        _dropDownView.delegate =self;
    }
    
    if (_model.hospital.count>0) {
        _dropDownView.hidden = NO;
    }else{
        NSLog(@"参选对象为空，是否去添加");
    }
}

-(void)dropDownView:(YMDropDownView *)dropDownView clickModel:(YMSignUpAndDorctorModel *)model{
    _hospitalmodel = model;
}

-(void)hiddenDropDown:(UITapGestureRecognizer *)gesture{
    _dropDownView.hidden = YES;
}

@end
