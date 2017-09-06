//
//  YMDoctorLibaryViewController.m
//  doctor_user
//
//  Created by kupurui on 2017/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//
#import "SelectedView.h"
#import "YMDoctorLibaryViewController.h"
#import "YMDoctorLibaryCell.h"
#import "MJRefresh.h"
#import "YMDoctorDetailViewController.h"
#import "YMSelectedListView.h"
#import "KRShengTableViewController.h"
#import "DepartmentsView.h"

#import "YMDoctorHomePageViewController.h"
#import "YMSearchView.h"
#import "UIButton+LZCategory.h"

#import "YMMyAttentionTableViewCell.h"
#import "YMDoctorLibaryModel.h"
#import "YMDepartmentSelectionViewController.h"

#import "YMHospitalListViewController.h"
//融云
#import "TalkingViewController.h"

static NSString *const doctorAttentionCell = @"doctorAttentionCell";

//#import "UIViewController+BackButtonHandler.h"
//doctorLibatyIdentifier
@interface YMDoctorLibaryViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,YMDepartmentSelectionViewControllerDelegate,YMHospitalListViewControllerDelegate,YMDoctorHomePageViewControllerDelegate,YMMyAttentionTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SelectedView *headView;
@property (nonatomic,strong)NSMutableArray<YMDoctorLibaryModel *> *dataList ;
@property (nonatomic,assign)NSInteger page ;
@property (nonatomic,strong)NSMutableDictionary *params ;
@property (nonatomic,strong)NSArray *departments ;//科室
@property (nonatomic,strong)NSArray *forumDatalist ;//职称
@property (nonatomic,strong)NSArray *sortArray ;//排序
@property (nonatomic,strong)NSString *navigationTitle ;

@property (nonatomic,strong)YMSelectedListView *listView ;

@property(nonatomic,strong)YMSearchView *headerSearchView;

@property(nonatomic,assign)NSInteger selectListIndex;


@end
@implementation YMDoctorLibaryViewController
{
    
    BOOL searchIsShow ;
    
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 0) {
        self.navigationTitle = @"医生库";
    }else {
        self.navigationTitle = @"护士库";
    }

    self.title = self.navigationTitle ;
    [self setup];
    [self setupHeadView];
    [self initNavigationLeft];
    [self initNavigationRightView];
    [self initHeaderSearch];
    self.page = 1;
    if (_doctorInputType) {
        [_headerSearchView.searchTextField becomeFirstResponder];
    }else{
        [self requestData];
    }
    
    
    _selectListIndex = 99;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = YES ;
}

-(void)initHeaderSearch{
    _headerSearchView = [[YMSearchView  alloc]init];
    _headerSearchView.backgroundColor = [UIColor whiteColor];
    _headerSearchView.layer.masksToBounds = YES;
    _headerSearchView.layer.cornerRadius = 15;
    _headerSearchView.frame = CGRectMake(0, 10, SCREEN_WIDTH - 20, 30);
    _headerSearchView.placeholderStr = @"输入您想搜索的医院名字";
    self.navigationItem.titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = _headerSearchView;
}

- (void)refreshData {
    _page = 1;
    [self requestData];
}

- (void)loadMoreData{
    _page ++ ;
    [self requestData];
}


-(void)initNavigationLeft{
    
   UIView *leftBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
    [leftBtnView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    leftBtnBigger.backgroundColor = [UIColor clearColor];
    [leftBtnBigger setImage:[UIImage imageNamed:@"ico_backwhite"] forState:UIControlStateNormal];
    [leftBtnBigger addTarget:self action:@selector(turnToContact:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtnView addSubview:leftBtnBigger];
    [leftBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(leftBtnView);
    }];
    [leftBtnBigger LZSetbuttonType:LZCategoryTypeLeft];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtnView];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -17;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, rightBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = rightBarButtonItem;
    }
}

-(void)initNavigationRightView{
   UIView *rightBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtnView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightBtnBigger.backgroundColor = [UIColor clearColor];
    rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtnBigger setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtnBigger addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnView addSubview:rightBtnBigger];
    [rightBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightBtnView);
    }];
//    [rightBtnBigger LZSetbuttonType:LZCategoryTypeBottom];
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


-(void)setup {
    
//    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickEvent:)];
//    self.navigationItem.rightBarButtonItem = myButton;
    
    _dataList = [NSMutableArray array];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.001)];
    self.tableView.tableFooterView = view ;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.tableView.footer = footer ;
    _sortArray = @[@{@"ename":@"综合",@"key":@(0)},
                   @{@"ename":@"成交量",@"key":@(1)},
//                   @{@"ename":@"好评率",@"key":@(2)},
                   @{@"ename":@"浏览量",@"key":@(3)}];
    [_tableView registerClass:[YMMyAttentionTableViewCell class] forCellReuseIdentifier:doctorAttentionCell];
    [self requestPageContent];
    
}
- (void)setupHeadView {
    self.headView.block = ^(NSInteger index){
        //区域
        UIButton *view = (UIButton *) _headView.subviews[index];
        if (index == 1) {
            NSLog(@"跳转到医院");
            YMHospitalListViewController *vc = [[YMHospitalListViewController alloc]init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (index == 2) {
            
            YMDepartmentSelectionViewController *vc = [[YMDepartmentSelectionViewController alloc]init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            //科室
//            DepartmentsView *depart = [DepartmentsView DepartmentsViewWithDic:self.departments];
//            depart.viewOffsetX = view.width;
//            [depart showOnSuperView:self.view subViewStartY:45];
//            depart.block = ^(id dic, NSString *dicID){
//                self.params[@"ks"] = dic[@"disorder"];
//                [self.headView setTitle:dic[@"ename"]];
//                [self requestData];
//            };
        }
        if (index == _selectListIndex) {
            if (_listView) {
                [_listView removeFromSuperview];
                _listView = nil ;
            }
            _selectListIndex = 99;
            return ;
        }else{
            _selectListIndex = index;
        }
        if (index == 0  || index == 3) {
            
            ListType type = 0 ;
            NSArray *array ;
            if (index == 0) {
                //综合
                type = ListTypeNormal ;
                array = [self.sortArray copy];
                
            }
            else {
                //职称
                if ([self.forumDatalist count] == 0) {
                    //提示
                    return ;
                }
                type = ListTypeHospital;
                array = [self.forumDatalist copy]
                ;
            }
            if (_listView) {
                [_listView removeFromSuperview];
                _listView = nil ;
            }
            __weak typeof(self)weakSelf = self ;
            _listView = [YMSelectedListView viewWithDataList:array type:type andViewWidth: view.frame.size.width start_Y:CGRectGetMaxY(view.frame)  andStart_X:CGRectGetMinX(view.frame)andCommpleteBlock:^(id value,ListType type) {
                
                [weakSelf.headView setTitle:value[@"ename"]];
                if (type == ListTypeNormal) {
                    if ([value[@"key"] integerValue] == 0){
                        [weakSelf.headView setDefaultTitle];
                        [weakSelf.params removeAllObjects];
                    }
                    else {
                        [weakSelf.params setObject:value[@"key"] forKey:@"key"];

                    }
                }else {
                    [weakSelf.params setObject:value[@"disorder"] forKey:@"member_aptitude"];
                }
                weakSelf.page = 1 ;
                [weakSelf requestData];
            }];
            [self.view addSubview:_listView];
        }
    };
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_headerSearchView.searchTextField resignFirstResponder];
    if (_listView && _listView.superview) {
        [_listView removeFromSuperview];
        _listView = nil ;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    
}

//选择区域
- (void)clickChoiceDistribution:(UIView *)view {
    
    KRShengTableViewController *controller = [[KRShengTableViewController alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addreeeChoice:) name:@"selectedAddress" object:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addreeeChoice:(NSNotification *)notify {

    [self.headView setTitle:notify.object[@"area_name"]];
    [self.params setObject:notify.object[@"area_id"] forKey:@"area"];
    [self requestData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    [tableView tableViewDisplayWitMsg:@"暂无数据"
               ifNecessaryForRowCount:self.dataList.count];
    
    return self.dataList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YMMyAttentionTableViewCell *cell = [[YMMyAttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:doctorAttentionCell];
    YMDoctorLibaryModel *doctorModel =_dataList[indexPath.row];
    cell.delegate= self;
    cell.doctorModel = doctorModel;
    cell.indexPath = indexPath;
    cell.isStar = NO;
    [cell drawBottomLine:0 width:0];
    return cell ;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_listView) {
        [_listView removeFromSuperview];
        _listView = nil ;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
    YMDoctorLibaryModel *doctorModel =_dataList[indexPath.row];
    vc.doctorID = doctorModel.store_id;
    vc.indexPath = indexPath;
    vc.delegate = self;
     [self.navigationController pushViewController:vc animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85 ;
}

#pragma mark  -- 点击免费问诊btn YMMyAttentionTableViewCellDelegate
//点击免费问诊按钮事件
-(void)doctorLibaryMedicalCareBtn:(NSIndexPath *)indexPath
{
     YMDoctorLibaryModel *doctorModel =_dataList[indexPath.row];
    //为1 表示已关注
    if ([doctorModel.follow isEqualToString:@"1"]) {
        TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:doctorModel.huanxinid];
        vc.title = doctorModel.member_names;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        //未关注
        UIAlertController *VC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"免费问诊必须先关注医生" preferredStyle:UIAlertControllerStyleAlert];
        
        [VC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [VC addAction:[UIAlertAction actionWithTitle:@"关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"friend_frommid"] = [YMUserInfo sharedYMUserInfo].member_id;
            param[@"friend_tomid"] = doctorModel.member_id;
            param[@"type"] = @(1);
            //请求关注
            [self attentionRequrtData:param.copy andIndexPath:indexPath];
            
        }]];
        
        [self presentViewController:VC animated:YES completion:nil];
    
    }
    
}
-(void)turnToContact:(UIButton *)sender{

    UIViewController *ctrl = [[self navigationController]popViewControllerAnimated:YES];
    if (ctrl == nil) {
        [self dismissViewControllerAnimated:!YES completion:nil];
        }
}

-(void)searchClick:(UIButton *)sender{
    if (_headerSearchView.searchTextField.text.length>0) {
        [self.params setObject:_headerSearchView.searchTextField.text forKey:@"keyword"];
        self.page = 1;
        [self requestData];
    }else{
        self.page = 1;
        [self.params removeAllObjects];
        [self requestData];
    }
  
}
#pragma mark  --- 反向传质改变关注状态 -----YMDoctorHomePageViewControllerDelegate
-(void)setIsFollowNSString:(NSString *)followStr andIndexPath:(NSIndexPath *)indexPath{
    
     YMDoctorLibaryModel *doctorModel =_dataList[indexPath.row];
     doctorModel.follow = followStr;
    
}
#pragma mark - YMHospitalListViewControllerDelegate

-(void)hospitalList:(YMHospitalListViewController *)hospitalList hospitalModel:(YMHospitalModel *)hospitalModel{
    self.params[@"hospital_id"] = hospitalModel.hospital_id;
    [self.headView setTitle:hospitalModel.hospital_name];
    _page = 1;
    [self requestData];
}

-(void)departmentView:(YMDepartmentSelectionViewController *)departmentView  disorder:(NSString *)disorder ename:(NSString *)ename{
    self.params[@"ks"] = disorder;
    [self.headView setTitle:ename];
    _page = 1;
    [self requestData];
}

#pragma mark  --- 数据相关------
- (void)requestData {
    
    [self.params setObject:@(self.page) forKey:@"curpage"];
    NSString *url ;
    if (self.type == 0) {
        url = @"act=doctor&op=index" ;
    }
    else {
        url  = @"act=doctor_nurse&op=index";
    }
    self.params[@"member_id"]= [YMUserInfo sharedYMUserInfo].member_id;
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:url
                                                params:self.params
                                             withModel:nil
                                              waitView:self.view
                                        complateHandle:^(id showdata, NSString *error) {
                                            if (error) {
                                                return ;
                                            }
                                            if ([showdata[@"_store"] isKindOfClass:[NSArray class]] || [showdata[@"_store"] isKindOfClass:[NSMutableArray class]]) {
                                                if (self.page == 1) {
                                                    [self.dataList removeAllObjects];
                                                }
                                                NSArray *storeArry = [showdata[@"_store"] copy];
                                                for (NSDictionary *dic in storeArry) {
                                                    [self.dataList addObject:[YMDoctorLibaryModel modelWithJSON:dic]];
                                                }
                                            }
                                            if ([self.tableView.header isRefreshing]) {
                                                [self.tableView.header endRefreshing];
                                            }
                                            if ([self.tableView.footer isRefreshing]) {
                                                [self.tableView.footer endRefreshing];
                                            }
                                            [self.tableView reloadData];
                                        }];
}

//获取科室等接口
- (void)requestPageContent {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_personal&op=sys_enum" params:nil withModel:nil complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            self.departments = showdata[@"departments"];
            
            NSDictionary *depardic = @{@"disorder":@"",@"ename":@"不限条件",@"id":@"",@"tariff":@""};
            NSMutableArray *doctorTypeArry = [showdata[@"doctor_type"] mutableCopy];
            [doctorTypeArry insertObject:depardic atIndex:0];
            self.forumDatalist = [doctorTypeArry copy];
            
            NSLog(@"%@",self.forumDatalist);
        }
    }];
    
}

//-------关注----------
-(void)attentionRequrtData:(NSDictionary *)dict andIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_page&op=follow" params:dict withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
             YMDoctorLibaryModel *doctorModel =_dataList[indexPath.row];
             doctorModel.follow = @"1";
            
        }else{
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];
    
}




@end
