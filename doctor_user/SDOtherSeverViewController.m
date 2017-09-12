//
//  SDOtherSeverViewController.m
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDOtherSeverViewController.h"

#import "SDHosporViewController.h"
#import "SDOtherSeverModel.h"
#import "MJRefreshAutoNormalFooter.h"

#import "SDOtherSeverTableViewCell.h"
#define SDOTHERSEVERTABLEVIEW_CELL  @"SDOtherSeverTableViewCell"
@interface SDOtherSeverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *otherTableView;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger curpage;
@end

@implementation SDOtherSeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"增值服务";
    self.curpage = 1;
    [self initTableView];
   
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self requestLoadData];

}
-(void)initTableView{

    self.otherTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) ];
    [self.view addSubview:self.otherTableView];
    self.otherTableView.backgroundColor = [UIColor colorWithHexString:@"#EEEFF6"];
    self.otherTableView.delegate = self;
    self.otherTableView.dataSource= self;
    self.otherTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.otherTableView registerNib:[UINib nibWithNibName:SDOTHERSEVERTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDOTHERSEVERTABLEVIEW_CELL];
    
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    _otherTableView.footer = footer;
    
}

#pragma mark ----UITableViewSoucre----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArr.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SDOtherSeverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDOTHERSEVERTABLEVIEW_CELL forIndexPath:indexPath];
    SDOtherSeverModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;

}
#pragma mark  --- UITableViewDelegate-----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 125;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SDOtherSeverModel *model = self.dataArr[indexPath.row];
    SDHosporViewController *sdHosporVC = [[SDHosporViewController alloc]init];
    sdHosporVC.title = model.service_title;
    sdHosporVC.url = model.service_url;
    [self.navigationController pushViewController:sdHosporVC animated:YES];

}

#pragma mark  --- 数据相关------
-(void)loadMoreData{
    _curpage ++;
    [self requestLoadData];
}
-(void)requestLoadData{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    param[@"p_health_id"] =self.p_health_id;
    param[@"curpage"] = @(_curpage);
    
    [[KRMainNetTool sharedKRMainNetTool]sendNowRequstWith:PrivateDoctorService_Url params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if (!error) {
            if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
                if (weakSelf.curpage == 1 && weakSelf.dataArr.count>0) {
                    
                    [weakSelf.dataArr removeAllObjects];
                }
                for (NSDictionary *dict in showdata) {
                    SDOtherSeverModel *model = [SDOtherSeverModel modelWithDictionary:dict];
                    [weakSelf.dataArr addObject:model];
                }
            }
            if ([self.otherTableView.footer isRefreshing]) {
                [self.otherTableView.footer endRefreshing];
            }

            [weakSelf.otherTableView reloadData];
        }else{
            
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];
    
}
-(NSMutableArray *)dataArr{

    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setP_health_id:(NSString *)p_health_id{

    _p_health_id = p_health_id;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
