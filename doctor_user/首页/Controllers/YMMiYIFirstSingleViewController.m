//
//  YMMiYIFirstSingleViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMiYIFirstSingleViewController.h"
#import "YMActivityBottomView.h"
#import "YMFirstSingleTableViewCell.h"
#import "YMConditionDescriptionTableViewCell.h"
#import "YMDepartmentSelectionViewController.h"


static NSString *const firstSingleCell = @"firstSingleCell";

static NSString *const conditionDescriptionCell = @"conditionDescriptionCell";

@interface YMMiYIFirstSingleViewController ()<YMActivityBottomViewDelegate,UITableViewDelegate,UITableViewDataSource,YMConditionDescriptionTableViewCellDelegate,YMDepartmentSelectionViewControllerDelegate>

@property(nonatomic,strong)YMActivityBottomView *bottomView;

@property(nonatomic,strong)UITableView *firstSingleTableView;

@property(nonatomic,strong)NSString *CategoryStr;

@property(nonatomic,strong)NSString *disorder;

@property(nonatomic,strong)NSString *describecontent;

@property(nonatomic,strong)UIView *dateView;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,copy)NSString *showTime;//界面上显示的时间

@property(nonatomic,copy)NSString *uploadTime;//上传到服务器的时间

@end

@implementation YMMiYIFirstSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"鸣医首单";
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKey)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self createBottomView];
    [self initTabelview];
    [self setDateView];
}

-(void)createBottomView{
    _bottomView = [[YMActivityBottomView alloc]init];
    _bottomView.backgroundColor = RGBCOLOR(64, 133, 201);
    _bottomView.delegate = self;
    _bottomView.bottomTitle = @"报名参加";
    _bottomView.type = BottomActivityType;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

-(void)initTabelview{
    _firstSingleTableView = [[UITableView alloc]init];
    _firstSingleTableView.delegate = self;
    _firstSingleTableView.dataSource = self;
    _firstSingleTableView.backgroundColor = [UIColor clearColor];
    [_firstSingleTableView registerClass:[YMFirstSingleTableViewCell class] forCellReuseIdentifier:firstSingleCell];
    [_firstSingleTableView registerClass:[YMConditionDescriptionTableViewCell class] forCellReuseIdentifier:conditionDescriptionCell];
    _firstSingleTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_firstSingleTableView];
    [_firstSingleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
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
            self.firstSingleTableView.scrollEnabled = YES;
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
        _showTime = [dateformatter stringFromDate:date];
        _uploadTime = [dateformatter1 stringFromDate:date];
        [self.firstSingleTableView reloadData];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hiddenKey];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section!=3) {
        return 50.f;
    }else{
        return 150.f;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section !=3) {
        YMFirstSingleTableViewCell *cell = [[YMFirstSingleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstSingleCell];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            cell.titltStr = @"选择类目:";
            cell.subTitleStr = [NSString isEmpty:_CategoryStr] ?@"必选":_CategoryStr;
        }else if(indexPath.section == 1){
            cell.titltStr = @"需求标题:";
            cell.subTitleStr = self.activityTitle;
            cell.hiddenArrow = YES;
        }else{
            cell.titltStr = @"就诊时间:";
            cell.subTitleStr = [NSString isEmpty:_showTime]?@"0000年00月00日":_showTime;
            cell.hiddenArrow = YES;
        }
        [cell drawTopLine:0 right:0];
        [cell drawBottomLine:0 right:0];
        return cell;
    }else{
        YMConditionDescriptionTableViewCell *cell = [[YMConditionDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:conditionDescriptionCell];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.delegate =self;
        cell.textStr = [NSString isEmpty:_describecontent]?@"":_describecontent;
        [cell drawBottomLine:0 right:0];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        YMDepartmentSelectionViewController *vc = [[YMDepartmentSelectionViewController alloc]init];
        vc.hiddentopView = YES;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 2){
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = self.dateView.frame;
            if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                self.firstSingleTableView.scrollEnabled = NO;
            }
            else {
                rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                self.firstSingleTableView.scrollEnabled = YES;
            }
            self.dateView.frame = rect;
        }];
    }
}


#pragma mark - YMActivityBottomViewDelegate
-(void)activityBottomView:(YMActivityBottomView *)ActivityBottomView bottomClick:(UIButton *)sender{
    
    NSDictionary *params = @{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                             @"demand_aid":[NSString isEmpty:_disorder]?@"":_disorder,
                             @"demand_sketch":[NSString isEmpty:_activityTitle]?@"":_activityTitle,
                             @"demand_needs":[NSString isEmpty:_describecontent]?@"":_describecontent,
                             @"jtimes":[NSString isEmpty:_uploadTime]?@"":_uploadTime,
                             @"activity_id":[NSString isEmpty:_activity_id]?@"":_activity_id};
     [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=release&op=demand" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
         if (error) {
             return ;
         }
         [self navBackAction];
         
    }];
    
}

#pragma mark - YMConditionDescriptionTableViewCellDelegate

-(void)conditionDescriptionCell:(YMConditionDescriptionTableViewCell *)conditionDescriptionCell editContent:(NSString *)editContent{
    _describecontent = editContent;
}

-(void)conditionDescriptionCell:(YMConditionDescriptionTableViewCell *)conditionDescriptionCell beginEdit:(BOOL)beginEdit{
//   [_firstSingleTableView mas_updateConstraints:^(MASConstraintMaker *make) {
//       make.bottom.equalTo(_bottomView.mas_top).offset(- 200);
//   }];
}

#pragma mark - YMDepartmentSelectionViewControllerDelegate

-(void)departmentView:(YMDepartmentSelectionViewController *)departmentView  disorder:(NSString *)disorder ename:(NSString *)ename{
    _CategoryStr = ename;
    _disorder = disorder;
    [_firstSingleTableView reloadData];
}
-(void)hiddenKey{
    [self.view endEditing:YES];
//    [_firstSingleTableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(_bottomView.mas_top);
//    }];
}
#pragma mark -dismis
- (void)navBackAction
{
    UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
    if (ctrl == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
