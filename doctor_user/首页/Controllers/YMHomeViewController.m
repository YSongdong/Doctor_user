//
//  YMHomeViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHomeViewController.h"
#import "HomeHeadTableViewCell.h"
#import "YMHomeBtnTableViewCell.h"
#import "YMHomeDoctorTableViewCell.h"
#import "YMDoctorDetailViewController.h"
#import "YMMingyiViewController.h"
#import "YMYINanViewController.h"
#import "YMDoctorLibaryViewController.h"
#import "KRWebViewController.h"
#import "YMHomeServerTableViewCell.h"
#import "YMOfficialActivityViewController.h"
#import "YMCaseLibraryViewController.h"
#import "YMDoctorHomePageViewController.h"
#import "UIButton+LZCategory.h"

#import "KRShengTableViewController.h"

#import "SDHosporViewController.h"

#import "YMSearchView.h"

#import "YMScanViewController.h"

#import "YMRankingTableViewCell.h"

#import "YMRankingViewController.h"
#import "TalkingViewController.h"

#import "YMNewFaBuXuQiuViewController.h"

#import "YMHomeCenterTableViewCell.h"

#import "ZMFloatButton.h"

#import "SDNewScanViewController.h"

static NSString *const homeCenterTableCell = @"homeCenterTableCell";

static NSString *const inputadvertisingClick = @"inputadvertisingClick";

static NSString *const rankingCell = @"rankingCell";



@interface YMHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,YMSearchViewDelegate,YMHomeCenterTableViewCellDelegate,ZMFloatButtonDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchBar *headerSearchBar;
@property (nonatomic, strong) NSDictionary *myDta;

@property(nonatomic,strong)NSMutableArray <YMDoctorRankingModel *> *doctorRankingArry;
@property(nonatomic,strong)NSDictionary *assistant;

@property(nonatomic,assign)NSInteger guidePageTage;

@property (weak, nonatomic) IBOutlet UIImageView *guidePagesView;//引导页

@end

@implementation YMHomeViewController
{
    NSInteger freshTag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inputWebView];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    freshTag = 1;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self initNavigationLeft];
    [self initNavigationRightView];
    [self initHeaderSearch];
    [self initVar];
    [self initFloatBtn];
    [_tableView registerClass:[YMRankingTableViewCell class] forCellReuseIdentifier:rankingCell];
    [_tableView registerClass:[YMHomeCenterTableViewCell class] forCellReuseIdentifier:homeCenterTableCell];
    //设置状态栏颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

-(void) initVar{
    _guidePageTage = 1;
    _doctorRankingArry = [[NSMutableArray alloc]init];
}

-(void)initHeaderSearch{
    YMSearchView *headerSearchView = [[YMSearchView  alloc]init];
    headerSearchView.backgroundColor = [UIColor colorWithHexString:@"#418dd9"];
    headerSearchView.delegate = self;
    headerSearchView.placeholderStr = @"医院/医生/科室";
    headerSearchView.showSearchButton = YES;
    headerSearchView.showRightSerarch = YES;
    headerSearchView.layer.masksToBounds = YES;
    headerSearchView.layer.cornerRadius = 15;
    headerSearchView.frame = CGRectMake(40, 10, SCREEN_WIDTH - 80, 30);
    self.navigationItem.titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = headerSearchView;
}
-(void)initNavigationLeft{
    
   UIView *leftBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22 *2)];
    [leftBtnView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    leftBtnBigger.backgroundColor = [UIColor clearColor];
    leftBtnBigger.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtnBigger setImage:[UIImage imageNamed:@"home_nav_adrees"] forState:UIControlStateNormal];
    [leftBtnBigger setTitle:@"重庆" forState:UIControlStateNormal];
    [leftBtnBigger setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
        negativeSpacer.width = -5;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, rightBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = rightBarButtonItem;
    }
}

-(void)initNavigationRightView{
    UIView *rightBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22 *2)];
    [rightBtnView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightBtnBigger.backgroundColor = [UIColor clearColor];
    rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:11];
    [rightBtnBigger setImage:[UIImage imageNamed:@"home_nav_saomi"] forState:UIControlStateNormal];
   // [rightBtnBigger setTitle:@"扫一扫" forState:UIControlStateNormal];
    [rightBtnBigger addTarget:self action:@selector(scanitClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnView addSubview:rightBtnBigger];
    [rightBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightBtnView);
    }];
    [rightBtnBigger LZSetbuttonType:LZCategoryTypeBottom];
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
//全局浮动按钮
-(void) initFloatBtn
{
    ZMFloatButton * floatBtn = [[ZMFloatButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-176, 98, 50)];
    floatBtn.delegate = self;
    //floatBtn.isMoving = NO;
    floatBtn.bannerIV.image = [UIImage imageNamed:@"图层-15"];
    [self.view addSubview:floatBtn];
    [self.view bringSubviewToFront:floatBtn];
    
}
- (void)loadData {
    UIView *temp = nil;
    if (freshTag == 1) {
        temp = self.view;
    } else {
        temp = nil;
    }
    
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_hire&op=indexs" params:nil withModel:nil waitView:temp complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        weakSelf.myDta = [showdata copy];
        if ([showdata[@"assistant"] isKindOfClass:[NSDictionary class]] || [showdata[@"assistant"] isKindOfClass:[NSMutableArray class]]) {
            weakSelf.assistant = [showdata[@"assistant"] copy];
        }
        
        if ([showdata[@"store"] isKindOfClass:[NSArray class]] || [showdata[@"store"] isKindOfClass:[NSMutableArray class]]) {

            [weakSelf.doctorRankingArry removeAllObjects];
            NSArray *storeArry = [showdata[@"store"] copy];
            for (NSDictionary *dic in storeArry) {
                [weakSelf.doctorRankingArry addObject:[YMDoctorRankingModel modelWithJSON:dic]];
            }
            
        }
        [weakSelf.tableView reloadData];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.translucent = NO;
    [self loadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.translucent = YES;
    
}
- (void)setHeaderSearch {
    
    UISearchBar *bar  = [[UISearchBar alloc]initWithFrame:CGRectMake(5, 10, [UIScreen mainScreen].bounds.size.width - 10, 30)];
    self.headerSearchBar = bar;
    bar.backgroundImage = [UIImage new];
    self.navigationItem.titleView = bar;
    bar.barTintColor = [UIColor clearColor];
    bar.delegate = self;
    bar.showsSearchResultsButton = YES;
    [self setSearchTextFieldBackgroundColor:[UIColor colorWithRed:222.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
    
    bar.placeholder = @"搜索医生或护士";
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    searchBar.text = @"";
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    
    YMDoctorLibaryViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"doctorLibary"];
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];

    
    return NO ;
}
- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor
{
    UIView *searchTextField = nil;
    searchTextField = [[[self.headerSearchBar.subviews firstObject] subviews] lastObject];
    
    searchTextField.tintColor = [UIColor blackColor];
    searchTextField.backgroundColor = backgroundColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return _doctorRankingArry.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 50;
    }

    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        tableView.backgroundColor = [UIColor clearColor];
        UIView *headrViewA = [[UIView alloc]init];
        headrViewA.backgroundColor = [UIColor clearColor];
        
        UIView *headerView = [[UIView alloc]init];
        headerView.backgroundColor = [UIColor whiteColor];
        [headrViewA addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(headrViewA);
            make.top.equalTo(headrViewA.mas_top).offset(10);
        }];
        
        UIImageView *headerImageView =[[UIImageView alloc]init];
        headerImageView.image = [UIImage imageNamed:@"home_Ranking_icon"];
        [headerView addSubview:headerImageView];
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(10);
            make.centerY.equalTo(headerView.mas_centerY);
            //make.width.height.equalTo(@22);
        }];
        
        UIImageView *arrowImageView =[[UIImageView alloc]init];
        arrowImageView.image = [UIImage imageNamed:@"self_right_icon"];
        [headerView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView.mas_right).offset(-10);
            make.centerY.equalTo(headerView.mas_centerY);
            make.width.equalTo(@6);
            make.height.equalTo(@13);
        }];
        

        UILabel *subTitleLabel =[[UILabel alloc]init];
        subTitleLabel.text = @"更多";
        subTitleLabel.textColor = RGBCOLOR(130, 130, 130);
        subTitleLabel.font = [UIFont systemFontOfSize:13];
        [headerView addSubview:subTitleLabel];
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowImageView.mas_left).offset(-5);
            make.top.bottom.equalTo(headerView);
        }];
        
        UIButton *senderButton = [[UIButton alloc]init];
        [senderButton addTarget:self action:@selector(mingyiRankingClick:) forControlEvents:UIControlEventTouchUpInside];
        senderButton.backgroundColor  =[UIColor clearColor];
        [headerView addSubview:senderButton];
        [senderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headerView);
        }];
        [headrViewA drawBottomLine:0 right:0];
        return headrViewA;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeHeadTableViewCellIdentifier"];
        cell.pictures = self.myDta[@"_image"] ;
        cell.block = ^(NSString *url){
            KRWebViewController *webVC = [[KRWebViewController alloc]init];
            webVC.saoceUrl = url;
            [self.navigationController pushViewController:webVC animated:YES];
          
        };
        return cell;
    }
    else if (indexPath.section == 1) {
        
        YMHomeCenterTableViewCell *cell = [[YMHomeCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeCenterTableCell];
        cell.delegate = self;

        return cell;
    } else {

        YMRankingTableViewCell *cell = [[YMRankingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rankingCell];
        cell.model = _doctorRankingArry[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    } else if (indexPath.section == 1) {
        return 250;
    } else {
        return 80;
    }
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
        vc.doctorID = self.myDta[@"store"][indexPath.row][@"store_id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - YMHomeCenterTableViewCellDelegate
//鸣医订单
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell dingDanButton:(UIButton *)sender{
    YMNewFaBuXuQiuViewController *vc = [[YMNewFaBuXuQiuViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//医生库
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell doctorButton:(UIButton *)sender{
    YMDoctorLibaryViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"doctorLibary"];
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
   
}
//护士库
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell nurseButton:(UIButton *)sender{
    [self showErrorWithTitle:@"该功能正在建设中！" autoCloseTime:2];
    
}
//需求大厅
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell xuQiuButton:(UIButton *)sender{

    [self showErrorWithTitle:@"该功能正在建设中！" autoCloseTime:2];
}
//案例库
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell anLiKuButton:(UIButton *)sender{
    YMCaseLibraryViewController *vc = [[YMCaseLibraryViewController alloc]init];
    vc.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self.navigationController pushViewController:vc animated:YES];
}
//鸣医助手
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell zhuShowButton:(UIButton *)sender{
    NSString *huanxinid =[NSString isEmpty:_assistant[@"huanxinid"]]?@"":_assistant[@"huanxinid"];
    TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:huanxinid];
    vc.title = @"鸣医助手";
    [self.navigationController pushViewController:vc animated:YES];
}
//疑难杂症
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell zaZhengButton:(UIButton *)sender{
    
    YMYINanViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"yinanView"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//体检报告
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell tiJianButton:(UIButton *)sender{
    [self showErrorWithTitle:@"该功能正在建设中！" autoCloseTime:2];
}
//活动
-(void)HomeCenterTableViewCell:(YMHomeCenterTableViewCell *)cell activityButton:(UIButton *)sender{
    YMOfficialActivityViewController *vc = [[YMOfficialActivityViewController alloc]init];
    vc.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self.navigationController pushViewController:vc animated:YES];
}
// ---------点击热点-------
-(void) selectdHospotUrl:(NSString *)url andTitle:(NSString *)title{

    SDHosporViewController *sdHosporVC = [[SDHosporViewController alloc]init];
    sdHosporVC.title = title;
    sdHosporVC.url = url;
    sdHosporVC.shareType =@"1";
    [self.navigationController pushViewController:sdHosporVC animated:YES];

}


#pragma mark - leftClick
//----点击城市按钮------
-(void)turnToContact:(UIButton *)sender{
    NSLog(@"城市被点击");
//    KRShengTableViewController *vc = [[KRShengTableViewController alloc]init];
//    vc.type = districtTypeCity;
//    [self.navigationController pushViewController:vc animated:YES];
}
//------点击扫一扫按钮-----
-(void)scanitClick:(UIButton *)sender{
    NSLog(@"扫一扫被点击");
//    YMScanViewController *vc = [[YMScanViewController alloc]init];
//    vc.title = @"扫描二维码";
//    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    SDNewScanViewController *vc = [[SDNewScanViewController alloc]init];
    vc.title = @"";
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - YMSearchViewDelegate
//首页搜索
-(void)SearchView:(YMSearchView *)SearchView headerSearchButton:(UIButton *)headerSearchButton{
    YMDoctorLibaryViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"doctorLibary"];
    vc.type = 0;
    vc.doctorInputType = doctorInputSeachType;
    [self.navigationController pushViewController:vc animated:YES];
}

//点击鸣医排行榜
-(void)mingyiRankingClick:(UIButton *)sender{
    YMRankingViewController *vc = [[YMRankingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
}
-(void)inputWebView{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:inputadvertisingClick]) {
        
        NSString *strUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"webUrl"];
        KRWebViewController *webVC = [[KRWebViewController alloc]init];
        webVC.saoceUrl = strUrl;
        [self.navigationController pushViewController:webVC animated:YES];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:inputadvertisingClick];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
#pragma mark -浮动按钮 ZMFloatButtonDelegate---
- (void)floatTapAction:(ZMFloatButton *)sender{
    //点击执行事件
    NSString *huanxinid =[NSString isEmpty:_assistant[@"huanxinid"]]?@"":_assistant[@"huanxinid"];
    NSLog(@"id======%@",_assistant[@"huanxinid"]);
 
    TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:huanxinid];
    vc.title = @"鸣医助手";
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
