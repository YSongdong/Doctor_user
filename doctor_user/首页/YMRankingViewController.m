//
//  YMRankingViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMRankingViewController.h"
#import "YMDoctorRankingModel.h"
#import "YMRankingTableViewCell.h"
#import "YMDoctorHomePageViewController.h"


static NSString *const rankingCell = @"rankingCell";

@interface YMRankingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *rankingTableView;
@property(nonatomic,strong)NSMutableArray <YMDoctorRankingModel *> *rankingArry;
@end

@implementation YMRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"鸣医排行榜";
    [self initView];
    [self initVar];
    [self requrtData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = YES ;
}

-(void)initView{
    [self initTableView];
}

-(void)initTableView{
    
    _rankingTableView = [[UITableView alloc]init];
    _rankingTableView.delegate = self;
    _rankingTableView.dataSource = self;
    _rankingTableView.backgroundColor = [UIColor clearColor];
    
    [_rankingTableView registerClass:[YMRankingTableViewCell class] forCellReuseIdentifier:rankingCell];
    
//    _rankingTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_rankingTableView];
    [_rankingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)initVar{
    _rankingArry =[NSMutableArray array];
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_hire&op=doctorRank" params:@{} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSArray class]]||[showdata isKindOfClass:[NSMutableArray  class]]) {
            for (NSDictionary *dic in showdata) {
                [weakSelf.rankingArry addObject:[YMDoctorRankingModel modelWithJSON:dic]];
            }
            [weakSelf.rankingTableView reloadData];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rankingArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMRankingTableViewCell *cell = [[YMRankingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rankingCell];
    cell.model = _rankingArry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
    YMDoctorRankingModel *model = _rankingArry[indexPath.row];
    vc.doctorID = model.store_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
