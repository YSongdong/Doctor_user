//
//  YMCaseLibraryViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseLibraryViewController.h"
#import "YMCaseLibraryTopView.h"
#import "YMSelectedListView.h"
#import "DepartmentsView.h"
#import "YMCaseLibraryTableViewCell.h"
#import "YMCaseDetailsViewController.h"
#import "YMSearchView.h"

#import "YMCaseLibraryModel.h"

#import "YMDepartmentSelectionViewController.h"

static NSString *const caseLibraryTableViewCell = @"caseLibraryTableViewCell";

@interface YMCaseLibraryViewController ()<YMCaseLibraryTopViewDelegate,UITableViewDelegate,UITableViewDataSource,YMDepartmentSelectionViewControllerDelegate,YMSearchViewDelegate>

@property(nonatomic,strong)YMCaseLibraryTopView *caseLibrarytopView;

@property(nonatomic,strong)UITableView *caseLibraryTableView;

@property(nonatomic,strong)YMSelectedListView *listView;

@property (nonatomic,strong)NSMutableDictionary *params ;
@property (nonatomic,strong)NSArray *departments ;//科室
@property (nonatomic,strong)NSArray *forumDatalist ;//职称

@property (nonatomic,strong)YMSearchView *headerSearchView;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)NSMutableArray<YMCaseLibraryModel *> *caseInforArry;//案例信息数组

@property(nonatomic,assign)NSInteger selectListIndex;

@end

@implementation YMCaseLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"案例库";
    [self initView];
    [self initVar];
    [self requestData];
    [self requestPageContent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = YES ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)initView{
    
    [self initNavigationLeft];
    [self initNavigationRightView];
    [self initHeaderSearch];
    
    [self initTopView];
    [self initTableView];

}

-(void)initVar{
    _selectListIndex = 99;
    _params = [NSMutableDictionary dictionary];
    _caseInforArry = [NSMutableArray array];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKey)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_caseLibraryTableView addGestureRecognizer:tapGestureRecognizer];
}

-(void)requestData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=case&op=caseLib" params:_params withModel:nil complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSArray class]] ||[showdata isKindOfClass:[NSMutableArray class]]) {
            [weakSelf.caseInforArry removeAllObjects];
            for (NSDictionary *dic in showdata) {
                [weakSelf.caseInforArry addObject:[YMCaseLibraryModel modelWithJSON:dic]];
            }
            
            [weakSelf.caseLibraryTableView reloadData];
        }
    }];
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
    rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightBtnBigger setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtnBigger addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)initHeaderSearch{
    _headerSearchView = [[YMSearchView  alloc]init];
    _headerSearchView.backgroundColor = [UIColor whiteColor];
    _headerSearchView.layer.masksToBounds = YES;
    _headerSearchView.layer.cornerRadius = 15;
    _headerSearchView.frame = CGRectMake(0, 10, SCREEN_WIDTH - 20, 30);
    _headerSearchView.placeholderStr = @"输入您想搜索的医院名字";
    _headerSearchView.delegate = self;
    self.navigationItem.titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = _headerSearchView;
}

-(void)initTopView{
    _caseLibrarytopView = [[YMCaseLibraryTopView alloc]init];
    _caseLibrarytopView.delegate = self;
    _caseLibrarytopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_caseLibrarytopView];
    [_caseLibrarytopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
}

-(void)initTableView{
    _caseLibraryTableView = [[UITableView alloc]init];
    _caseLibraryTableView.backgroundColor = [UIColor clearColor];
    _caseLibraryTableView.delegate = self;
    _caseLibraryTableView.dataSource = self;
    _caseLibraryTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_caseLibraryTableView registerClass:[YMCaseLibraryTableViewCell class] forCellReuseIdentifier:caseLibraryTableViewCell];
    [self.view addSubview:_caseLibraryTableView];
    [_caseLibraryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_caseLibrarytopView.mas_bottom);
    }];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blankClick)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_caseLibraryTableView addGestureRecognizer:tapGestureRecognizer];
}


//获取科室等接口
- (void)requestPageContent {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_personal&op=sys_enum" params:nil withModel:nil complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            self.departments = showdata[@"departments"];
            self.forumDatalist = showdata[@"doctor_type"];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _caseInforArry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMCaseLibraryTableViewCell *cell = [[YMCaseLibraryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:caseLibraryTableViewCell];
    cell.model = _caseInforArry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_listView) {
        [_listView removeFromSuperview];
        _listView = nil ;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YMCaseDetailsViewController *vc = [[YMCaseDetailsViewController alloc]init];
    YMCaseLibraryModel *model = _caseInforArry[indexPath.row];
    vc.case_id = model.case_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_listView && _listView.superview) {
        [_listView removeFromSuperview];
        _listView = nil ;
    }
}

#pragma mark - YMCaseLibraryTopViewDelegate
-(void)caseLibraryTopView:(YMCaseLibraryTopView *)caseLibraryTopView clcikTage:(NSInteger)tage{
    
    if (_listView) {
        [_listView removeFromSuperview];
        _listView = nil ;
    }

    [self hiddenKey];
    ListType type = ListTypeHospital;
    
    UIButton *view = (UIButton *) caseLibraryTopView.subviews[tage+1];
    if (tage == _selectListIndex) {
        _selectListIndex = 99;
        return ;
    }else{
        _selectListIndex = tage;
    }
    switch (tage) {
        
        case 0:{
            NSArray *array = @[@{@"ename":@"一周内",@"disorder":@1},
                               @{@"ename":@"一月内",@"disorder":@2},
                               @{@"ename":@"半年内",@"disorder":@3}];
            __weak typeof(self)weakSelf = self ;
            _listView = [YMSelectedListView viewWithDataList:array type:type andViewWidth: view.frame.size.width start_Y:CGRectGetMaxY(view.frame)  andStart_X:CGRectGetMinX(view.frame)andCommpleteBlock:^(id value,ListType type) {
                
                [_caseLibrarytopView setTitle:value[@"ename"]];
                
                  [weakSelf.params removeAllObjects];
                
                [weakSelf.params setObject:value[@"disorder"] forKey:@"time_type"];
                weakSelf.page = 1 ;
                [weakSelf requestData];
            }];
            [self.view addSubview:_listView];
        }
            break;
        case 2:{
            NSArray *array = @[@{@"ename":@"高到低",@"disorder":@1},
                               @{@"ename":@"低到高",@"disorder":@2}];
            __weak typeof(self)weakSelf = self ;
            _listView = [YMSelectedListView viewWithDataList:array type:type andViewWidth: view.frame.size.width start_Y:CGRectGetMaxY(view.frame)  andStart_X:CGRectGetMinX(view.frame) andCommpleteBlock:^(id value,ListType type) {
                [_caseLibrarytopView setTitle:value[@"ename"]];
                
                [weakSelf.params removeAllObjects];
                
                [weakSelf.params setObject:value[@"disorder"] forKey:@"sort"];
                weakSelf.page = 1 ;
                [weakSelf requestData];
            }];
            [self.view addSubview:_listView];
            
           
        }
            break;
        case 4:{
            NSArray *array = [self.forumDatalist copy];
            __weak typeof(self)weakSelf = self ;
            _listView = [YMSelectedListView viewWithDataList:array type:type andViewWidth: view.frame.size.width start_Y:CGRectGetMaxY(view.frame)  andStart_X:CGRectGetMinX(view.frame) andCommpleteBlock:^(id value,ListType type) {
                [_caseLibrarytopView setTitle:value[@"ename"]];
                [weakSelf.params setObject:value[@"disorder"] forKey:@"member_aptitude"];
                [weakSelf.params removeAllObjects];
                weakSelf.page = 1 ;
                [weakSelf requestData];
            }];
            [self.view addSubview:_listView];
            
        }
            break;
        case 6:{
            YMDepartmentSelectionViewController *vc = [[YMDepartmentSelectionViewController alloc]init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        }break;
        default:
            break;
    }
    
}

-(void)searchClick:(UIButton *)sender{
    [self blankClick];
    if (_headerSearchView.searchTextField.text.length>0) {
        [self hiddenKey];
        [self.params setObject:_headerSearchView.searchTextField.text forKey:@"keyword"];
        self.page = 1;
        [self requestData];
    }else{
        self.page = 1;
        [self.params removeAllObjects];
        [self requestData];
    }
    
}

-(void)turnToContact:(UIButton *)sender{
    
    UIViewController *ctrl = [[self navigationController]popViewControllerAnimated:YES];
    if (ctrl == nil) {
        [self dismissViewControllerAnimated:!YES completion:nil];
    }
}

-(void)blankClick{
    if (_listView) {
        [_listView removeFromSuperview];
        _listView = nil ;
    }
}

-(void)hiddenKey{
    [_headerSearchView.searchTextField resignFirstResponder];
}

#pragma mark - YMDepartmentSelectionViewControllerDelegate
-(void)departmentView:(YMDepartmentSelectionViewController *)departmentView  disorder:(NSString *)disorder ename:(NSString *)ename{
    self.params[@"ks"] = disorder;
    [_caseLibrarytopView setTitle:ename];
    [self requestData];
}

#pragma mark - YMSearchViewDelegate

-(void)searchView:(YMSearchView *)SearchView begingEdit:(BOOL)begingEdit{
    [self blankClick];
}

@end
