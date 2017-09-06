//
//  HealthyHelperViewController.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HealthyHelperViewController.h"

#import "HelperInfoTableViewCell.h"
#import "TakeDrugTableViewCell.h"
#import "RemindTableViewCell.h"
#import "SDPatientDetailTableViewCell.h"

#import "HeadlthyHelperAllModel.h"

#import "TakeDrugFootView.h"
#import "SDTimeCountView.h"



#import "AddHistoryViewController.h"
#import "YMDepartmentSelectionViewController.h"
#import "SDHealthyFilesViewController.h"


#define HELPERINFOTABLEVIEW_CELL  @"HelperInfoTableViewCell"
#define TAKEDRUGTABLEVIEW_CELL    @"TakeDrugTableViewCell"
#define REMINDTABLEVIEW_CELL     @"RemindTableViewCell"
#define SDPATIENTDETAILTABLEVIEW_CELL  @"SDPatientDetailTableViewCell"
@interface HealthyHelperViewController ()<UITableViewDelegate,UITableViewDataSource,TakeDrugFootViewDelegate,TakeDrugTableViewCellDelegate,AddHistoryViewControllerDelegate,SDTimeCountViewDelegate,RemindTableViewCellDelegate,YMDepartmentSelectionViewControllerDelegate,HelperInfoTableViewCellDelegate>

@property(nonatomic,strong) UITableView *heplerTableView;
@property(nonatomic,strong) HeadlthyHelperAllModel *model;

@property(nonatomic,strong) NSMutableArray *drugArr;//药品数组
@property(nonatomic,strong) NSMutableArray *reminArr;//提醒数组
@property(nonatomic,strong) NSMutableArray *historyArr;
@property(nonatomic,assign) NSInteger cellPage;

@property(nonatomic,strong) TakeDrugFootView *drugFootView; //footView嘱咐

@property (nonatomic,strong) NSIndexPath *redIndexPath; //记录IndexPath

@property (nonatomic,strong) NSMutableDictionary *remindParams; //提醒配置
@property (nonatomic,strong) NSMutableDictionary *drugParams;  //用药配置
@property (nonatomic,strong)UIView *dateView; //时间选择器view
@property (nonatomic,strong)UIDatePicker *datePicker; //时间选择器
@property (nonatomic,assign) BOOL isSelectd;

@property (nonatomic,assign) BOOL isAlterKs; //科室是否修改

//@property (nonatomic,strong) SDRemind *sdRemind; //plist文件

@property(nonatomic,assign) BOOL isDurgAdd; //是否添加药品
@property(nonatomic,assign) BOOL isReminAdd; //是否添加提醒



@end

@implementation HealthyHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"健康助手";
    self.isSelectd = YES;
    self.isAlterKs = NO;
    [self initTableView];
    [self requestHealthyHelperData];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)initTableView
{
    self.heplerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.heplerTableView];
    self.heplerTableView.dataSource = self;
    self.heplerTableView.delegate = self;
    self.heplerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.heplerTableView registerNib:[UINib nibWithNibName:HELPERINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:HELPERINFOTABLEVIEW_CELL];
    [self.heplerTableView registerNib:[UINib nibWithNibName:TAKEDRUGTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:TAKEDRUGTABLEVIEW_CELL];
    [self.heplerTableView registerNib:[UINib nibWithNibName:REMINDTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:REMINDTABLEVIEW_CELL];
    [self.heplerTableView registerNib:[UINib nibWithNibName:SDPATIENTDETAILTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDPATIENTDETAILTABLEVIEW_CELL];
}
#pragma mark   -- UITableViewSoucre -- 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 4;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return _drugArr.count;
    }else if (section == 2) {
        return _reminArr.count;
    }else{
        return _historyArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        HelperInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HELPERINFOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model.mealth;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1) {
        TakeDrugTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TAKEDRUGTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate= self;
        cell.indexPath = indexPath;
        headlthyDetailModel *detaModel = _drugArr[indexPath.row];
        cell.model =detaModel;
        //判断是否是添加
        if (self.isDurgAdd) {
            if (indexPath.row == self.drugArr.count-1) {
                cell.isAdd = YES;
                self.isDurgAdd = NO;
            }else{
                cell.isAdd = NO;
            }
        }
       
        return cell;
    }else if (indexPath.section == 2) {
        //提醒
        RemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REMINDTABLEVIEW_CELL forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        HeadlMedicalModel *model = _reminArr[indexPath.row];
        cell.model= model;
        cell.indexPath = indexPath;
        //判断是否是添加
        if (self.isReminAdd) {
            if (indexPath.row == self.reminArr.count-1) {
                cell.isAdd = YES;
                self.isReminAdd = NO;
            }else{
                cell.isAdd = NO;
            }
        }
        return cell;
    }else{
        SDPatientDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDPATIENTDETAILTABLEVIEW_CELL forIndexPath:indexPath];
         healthHistModel *model = _historyArr[indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.model = model;
        
        return cell;
    }

}

#pragma mark -- UITableViewDelegate----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 104;
    }else if (indexPath.section == 1) {
        return 125;
    }else if (indexPath.section == 2){
        return 280;
    }else{
        healthHistModel *model = _historyArr[indexPath.row];
        return [SDPatientDetailTableViewCell caseDetailViewHeight:model];
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1f;
    }else  if (section == 1) {
        return 150.f;
    }else if (section == 2){
        return 50.f;
    }else{
       return 0.1f;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1f;
    }else if (section == 3){
        return 45.f;
    }else{
        return 10.f;
    }
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (section == 3) {
        UIView *historyView = [[UIView alloc]init];
        historyView.backgroundColor = [UIColor whiteColor];
        UILabel  *label = [[UILabel alloc]init];
        label.text = @"就医历史";
        label.textColor  =[UIColor btnBlueColor];
        label.font = [UIFont systemFontOfSize:15];
        [historyView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(historyView.mas_left).offset(40);
            make.centerY.equalTo(historyView.mas_centerY);
        }];
        
        //新增历史
        UIButton *addHistBtn = [[UIButton alloc]init];
        [historyView addSubview:addHistBtn];
        [addHistBtn setTitle:@"新增历史" forState:UIControlStateNormal];
        addHistBtn.titleLabel.font =[UIFont systemFontOfSize:12];
        [addHistBtn setTitleColor:[UIColor btnBlueColor] forState:UIControlStateNormal];
        addHistBtn.layer.borderWidth = 1;
        addHistBtn.layer.borderColor  = [UIColor btnBlueColor].CGColor;
        [addHistBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(historyView.mas_right);
            make.centerY.equalTo(label.mas_centerY);
            make.width.equalTo(@68);
        }];
        addHistBtn.layer.masksToBounds = YES;
        addHistBtn.layer.cornerRadius = 13;
        [addHistBtn addTarget:self action:@selector(addHistoryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return historyView;
    }else{
        UIView *headerView = [[UIView alloc]init];
        headerView.backgroundColor = [UIColor cellBackgrounColor];
        return headerView;
    }
   
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        self.drugFootView = [[[NSBundle mainBundle]loadNibNamed:@"TakeDrugFootView" owner:nil options:nil]lastObject];
        self.drugFootView.delegate = self;
        self.drugFootView.model = self.model.health_medication;
        if (![self.model.health_medication.orders isEqualToString:@""]) {
            self.drugFootView.showPlaceLabel.hidden = YES;
        }
      
      return self.drugFootView;
    }
    if (section == 2) {
        UIView *remindFootView = [[UIView alloc]init];
        remindFootView.backgroundColor = [UIColor whiteColor];
        UIButton *remindAddBtn = [[UIButton alloc]init];
        remindAddBtn.layer.borderWidth = 1;
        remindAddBtn.layer.borderColor = [UIColor btnBroungColor].CGColor;
        remindAddBtn.layer.cornerRadius = 5;
        remindAddBtn.layer.masksToBounds = YES;
        [remindAddBtn setTitle:@" 新增提醒" forState:UIControlStateNormal];
        [remindAddBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
        [remindAddBtn setImage:[UIImage imageNamed:@"healthy_add"] forState:UIControlStateNormal];
        [remindFootView addSubview:remindAddBtn];
        [remindAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(remindFootView.mas_top).offset(5);
            make.left.equalTo(remindFootView.mas_left).offset(5);
            make.bottom.equalTo(remindFootView.mas_bottom).offset(-5);
            make.right.equalTo(remindFootView.mas_right).offset(-5);
        }];
        [remindAddBtn addTarget:self action:@selector(remindBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        return remindFootView;
    }
   
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
   

}
#pragma mark  --- 点击按钮事件 ----

//点击健康档案  --HelperInfoTableViewCellDelegate--
-(void)selectdHealtheFilesBtnAction{
    self.hidesBottomBarWhenPushed = YES; 
    SDHealthyFilesViewController *healthyFilesVC = [[SDHealthyFilesViewController alloc]init];
    healthyFilesVC.member_id = self.model.mealth.member_id;
    [self.navigationController pushViewController:healthyFilesVC animated:YES];

}
//点击添加药品
-(void)selectdAddTakeDrugBtn
{
    headlthyDetailModel  *detaModel = [[headlthyDetailModel alloc]init];
    detaModel.second = @"";
    detaModel.day = @"";
    detaModel.drug =@"";
    detaModel.warn_id  = @"";
    [self.drugArr addObject:detaModel];
    self.isDurgAdd = YES;
    [self.heplerTableView reloadData];
}
//保存FootView用药嘱咐
-(void)selectdSaveBtnAction:(NSDictionary *)dic{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"member_id"] = self.model.mealth.member_id;
    param[@"health_id"] = self.model.mealth.health_id;
    [param addEntriesFromDictionary:dic];
    [self requestAlterDurgData:param.copy];

}
// --------------用药嘱咐开关提醒-------
-(void)selectdSwichBtnAction:(NSString *)sound{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"member_id"] = self.model.mealth.member_id;
    param[@"sound"] = sound;
    param[@"medication_id"] = self.model.health_medication.medication_id;
    [self requestSwichDurgData:param.copy];

}

//删除添加药品
-(void)selectdDeleteBtn:(NSIndexPath *)delIndexPath andWarnID:(NSString *)warnID
{
 
    if ([warnID isEqualToString:@""]) {
        
        [_drugArr removeObjectAtIndex:delIndexPath.row];
        [self.heplerTableView deleteRowAtIndexPath:delIndexPath withRowAnimation:UITableViewRowAnimationRight];
        [self.heplerTableView reloadData];
        
    }else{
        
      [self requesDelDurgData:delIndexPath andWarnID:warnID];
        
    }
    
}
//选择时间和次数
-(void)selectdTimeBtnAction:(NSIndexPath *)indexPath{
    
     [self createTimeCounViewIndexPath:indexPath];
}

//点击保存按钮
-(void)selectdSaveBtnAction:(NSDictionary *)dic andIndexPath:(NSIndexPath *)indexPath{
    [self.drugParams addEntriesFromDictionary:dic];
    self.drugParams[@"member_id"] = self.model.mealth.member_id;
    
    headlthyDetailModel *model = _drugArr[indexPath.row];
    self.drugParams[@"warn_id"] = model.warn_id;
    //保存数据
    [self requseSaveDurgData:indexPath];
    
    [self.view endEditing:YES];
}
#pragma mark  --- 选择时间次数弹框-----
-(void)createTimeCounViewIndexPath:(NSIndexPath *)indexPath{

    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet] ;
     [alterVC addAction:[UIAlertAction actionWithTitle:@"一日一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         TakeDrugTableViewCell *cell= [self.heplerTableView cellForRowAtIndexPath:indexPath];
         cell.timeCountLabel.text = @"一日一次";
     }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"一日二次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TakeDrugTableViewCell *cell= [self.heplerTableView cellForRowAtIndexPath:indexPath];
        cell.timeCountLabel.text = @"一日二次";
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"一日三次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TakeDrugTableViewCell *cell= [self.heplerTableView cellForRowAtIndexPath:indexPath];
        cell.timeCountLabel.text = @"一日三次";
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];

    [self presentViewController:alterVC animated:YES completion:nil];
}

//  ----  SDTimeCountViewDelegate ----
//选择时间次数
-(void)selectdBtnTitle:(NSString *)title andIndexPath:(NSIndexPath *)indexPath
{
    TakeDrugTableViewCell *cell= [self.heplerTableView cellForRowAtIndexPath:indexPath];
    cell.timeCountLabel.text = title;
    
}
#pragma mark  --- 提醒 ----
//删除
-(void)selectdDelRemindBtnAction:(NSIndexPath *)indexPath andMedicalID:(NSString *)medicaiID
{

    if ([medicaiID isEqualToString:@""]) {
        
        [_reminArr removeObjectAtIndex:indexPath.row];
        [self.heplerTableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationRight];
        [self.heplerTableView reloadData];
    
    }else{
        [self requestDelReminData:indexPath andMedicalID:medicaiID];

    }
 
}
//保存
-(void)selectdSaveBtnAction:(NSIndexPath *)saveIndexPath andNSDict:(NSDictionary *)dic{
    [self.remindParams addEntriesFromDictionary:dic];
    self.remindParams[@"member_id"] = self.model.mealth.member_id;
    self.remindParams[@"health_id"] = self.model.mealth.health_id;
    
    HeadlMedicalModel *model = _reminArr[saveIndexPath.row];
    if (!self.isAlterKs) {
        self.remindParams[@"big_ks"] =model.big_ks;
        self.remindParams[@"small_ks"] =model.small_ks;
    }
    [self.remindParams addEntriesFromDictionary:dic];
    self.remindParams[@"is_open"] = @"0";
    [self requestRemindData:saveIndexPath];

}

//选择时间
-(void)selectdRemindTimeBtnAction:(NSIndexPath *)indexPath{
    
    if (self.isSelectd) {
        [self setDateView];
        //记录indexPath
        self.redIndexPath = indexPath;
    }else{
        [_dateView removeFromSuperview];
    }
    self.isSelectd = !self.isSelectd;
   
}
//选择科室
-(void)selectdDepBtnAction:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    YMDepartmentSelectionViewController *vc = [[YMDepartmentSelectionViewController alloc]init];
    vc.delegate = self;
    vc.hiddentopView = YES;
    //记录indexPath
    self.redIndexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setRedIndexPath:(NSIndexPath *)redIndexPath{

    _redIndexPath = redIndexPath;

}

#pragma mark - YMDepartmentSelectionViewControllerDelegate
-(void)departmentView:(YMDepartmentSelectionViewController *)departmentView  disorder:(NSString *)disorder ename:(NSString *)ename big_ks:(NSString*)big_ks{
    NSLog(@"大科室disorder%@:小科室disorder:%@:ename%@",disorder,big_ks,ename);
    
    self.remindParams[@"big_ks"] =big_ks;
    self.remindParams[@"small_ks"] =disorder;
    self.isAlterKs = YES;
    RemindTableViewCell *cell = [self.heplerTableView cellForRowAtIndexPath:self.redIndexPath];
    cell.departmentLabel.text = ename;
    
}
//关闭弹框
-(void)closeRmoveView{
    
    [_dateView removeFromSuperview];
    self.isSelectd= YES;

}
//添加提醒
-(void)remindBtnAction:(UIButton *)sender
{
    HeadlMedicalModel *model  = [[HeadlMedicalModel alloc]init];
    model.doctor = @"";
    model.big_ks = @"";
    model.small_ks = @"";
    model.small_ksh = @"请 选 择";
    model.remarks = @"";
    model.doctor_time = @"请 选 择";
    model.medical_id = @"";
    model.is_open = @"1";
    [self.reminArr addObject:model];
    self.isReminAdd = YES;
    [self.heplerTableView reloadData];
    
}

//添加历史
-(void)addHistoryBtnAction:(UIButton *) sedner 
{
    self.hidesBottomBarWhenPushed = YES;
    AddHistoryViewController *addHistVC = [[AddHistoryViewController alloc]init];
    addHistVC.delegate = self;
    addHistVC.health_id = self.model.mealth.health_id;
    addHistVC.member_id = self.model.mealth.member_id;
    [self.navigationController pushViewController:addHistVC animated:YES];

}

//--------新增就医历史保存按钮----------
-(void)selectdSaveBtn:(NSDictionary *)data{
   
//    healthHistModel *model =  [[healthHistModel alloc]init];
//    model.history_time = data[@"history_time"];
//    model.title = data[@"title"];
//    model.history_id = @"";
//    model.history_image = data[@"history_image"];
//    [_historyArr insertObject:model atIndex:0];
  //  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
   // [self.heplerTableView insertRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationBottom];
   
    [_historyArr removeAllObjects];
    [_reminArr removeAllObjects];
    [_drugArr removeAllObjects];
    [self requestHealthyHelperData];
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    [self.heplerTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}
#pragma mark   --  创建时间选择器 ----
- (void)setDateView {
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-315, [UIScreen mainScreen].bounds.size.width, 315)];
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
        
        RemindTableViewCell *cell = [self.heplerTableView cellForRowAtIndexPath:self.redIndexPath];
        cell.timeLabel.text = [dateformatter1 stringFromDate:date];
    }
    
}

#pragma mark --- 数据相关 ------
//--------请求健康助手---------
-(void) requestHealthyHelperData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id;
   // params[@"medication_id"] = [YMUserInfo sharedYMUserInfo].medication_id;
    [[KRMainNetTool sharedKRMainNetTool] sendNowRequstWith:HealthIndex_Url params:params.copy withModel:nil waitView:self.view  complateHandle:^(id showdata, NSString *error) {
        NSLog(@"-----%@",showdata);
        if (!error) {
            
            weakSelf.model = [HeadlthyHelperAllModel modelWithDictionary:showdata];
            
            //就医历史
            NSArray *histArr = showdata[@"health_history"];
            if (![histArr isKindOfClass:[NSNull class]]) {
                if (histArr.count > 0) {
                    for (NSDictionary *detaDic in histArr) {
                        healthHistModel *model = [healthHistModel  modelWithDictionary:detaDic];
                        [weakSelf.historyArr addObject:model];
                    }
                }
            }
              //用药
            NSDictionary *medicDic = showdata[@"health_medication"];
            if (![medicDic isKindOfClass:[NSNull class]]) {
                NSArray *detailArr = medicDic[@"detail"];
                if (detailArr.count > 0 ) {
                    for (NSDictionary *detaDic in detailArr) {
                        headlthyDetailModel *model = [headlthyDetailModel  modelWithDictionary:detaDic];
                        [weakSelf.drugArr addObject:model];
                        
                    }
                }
                
            }

            //就医提醒
             NSArray *medicArr = showdata[@"health_medical"];
            if (![medicArr isKindOfClass:[NSNull class]]) {
              if (medicArr.count > 0) {
                  for (NSDictionary *detaDic in medicArr) {
                      HeadlMedicalModel *model = [HeadlMedicalModel  modelWithDictionary:detaDic];
                      [weakSelf.reminArr addObject:model];
                      
                  }
              }
             }
            
            [weakSelf.heplerTableView reloadData];
            
        }else{
            
            //定义需要加载动画的HUD
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
    
        }
        
    }];

}
//---------保存用药--------------
-(void)requseSaveDurgData:(NSIndexPath *)indexPath{

    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] upLoadNewData:HealthyAdd_med_Url params:self.drugParams.copy andData:nil complateHandle:^(id showdata, NSString *error) {
        if (!error) {
         
            
            TakeDrugTableViewCell *cell =[weakSelf.heplerTableView cellForRowAtIndexPath:indexPath];
            //改变保存状态
            cell.isAdd = NO;
            //改变值
            headlthyDetailModel *model = _drugArr[indexPath.row];
            model.drug = showdata[@"drug"];
            model.day = weakSelf.drugParams[@"day"];
            model.second = weakSelf.drugParams[@"second"];
            model.warn_id =showdata[@"warn_id"];
            model.medication_time =showdata[@"end_time"];
            
            self.drugFootView.isSave = YES;
            
        }else{
           
            //定义需要加载动画的HUD
             [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];

}
//-----------删除用药-------
-(void) requesDelDurgData:(NSIndexPath *)indexPath andWarnID:(NSString *)warnID{
     __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"member_id"] = self.model.mealth.member_id;
    param[@"warn_id"] = warnID;
    [[KRMainNetTool sharedKRMainNetTool] upLoadNewData:HealthyDel_Url params:param.copy andData:nil complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            [_drugArr removeObjectAtIndex:indexPath.row];
            [weakSelf.heplerTableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationRight];
            [weakSelf.heplerTableView reloadData];
        
        }else{
            //定义需要加载动画的HUD
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
    }];
    
}
//-------------修改嘱咐---------
-(void)requestAlterDurgData:(NSDictionary *)dic{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendNowRequstWith:HealthyAlterMed_Url params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            weakSelf.drugFootView.isSave = YES;
            [weakSelf.view showRightWithTitle:@"修改成功" autoCloseTime:2];
        }else{
            //定义需要加载动画的HUD
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];

}
//-------------修改用药提醒开关--------
-(void)requestSwichDurgData:(NSDictionary *)dic{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendNowRequstWith:HealthySound_Url params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
           // weakSelf.drugFootView.isSave = YES;
           // [weakSelf.view showRightWithTitle:@"修改成功" autoCloseTime:2];
        }else{
            //定义需要加载动画的HUD
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];
    
}

// ------------保存提醒------------
-(void)requestRemindData:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] upLoadNewData:HealthyMedical_Url params:self.remindParams.copy andData:nil complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            RemindTableViewCell *cell =[weakSelf.heplerTableView cellForRowAtIndexPath:indexPath];
           
            //改变值
            HeadlMedicalModel *model = _reminArr[indexPath.row];
            model.doctor = self.remindParams[@"doctor"];
            model.doctor_time = self.remindParams[@"doctor_time"];
            model.remarks = self.remindParams[@"remarks"];
            model.small_ks = self.remindParams[@"small_ks"];
            model.big_ks = self.remindParams[@"big_ks"];
            model.small_ksh = cell.departmentLabel.text;
            weakSelf.isAlterKs = NO;
            //改变保存状态
            cell.isAdd = NO;
            
        }else{
            //定义需要加载动画的HUD
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];
}



//-----------删除就医提醒-----------
-(void)requestDelReminData:(NSIndexPath *)indexPath andMedicalID:(NSString *)medicalID{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"member_id"] = self.model.mealth.member_id;
    param[@"medical_id"] = medicalID;
   [[KRMainNetTool sharedKRMainNetTool] sendNowRequstWith:HealthyMedlicalDel_Url params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
       if (!error) {
           [_reminArr removeObjectAtIndex:indexPath.row];
           [weakSelf.heplerTableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationRight];
           [weakSelf.heplerTableView reloadData];
           
       }else{
           //定义需要加载动画的HUD
           [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
       }
       
   }];
    


}

#pragma mark  ----- 数组赖加载 -----
-(HeadlthyHelperAllModel *)model{

    if (!_model) {
        _model = [[HeadlthyHelperAllModel alloc]init];
    }
    return _model;

}
-(NSMutableArray *)drugArr
{
    if (!_drugArr) {
        _drugArr = [NSMutableArray array];
    }
    return _drugArr;

}
-(NSMutableArray *)reminArr
{

    if (!_reminArr) {
        _reminArr = [NSMutableArray array];
    }
    return _reminArr;
}
-(NSMutableArray *)historyArr
{

    if (!_historyArr) {
        _historyArr = [NSMutableArray array];
    }
    return _historyArr;

}
-(NSMutableDictionary *)drugParams{

    if (!_drugParams) {
        _drugParams = [NSMutableDictionary dictionary];
    }
    return _drugParams;

}
-(NSMutableDictionary *)remindParams{

    if (!_remindParams) {
        _remindParams = [NSMutableDictionary dictionary];
    }
    return _remindParams;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
