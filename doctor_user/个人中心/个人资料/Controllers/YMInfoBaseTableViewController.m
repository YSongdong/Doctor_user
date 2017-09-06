//
//  YMInfoBaseTableViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMInfoBaseTableViewController.h"
//#import "YMUserInfoTableViewController.h"

#import "YMUserInfoMemberTableViewCell.h"
#import "YMActivityBottomView.h"
#import "YMUserInfoMemberModel.h"

#import "YMAddNewUserInforViewController.h"

static NSString *const userInfoCell = @"userInfoCell";

@interface YMInfoBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,YMActivityBottomViewDelegate,YMUserInfoMemberTableViewCellDelegate>

@property(nonatomic,strong)YMActivityBottomView *bottomView;

@property(nonatomic,assign)BOOL rightButtonClick;

@property(nonatomic,strong)UITableView *userinfoMemberTabelView;

@property(nonatomic,strong)NSMutableArray<YMUserInfoMemberModel *> *selctUserInfoArry;

@property(nonatomic,strong)UIButton *rightBtnBigger ;

@property(nonatomic,strong)NSMutableArray<YMUserInfoMemberModel *> *memberArray;

@property(nonatomic,assign)BOOL editStatus;

@end

@implementation YMInfoBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户信息";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initView];
    [self initVar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
   [self requrtData];
}



-(void)initView{
    [self addNavigationRightButton];
    [self initBottomView];
    [self initTableView];
}

-(void)initVar{
    _selctUserInfoArry = [NSMutableArray array];
    _memberArray = [NSMutableArray array];
//    
//    for (NSInteger i = 0; i<10; i++) {
//        YMUserInfoMemberModel *model = [[YMUserInfoMemberModel alloc]init];
//        model.leaguer_img = @"http://local.yimeng.com/data/upload/shop/leaguer/201705/05485329841774570.png";
//        model.leagure_name = @"葛小二葛小二葛小二葛小二葛小二葛小二葛小二";
//        model.leagure_sex = @"1";
//        model.leagure_age = @"32";
//        model.leagure_idcard = @"500*********000000";
//        model.leagure_mobile = @"185****9220";
//        model.leaguer_id = [NSString stringWithFormat:@"%ld",(long)i];
//        if (i == 3) {
//            model.is_default = @"1";
//        }else{
//            model.is_default = @"0";
//        }
//        [_memberArray addObject:model];
//    }
//    
//    [_userinfoMemberTabelView reloadData];
}

-(void)addNavigationRightButton{
    UIView *rightBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22 *2)];
    [rightBtnView setBackgroundColor:[UIColor clearColor]];
    
    _rightBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    _rightBtnBigger.backgroundColor = [UIColor clearColor];
    _rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:17];
    [_rightBtnBigger setTitle:@"管理" forState:UIControlStateNormal];
    [_rightBtnBigger addTarget:self action:@selector(managementClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnView addSubview:_rightBtnBigger];
    [_rightBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightBtnView);
    }];
    [_rightBtnBigger LZSetbuttonType:LZCategoryTypeBottom];
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

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_personal&op=getLeaguerList" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        [weakSelf.memberArray removeAllObjects];
        if ([showdata isKindOfClass:[NSArray class]]||[showdata isKindOfClass:[NSMutableArray  class]]) {
            [weakSelf.memberArray removeAllObjects];
            for (NSDictionary *dic in showdata) {
                [weakSelf.memberArray addObject:[YMUserInfoMemberModel modelWithJSON:dic]];
            }
            
            [weakSelf.userinfoMemberTabelView reloadData];
        }
    }];
    
}

-(void)initTableView{
    
    _userinfoMemberTabelView = [[UITableView alloc]init];
    _userinfoMemberTabelView.delegate = self;
    _userinfoMemberTabelView.dataSource = self;
    _userinfoMemberTabelView.backgroundColor = [UIColor clearColor];
    
    [_userinfoMemberTabelView registerClass:[YMUserInfoMemberTableViewCell class] forCellReuseIdentifier:userInfoCell];
    
    _userinfoMemberTabelView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_userinfoMemberTabelView];
    [_userinfoMemberTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

-(void)initBottomView{
    _bottomView = [[YMActivityBottomView alloc]init];
    _bottomView.backgroundColor = RGBCOLOR(80, 168, 252);
    _bottomView.bottomTitle = @"添加新成员";
    _bottomView.imageName = @"my_addBank_icon";
    _bottomView.delegate = self;
    _bottomView.type = BottomUserInfoType;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [_bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_bottomView);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _memberArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMUserInfoMemberTableViewCell *cell = [[YMUserInfoMemberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userInfoCell];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    cell.editStatus = _editStatus;
     YMUserInfoMemberModel *model = _memberArray[indexPath.section];
    
    BOOL selectedStatus = NO;
    
    for (YMUserInfoMemberModel *selectModel in _selctUserInfoArry) {
        if ([selectModel.leaguer_id isEqual:model.leaguer_id]) {
            selectedStatus = YES;
            break;
        }
    }
    cell.model = model;
    cell.selectedStatus = selectedStatus;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(infoBaseController:userInfoModel:)]) {
        [self.delegate infoBaseController:self userInfoModel:_memberArray[indexPath.section]];
        [self navBackAction];
        return;
    }
    
    if (!_editStatus) {
        YMAddNewUserInforViewController *vc= [[YMAddNewUserInforViewController alloc]init];
        vc.leaguer_id = _memberArray[indexPath.section].leaguer_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   
    
//    if (indexPath.row == 0) {
//        //基本资料
//        YMUserInfoTableViewController *vc = [MAIN_STORBOARD instantiateViewControllerWithIdentifier:@"userInfoView"];
//        vc.vcType = @"1";
//        [self.navigationController pushViewController:vc animated:YES];
//    } else {
//        //隐私资料
//        YMUserInfoTableViewController *vc = [MAIN_STORBOARD instantiateViewControllerWithIdentifier:@"userInfoView"];
//        vc.vcType = @"2";
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

#pragma mark - NavigationRightClick
-(void)managementClick:(UIButton *)sender{
    _rightButtonClick = !_rightButtonClick;
    if (_rightButtonClick) {
        [_rightBtnBigger setTitle:@"完成" forState:UIControlStateNormal];
        _bottomView.bottomTitle = @"删除";
        _bottomView.imageName = @"";
        _editStatus = YES;
        [_selctUserInfoArry removeAllObjects];
    }else{
        [_rightBtnBigger setTitle:@"管理" forState:UIControlStateNormal];
        _bottomView.bottomTitle = @"添加新成员";
        _bottomView.imageName = @"my_addBank_icon";
        _editStatus = NO;
    }
    [_userinfoMemberTabelView reloadData];
}

#pragma mark - YMActivityBottomViewDelegate

-(void)activityBottomView:(YMActivityBottomView *)ActivityBottomView bottomClick:(UIButton *)sender{

    if (_editStatus) {
        NSLog(@"删除选中的数据");
        
        NSString *leaguer_ids = @"";
        for (YMUserInfoMemberModel *model in _selctUserInfoArry) {
            if ([NSString isEmpty:leaguer_ids]) {
                leaguer_ids = model.leaguer_id;
            }else{
                leaguer_ids = [NSString stringWithFormat:@"%@,%@",leaguer_ids,model.leaguer_id];
            }
        }
        [self removeSelectUserInfo:leaguer_ids];
        
    }else{
        NSLog(@"添加用户信息");
        
        YMAddNewUserInforViewController *vc = [[YMAddNewUserInforViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

    
}

#pragma mark - YMUserInfoMemberTableViewCellDelegate

-(void)userInfoMemberCell:(YMUserInfoMemberTableViewCell *)userInfoMemberCell  model:(YMUserInfoMemberModel *)model add:(BOOL)add{
    if (add) {
        [_selctUserInfoArry addObject:model];
        
    }else{
        [_selctUserInfoArry removeObject:model];
    }

    
}

-(void)removeSelectUserInfo:(NSString *)leaguer_ids{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_personal&op=delLeaguer" params:@{@"leaguer_ids":leaguer_ids} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        NSMutableArray* allArry = [weakSelf.memberArray copy];
        for (YMUserInfoMemberModel *model in allArry) {
            for (YMUserInfoMemberModel *selectModel in weakSelf.selctUserInfoArry) {
                if ([selectModel.leaguer_id isEqualToString:model.leaguer_id]) {
                    [weakSelf.memberArray removeObject:selectModel];
                    break;
                }
            }
        }
        [weakSelf.userinfoMemberTabelView reloadData];
    }];
}

- (void)navBackAction
{
    UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
    if (ctrl == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
