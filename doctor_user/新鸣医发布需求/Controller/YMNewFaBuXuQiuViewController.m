//
//  YMNewFaBuXuQiuViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMNewFaBuXuQiuViewController.h"
#import "YMBottomView.h"
#import "YMFaBuSwitchTableViewCell.h"
#import "YMFaBuSubTitleTableViewCell.h"
#import "YMDepartmentSelectionViewController.h"
#import "YMInfoBaseTableViewController.h"
#import "YMOrderViewController.h"
#import "YMNewContentViewController.h"
#import "YMNewUnitContentViewController.h"

static NSString *const FaBuSwitchTableViewCell = @"FaBuSwitchTableViewCell";

static NSString *const FaBuSubTitleTableViewCell = @"FaBuSubTitleTableViewCell";

@interface YMNewFaBuXuQiuViewController ()<UITableViewDelegate,UITableViewDataSource,YMBottomViewDelegate,YMFaBuSwitchTableViewCellDelegate,YMDepartmentSelectionViewControllerDelegate,YMInfoBaseTableViewControllerDelegate,YMOrderViewControllerDelegate>
@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,strong)UITableView *fabuXuqiuTableView;

@property(nonatomic,strong)NSMutableDictionary *ordeDic;

@property(nonatomic,strong)NSDictionary *fuzhenDict; //复诊dic

@property(nonatomic,copy)NSString *userName;

@property(nonatomic,copy)NSString *KSName;


@end

@implementation YMNewFaBuXuQiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initBottomView];
    self.title = @"科室选择";
    [self initVar];
    [self initNavi];
    [self initTableView];
    
    //设置状态栏颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES ;
}
-(void)initVar{
    _ordeDic = [NSMutableDictionary dictionary];
    _fuzhenDict = [NSDictionary dictionary];
    _userName = @"";
    _KSName= @"";
    [_ordeDic setObject:@"0" forKey:@"is_daifa"];
    [_ordeDic setObject:@"0" forKey:@"is_fuzhen"];
}
-(void)initNavi
{
    UIButton *leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ico_backwhite"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem =leftBarButtonItem;

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
    [_fabuXuqiuTableView registerClass:
     [YMFaBuSwitchTableViewCell class] forCellReuseIdentifier:FaBuSwitchTableViewCell];
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
    if ( section == 2) {
        return 1;
    }
    if (section == 0) {
        if ([_ordeDic[@"is_fuzhen"]integerValue] ==1) {
            return 2;
        }else{
            return 1;
        }
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==0&&indexPath.row == 0) {
        YMFaBuSwitchTableViewCell *cell = [[YMFaBuSwitchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FaBuSwitchTableViewCell];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.On = [_ordeDic[@"is_fuzhen"] integerValue] == 1?YES:NO;
        cell.titleName = @"是否复诊:";
        if ([_ordeDic[@"is_fuzhen"] integerValue] == 1) {
           // [cell drawBottomLine:10 right:0];
  
        }
        return cell;
    }else{
        YMFaBuSubTitleTableViewCell *cell = [[YMFaBuSubTitleTableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.section) {
            case 0:{
                if (indexPath.row == 1) {
                    cell.titleName = @"对应的订单:";
                    cell.subTitleName = @"请选择";
                    if (![NSString isEmpty: _ordeDic[@"fuzhen"]]) {
                        cell.subTitleName = _ordeDic[@"fuzhen"];
                    }
                }
                
            }
                break;
            case 1:{
                if (indexPath.row == 0) {
                    cell.titleName = @"需求类型:";
                    cell.subTitleName = @"请选择您的需求类型";
                    switch ([_ordeDic[@"demand_type"] integerValue]) {
                        case 1:
                            cell.subTitleName = @"询医问诊";
                            break;
                        case 2:
                            cell.subTitleName = @"市内坐诊";
                            break;
                        case 3:
                            cell.subTitleName = @"活动讲座";
                            break;
                        default:
                            break;
                    }

                }else{
                    cell.titleName = @"选择用户:";
                    if ([NSString isEmpty:_userName]) {
                        cell.subTitleName = @"请选择";
                    }else{
                        cell.subTitleName = _userName;
                    }
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
    
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 1) {
                YMOrderViewController *vc = [[YMOrderViewController alloc]init];
                vc.returnRoot = NO;
                //判断是否为复诊
                if ([_ordeDic[@"is_fuzhen"] isEqualToString:@"1"]) {
                    vc.isFuzhen = YES;
                }
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                if ([_ordeDic[@"is_fuzhen"] isEqualToString:@"1"]) {
                    
                }else{
                
                    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"询医问诊" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //打开相机
                        [_ordeDic setObject:@1 forKey:@"demand_type"];
                        [_fabuXuqiuTableView reloadData];
                    }];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"市内坐诊" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [_ordeDic setObject:@2 forKey:@"demand_type"];
                        [_fabuXuqiuTableView reloadData];
                        
                    }];
                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"活动讲座" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
                        
                        [_ordeDic setObject:@3 forKey:@"demand_type"];
                        [_fabuXuqiuTableView reloadData];
                    }];
                    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
                        //取消
                    }];
                    [controller addAction:action];
                    [controller addAction:action1];
                    [controller addAction:action2];
                    [controller addAction:action3];
                    [self.navigationController presentViewController:controller animated:YES completion:nil];
                }
            }else{
                YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]init];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
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

#pragma mark - YMBottomViewDelegate

-(void)bottomView:(YMBottomView *)bottomClick{
    NSLog(@"底部按钮点击");
    if (!_ordeDic[@"demand_type"]) {
        [self.view showErrorWithTitle:@"请选择类型" autoCloseTime:2];
        return ;
    }
    if ([NSString isEmpty:_ordeDic[@"member_id"]]) {
        [self.view showErrorWithTitle:@"请选择成员" autoCloseTime:2];
        return;
    }
    
    if ([NSString isEmpty:_ordeDic[@"small_ks"]]) {
        [self.view showErrorWithTitle:@"科室" autoCloseTime:2];
        return;
    }
    if ([_ordeDic[@"demand_type"] integerValue] == 1) {
        YMNewContentViewController *vc = [[YMNewContentViewController alloc]init];
        
        vc.orderDic = [_ordeDic mutableCopy];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YMNewUnitContentViewController *vc = [[YMNewUnitContentViewController alloc]init];
        vc.orderDic = [_ordeDic mutableCopy];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - YMFaBuSwitchTableViewCellDelegate

-(void)fabuSwitch:(YMFaBuSwitchTableViewCell *)cell setOn:(BOOL)On{
//    NSIndexPath *indexPath = [self.fabuXuqiuTableView indexPathForCell:cell];
//    if (indexPath.section ==1) {
//        [_ordeDic setObject:On?@"1":@"0" forKey:@"is_daifa"];
//    }else{
        [_ordeDic setObject:On?@"1":@"0" forKey:@"is_fuzhen"];
//    }
    
    [_fabuXuqiuTableView reloadData];
    
}
#pragma mark  --- 返回按钮点击事件 -- 
-(void)leftBtnClick:(UIButton *) sender
{

    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - YMDepartmentSelectionViewControllerDelegate
-(void)departmentView:(YMDepartmentSelectionViewController *)departmentView  disorder:(NSString *)disorder ename:(NSString *)ename big_ks:(NSString*)big_ks{
    NSLog(@"大科室disorder%@:小科室disorder:%@",disorder,big_ks);
    [_ordeDic setObject:big_ks forKey:@"big_ks"];
    [_ordeDic setObject:disorder forKey:@"small_ks"];
    _KSName = ename;
    [_fabuXuqiuTableView reloadData];
}

#pragma mark - YMInfoBaseTableViewControllerDelegate
//选择用户
-(void)infoBaseController:(YMInfoBaseTableViewController *)infoBase userInfoModel:(YMUserInfoMemberModel *)informodel{
    NSLog(@"用户ID：%@",informodel.leaguer_id);
    [_ordeDic setObject:informodel.member_id forKey:@"member_id"];
    [_ordeDic setObject:informodel.leaguer_id forKey:@"leaguer_id"];
    _userName = informodel.leagure_name;
    [_fabuXuqiuTableView reloadData];
}

#pragma mark - YMOrderViewControllerDelegate
-(void)orderView:(YMOrderViewController *)orderView andNSDict:(NSDictionary *)dict{
    self.fuzhenDict = dict;
    [_ordeDic setObject:@1 forKey:@"demand_type"];
    //科室
     _KSName = [dict objectForKey:@"small_kss"];
    //用户
     _userName = [dict objectForKey:@"leaguer_name"];
    //复诊的订单
    [_ordeDic setObject:[dict objectForKey:@"fuzhen"] forKey:@"fuzhen"];
    
    [_ordeDic setObject:[dict objectForKey:@"title"] forKey:@"title"];
    [_ordeDic setObject:[dict objectForKey:@"big_ks"] forKey:@"big_ks"];
    [_ordeDic setObject:[dict objectForKey:@"small_ks"] forKey:@"small_ks"];
    [_ordeDic setObject:[dict objectForKey:@"order_id"] forKey:@"order_id"];
    [_ordeDic setObject:[dict objectForKey:@"demand_content"] forKey:@"demand_content"];
    [_ordeDic setObject:[dict objectForKey:@"hospital_id"] forKey:@"hospital_id"];
    [_ordeDic setObject:[dict objectForKey:@"hospital_name"] forKey:@"hospital_name"];
    [_ordeDic setObject:[dict objectForKey:@"aptitude"] forKey:@"aptitude"];
    [_ordeDic setObject:[dict objectForKey:@"aptitudes"] forKey:@"aptitudes"];
    [_ordeDic setObject:[dict objectForKey:@"money"] forKey:@"money"];
    [_ordeDic setObject:[YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
    [_ordeDic setObject:[dict objectForKey:@"leaguer_id"] forKey:@"leaguer_id"];
    
    [_fabuXuqiuTableView reloadData];
}

@end
