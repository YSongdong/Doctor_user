//
//  YMOfficialActivityViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOfficialActivityViewController.h"

#import "YMOfficialActivityTopView.h"
#import "YMActivityViewCell.h"
#import "YMActivityDetailsViewController.h"
#import "KRWebViewController.h"
#import "YMOfficialActivityModel.h"

#import "YMLocalBanner.h"
#import "YMLocalBannerModel.h"

static NSString *const activityViewCell = @"activityViewCell";

@interface YMOfficialActivityViewController ()<UITableViewDelegate,UITableViewDataSource,YMOfficialActivityTopViewDelegate,YMLocalBannerViewDelegate>

@property(nonatomic,strong)YMOfficialActivityTopView *officAcitvityView;

@property(nonatomic,strong)UITableView *officialActivityTable;

@property(nonatomic,strong)NSMutableArray <YMOfficialActivityModel*> *activityArryList;

@property(nonatomic,strong)NSMutableArray <YMOfficialActivityModel *> *myParticipateActivityArry;

@property (nonatomic, strong) NSDictionary *myDta;

@property(nonatomic,strong)YMLocalBanner *headerBannerView;

@property(nonatomic,assign)BOOL allActivity;


@end

@implementation YMOfficialActivityViewController

- (void)viewDidLoad {
    self.title = @"官方活动";
    [super viewDidLoad];
    [self initView];
    [self initVar];
    [self requrtData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = YES ;
}

-(void)initView{
    [self createHeaderBannerView];
    [self createActionSelctView];
    [self createTableView];
    _allActivity = YES;
}

-(void)initVar{
    _activityArryList = [NSMutableArray array];
    _myParticipateActivityArry = [NSMutableArray array];
    
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=activities&op=index" params:@{@"type":@2} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSDictionary class] ]|| [showdata isKindOfClass:[NSMutableDictionary class]]) {
            NSArray *activity_bannerArry = [showdata[@"activity_banner"] copy];
            NSMutableArray *LocalModelArry = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in activity_bannerArry) {
                [LocalModelArry addObject: [YMLocalBannerModel modelWithJSON:dic]];
            }
           weakSelf.headerBannerView.models = [LocalModelArry copy];;
            NSMutableArray *addBaseArry = [[NSMutableArray alloc]init];
            [addBaseArry addObjectsFromArray:[showdata[@"activity_list"] copy]];
            for (NSDictionary *dic in addBaseArry) {
                [weakSelf.activityArryList addObject: [YMOfficialActivityModel modelWithJSON:dic]];
            }
            
            [weakSelf.officialActivityTable reloadData];
        }
    }];
}

-(void)createHeaderBannerView{
    _headerBannerView = [[YMLocalBanner alloc] init];
    _headerBannerView.userInteractionEnabled = YES;
    _headerBannerView.autoScroll = YES;
    _headerBannerView.delegate = self;
    [self.view addSubview:_headerBannerView];
    [_headerBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
}


-(void)createActionSelctView{
    _officAcitvityView = [[YMOfficialActivityTopView alloc]init];
    _officAcitvityView.backgroundColor = [UIColor whiteColor];
    _officAcitvityView.delegate = self;
    [self.view addSubview:_officAcitvityView];
    [_officAcitvityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_headerBannerView.mas_bottom);
        make.height.mas_equalTo(45);
    }];
}

-(void)createTableView{
    _officialActivityTable = [[UITableView alloc]init];
    _officialActivityTable.delegate = self;
    _officialActivityTable.dataSource = self;
    _officialActivityTable.backgroundColor = [UIColor clearColor];
    _officialActivityTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [_officialActivityTable registerClass:[YMActivityViewCell class] forCellReuseIdentifier:activityViewCell];
    [self.view addSubview:_officialActivityTable];
    [_officialActivityTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_officAcitvityView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-3);
    }];
}

#pragma mark - YMOfficialActivityTopViewDelegate
-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView hallButton:(UIButton *)sender{
    NSLog(@"活动大厅");
    _allActivity = YES;
    [_headerBannerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(180);
    }];
    
    [_officialActivityTable reloadData];
}

-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView participateButton:(UIButton *)sender{
    NSLog(@"我参与的");
    _allActivity = NO;
    [_headerBannerView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(0);
    }];
    [self.myParticipateActivityArry removeAllObjects];
    [self requrtMyParticipateActivity];
    [_officialActivityTable reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_allActivity) {
        return _activityArryList.count;
    }else{
        return _myParticipateActivityArry.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMActivityViewCell *cell = [[YMActivityViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_allActivity) {
        cell.model = _activityArryList[indexPath.row];
    }else{
        cell.model = _myParticipateActivityArry[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YMActivityDetailsViewController *vc = [[YMActivityDetailsViewController alloc]init];
    if (_allActivity) {
        vc.activityId = _activityArryList[indexPath.row].activity_id;
    }else{
        vc.activityId = _myParticipateActivityArry[indexPath.row].activity_id;
    }
    
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
    [_headerBannerView removeTimer];
    
}
#pragma mark - YMLocalBannerDelegate
- (void)banner:(YMLocalBanner *)banner didClickBanner:(YMLocalBannerModel *)model{
    NSLog(@"%@",model);
    
    KRWebViewController *webVC = [[KRWebViewController alloc]init];
    webVC.saoceUrl = model.adv_url;
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)requrtMyParticipateActivity{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=activities&op=applyList" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSArray class] ]|| [showdata isKindOfClass:[NSMutableArray class]]) {
           
            NSArray *myActivityArry =[showdata copy];
            for (NSDictionary *dic in myActivityArry) {
                [weakSelf.myParticipateActivityArry addObject: [YMOfficialActivityModel modelWithJSON:dic]];
            }
            
            [weakSelf.officialActivityTable reloadData];
        }
    }];
}

@end
