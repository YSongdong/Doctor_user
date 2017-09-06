//
//  YMBillRecordInfoViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMBillRecordInfoViewController.h"

#import "YMBillRecordView.h"

#import "YMAccountInformationTableViewCell.h"

#import "YMBillRecordModel.h"

#import "QFDatePickerView.h"

#import "SDWaitingView.h"

static NSString *const accountInformationCell = @"accountInformationCell";


@interface YMBillRecordInfoViewController ()<UITableViewDelegate,UITableViewDataSource,QFDatePickerViewDelegate>

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UILabel *topTimeLabel;//时间
@property(nonatomic,strong)UILabel *topincomeLabel;//收入

@property(nonatomic,strong)UITableView *billRecordTableView;

@property(nonatomic,strong)YMBillRecordView *billRecordView;

@property(nonatomic,strong)NSMutableArray<YMBillRecordModel *> *billRecordArry;

@property(nonatomic,strong)QFDatePickerView *datePickerView ;

@property(nonatomic,assign)BOOL showTimeSelectView;

@property(nonatomic,copy)NSString *selectYearAndMonth;

@property(nonatomic,copy)NSString *topTitleTimeStr;//时间

@property(nonatomic,copy)NSString *topTitleIncomeStr;//收入

@end

@implementation YMBillRecordInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"账单纪录";
    [self initVar];
    [self initView];
    [self requrtData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)initView{
    [self initNavigationRightView];
    [self initTopView];
    [self initbillRecordView];
    [self initTableView];
}
-(void)initVar{
    _billRecordArry = [NSMutableArray array];
    _showTimeSelectView = NO;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    //拆分年月成数组
    NSArray *dateArray = [currentDateStr componentsSeparatedByString:@"-"];
    if (dateArray.count == 2) {//年 月
        _selectYearAndMonth = [NSString stringWithFormat:@"%@-%@",[dateArray firstObject],dateArray[1]];
    }
    
    _topTitleTimeStr = @"时间:";
    _topTitleIncomeStr = @"收入:";
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=userNewBill" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,@"bill_date":_selectYearAndMonth} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]||[showdata isKindOfClass:[NSMutableDictionary class]]) {
            _topTitleTimeStr = [NSString stringWithFormat:@"时间:%@",showdata[@"bill_time"]];
            _topTitleIncomeStr = [NSString stringWithFormat:@"收入:%@",showdata[@"money"]];
            if ([showdata[@"bill"] isKindOfClass:[NSArray class]] || [showdata[@"bill"] isKindOfClass:[NSMutableArray class]]) {
                NSArray *billArry = [showdata[@"bill"] copy];
                if (billArry.count==0) {
                    _topView.hidden = YES;
                    _billRecordView.hidden = YES;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf.view showErrorWithTitle:@"无记录" autoCloseTime:2];
                        });
                    });
                }else{
                    _topView.hidden = NO;
                    _billRecordView.hidden = NO;
                    for (NSDictionary *dic in billArry) {
                        [weakSelf.billRecordArry addObject:[YMBillRecordModel modelWithJSON:dic]];
                    }
                    [weakSelf refreshController];
                }
            }
        }
        
        
    }];

}

-(void)refreshController{
    _topTimeLabel.text = _topTitleTimeStr;
    _topincomeLabel.text = _topTitleIncomeStr;
    [_billRecordTableView reloadData];
}

-(void)initTopView{
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];

    _topTimeLabel = [[UILabel alloc]init];
    _topTimeLabel.font = [UIFont systemFontOfSize:15];
    _topTimeLabel.text =_topTitleTimeStr;
    [_topView addSubview:_topTimeLabel];
    [_topTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.bottom.equalTo(_topView);
    }];

    _topincomeLabel = [[UILabel alloc]init];
    _topincomeLabel.font = _topTimeLabel.font;
    _topincomeLabel.text =_topTitleIncomeStr;
    _topincomeLabel.textAlignment = NSTextAlignmentRight;
    [_topView addSubview:_topincomeLabel];
    [_topincomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.bottom.equalTo(_topView);
        make.left.equalTo(_topTimeLabel.mas_right).offset(10);
    }];
}

-(void)initbillRecordView{
    _billRecordView = [[YMBillRecordView alloc]init];
    _billRecordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_billRecordView];
    [_billRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.top.equalTo(_topView.mas_bottom);
    }];
    [_billRecordView drawBottomLine:0 right:0];
}

-(void)initTableView{
    _billRecordTableView = [[UITableView alloc]init];
    _billRecordTableView.delegate = self;
    _billRecordTableView.dataSource = self;
    _billRecordTableView.backgroundColor = [UIColor clearColor];

    [_billRecordTableView registerClass:[YMAccountInformationTableViewCell class] forCellReuseIdentifier:accountInformationCell];

    _billRecordTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    [self.view addSubview:_billRecordTableView];
    [_billRecordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_billRecordView.mas_bottom);
    }];
}


-(void)initNavigationRightView{
    UIView *rightBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22 *2)];
    [rightBtnView setBackgroundColor:[UIColor clearColor]];

    UIButton *rightBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightBtnBigger.backgroundColor = [UIColor clearColor];
    rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:11];
    [rightBtnBigger setImage:[UIImage imageNamed:@"bill_record_icon"] forState:UIControlStateNormal];
    [rightBtnBigger addTarget:self action:@selector(billRecordClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnView addSubview:rightBtnBigger];
    [rightBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightBtnView);
    }];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _billRecordArry.count;
//    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YMAccountInformationTableViewCell *cell = [[YMAccountInformationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountInformationCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    model.member_names = @"张三";
//    model.demand_sketch = @"呼吸道";
//    model.order_amount = @"399";
//    model.finnshed_time = @"2017-04-28 11:24";
    cell.model = _billRecordArry[indexPath.row];
    return cell;

}
-(void)billRecordClick:(UIButton *)sender{
    NSLog(@"账单纪录右上角点击");
    if (!_datePickerView) {
        _datePickerView = [[QFDatePickerView alloc]initDatePacker];
        _datePickerView.delegage = self;
    }
    if (!_showTimeSelectView) {
        [_datePickerView show:self.view];
    }else{
        [_datePickerView dismiss];
    }
    
}

-(void)datePickerView:(QFDatePickerView *)datePickerView disMiss:(BOOL)dismiss{
    _showTimeSelectView = !dismiss;
}
-(void)datePickerView:(QFDatePickerView *)datePickerView selectStr:(NSString *)yearAndMonth{
    _selectYearAndMonth = yearAndMonth;
    [_billRecordArry removeAllObjects];
    [self requrtData];
}



@end
