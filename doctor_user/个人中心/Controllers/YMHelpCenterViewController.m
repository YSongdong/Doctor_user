//
//  YMHelpCenterViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/19.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHelpCenterViewController.h"
#import "YMAddAccountTableViewCell.h"
#import "YMHelperUsersAccountModel.h"
#import "YMHelperCenterDetailViewController.h"
#import "YMHelpDetailsViewController.h"

static NSString *const addAccountCell = @"addAccountCell";

@interface YMHelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *helpTableView;
@property(nonatomic,strong)NSMutableArray<YMHelperUsersAccountModel *> *listArry;
@end

@implementation YMHelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initView];
    [self initVar];
    [self requrtData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)initView{
    [self initTableView];
}

-(void)initVar{
    _listArry = [NSMutableArray array];
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_account&op=helpCenter" params:@{@"type":@2} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
            for (NSDictionary *dic in showdata) {
                [weakSelf.listArry addObject:[YMHelperUsersAccountModel modelWithJSON:dic]];
            }
            [weakSelf.helpTableView reloadData];
        }
        
    }];
}






-(void)initTableView{
    _helpTableView = [[UITableView alloc]init];
    _helpTableView.delegate = self;
    _helpTableView.dataSource = self;
    _helpTableView.backgroundColor = [UIColor clearColor];
    
    [_helpTableView registerClass:[YMAddAccountTableViewCell class] forCellReuseIdentifier:addAccountCell];

    
    _helpTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_helpTableView];
    [_helpTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArry.count;
}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{

    return 10;//section头部高度
}
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =[UIColor clearColor];
    return headerview ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YMAddAccountTableViewCell *cell = [[YMAddAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addAccountCell];
    cell.titleName = _listArry[indexPath.row].article_title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == _listArry.count -1) {
        cell.lastOne = YES;
    }
    if (indexPath.row != 0) {
        cell.lineInterval = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YMHelperCenterDetailViewController *vc = [[YMHelperCenterDetailViewController alloc]init];
    
//    YMHelpDetailsViewController *vc = [[YMHelpDetailsViewController alloc]init];
    vc.article_id = _listArry[indexPath.row].article_id;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
