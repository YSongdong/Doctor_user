//
//  YMNewFirstActivityViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/7/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMNewFirstActivityViewController.h"
#import "YMBottomView.h"
#import "YMFaBuSubTitleTableViewCell.h"
#import "YMInfoBaseTableViewController.h"
#import "YMDepartmentSelectionViewController.h"
#import "YMNewFirstActivityInforViewController.h"
//#import "YMFirsrActivityContentViewController.h"

static NSString *FaBuSubTitleTableViewCell = @"FaBuSubTitleTableViewCell";

@interface YMNewFirstActivityViewController ()<YMBottomViewDelegate,UITableViewDataSource,UITableViewDelegate,YMInfoBaseTableViewControllerDelegate,YMDepartmentSelectionViewControllerDelegate>
@property(nonatomic,strong)UITableView *fabuXuqiuTableView;
@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *KSName;
@property(nonatomic,strong)NSMutableDictionary *dic;
@end

@implementation YMNewFirstActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"需求内容";
    [self initVar];
    [self initBottomView];
    [self initTableView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initVar{
    _userName = @"";
    _KSName = @"";
    _dic = [NSMutableDictionary dictionary];
    [_dic setObject:@"1" forKey:@"demand_type"];
    [_dic setObject:[NSString isEmpty:_activity_id]?@"":_activity_id forKey:@"activity_id"];
}

-(void)initBottomView{
    _bottomView = [[YMBottomView alloc]init];
    _bottomView.type = MYBottomBlueType;
    _bottomView.bottomTitle = @"下一步";
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

-(void)initTableView{
    _fabuXuqiuTableView = [[UITableView alloc]init];
    _fabuXuqiuTableView.backgroundColor = [UIColor clearColor];
    _fabuXuqiuTableView.delegate = self;
    _fabuXuqiuTableView.dataSource = self;
    _fabuXuqiuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [_fabuXuqiuTableView registerClass:[YMFaBuSubTitleTableViewCell class] forCellReuseIdentifier:FaBuSubTitleTableViewCell];
    [self.view addSubview:_fabuXuqiuTableView];
    [_fabuXuqiuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMFaBuSubTitleTableViewCell *cell = [[YMFaBuSubTitleTableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:{
            cell.titleName = @"需求类型:";
            cell.subTitleName = @"鸣医";
            cell.hiddenArrow = YES;
        }
            break;
        case 1:{
            cell.titleName = @"选择成员:";
            if ([NSString isEmpty:_userName]) {
                cell.subTitleName = @"请选择";
            }else{
                cell.subTitleName = _userName;
            }
    
            
        }
            break;
        case 2:{
            cell.titleName = @"科室选择:";
            if ([NSString isEmpty:_KSName]) {
                cell.subTitleName = @"请选择科室";
            }else{
                cell.subTitleName = _KSName;
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:{
            YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            YMDepartmentSelectionViewController *vc = [[YMDepartmentSelectionViewController alloc]init];
            vc.delegate = self;
            vc.hiddentopView = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - YMInfoBaseTableViewControllerDelegate

-(void)infoBaseController:(YMInfoBaseTableViewController *)infoBase userInfoModel:(YMUserInfoMemberModel *)informodel{

    NSLog(@"用户ID：%@",informodel.leaguer_id);
    [_dic setObject:informodel.member_id forKey:@"member_id"];
    [_dic setObject:informodel.leaguer_id forKey:@"leaguer_id"];
    _userName = informodel.leagure_name;
    [_fabuXuqiuTableView reloadData];
}

#pragma mark - YMDepartmentSelectionViewControllerDelegate
-(void)departmentView:(YMDepartmentSelectionViewController *)departmentView  disorder:(NSString *)disorder ename:(NSString *)ename big_ks:(NSString*)big_ks{
    NSLog(@"大科室disorder%@:小科室disorder:%@",disorder,big_ks);
    [_dic setObject:big_ks forKey:@"big_ks"];
    [_dic setObject:disorder forKey:@"small_ks"];
    _KSName = ename;
    [_fabuXuqiuTableView reloadData];
}

#pragma mark - YMBottomViewDelegate
-(void)bottomView:(YMBottomView *)bottomClick{
    if ([NSString isEmpty:_dic[@"member_id"]]) {
        [self.view showErrorWithTitle:@"请选择成员" autoCloseTime:2];
        return;
    }
    
    if ([NSString isEmpty:_dic[@"small_ks"]]) {
        [self.view showErrorWithTitle:@"科室" autoCloseTime:2];
        return;
    }
    YMNewFirstActivityInforViewController *vc = [[YMNewFirstActivityInforViewController alloc]init];
    vc.dic = [_dic mutableCopy];
    vc.activityTitle = _activityTitle;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
