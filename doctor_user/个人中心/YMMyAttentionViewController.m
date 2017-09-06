//
//  YMMyAttentionViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/19.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyAttentionViewController.h"
#import "YMOfficialActivityTopView.h"
#import "YMMyAttentionTableViewCell.h"

#import "YMMyAttentionModel.h"

#import "YMDoctorHomePageViewController.h"
#import "TalkingViewController.h"

static NSString *const myAttentionCell = @"myAttentionCell";


@interface YMMyAttentionViewController ()<UITableViewDelegate,UITableViewDataSource,YMOfficialActivityTopViewDelegate,YMMyAttentionTableViewCellDelegate>

@property(nonatomic,strong)UITableView *myAttentionTableView;

@property(nonatomic,strong)YMOfficialActivityTopView *officAcitvityView;

@property(nonatomic,strong)NSMutableArray<YMMyAttentionModel *> *attentionMyDoctorArry;//我的医生
@property(nonatomic,strong)NSMutableArray<YMMyAttentionModel *> *otherDoctorArry;// 其他医生

@property(nonatomic,assign)NSInteger type;//1-我的医生（有过交易的历史医生） 2-其他医生（我关注的医生）


@end

@implementation YMMyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.view.backgroundColor =RGBCOLOR(245, 245, 245);
    [self initView];
    [self initVar];
    [self requestData];
   
}


- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [self initActionSelctView];
    [self initTableView];
}
-(void)initVar{
    _attentionMyDoctorArry = [NSMutableArray array];
    _otherDoctorArry = [NSMutableArray array];
    _type = 1;
}

-(void)requestData{
    
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_page&op=myFollowList"
                                                 params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                                                          @"type":@(_type)}
                                              withModel:nil waitView:self.view
                                         complateHandle:^(id showdata, NSString *error) {
                                             if (showdata == nil) {
                                                 return ;
                                             }
                                             
                                             if ([showdata isKindOfClass:[NSArray class]]||[showdata isKindOfClass:[NSMutableArray class]]) {
                                                 for (NSDictionary *dic in showdata) {
                                                     YMMyAttentionModel *model = [YMMyAttentionModel modelWithJSON:dic];
                                                     if (_type == 1) {
                                                         [weakSelf.attentionMyDoctorArry addObject:model];
                                                     }else{
                                                         [weakSelf.otherDoctorArry addObject:model];
                                                     }
                                                 }
                                                 [weakSelf.myAttentionTableView reloadData];
                                                 
                                             }
            
    }];

}

-(void)initActionSelctView{
    _officAcitvityView = [[YMOfficialActivityTopView alloc]init];
    _officAcitvityView.lefName = @"我的医生";
    _officAcitvityView.rightName = @"关注的医生";
    _officAcitvityView.backgroundColor = [UIColor whiteColor];
    _officAcitvityView.delegate = self;
    [self.view addSubview:_officAcitvityView];
    [_officAcitvityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(45);
    }];
}
-(void)initTableView{
    _myAttentionTableView = [[UITableView alloc]init];
    _myAttentionTableView.delegate = self;
    _myAttentionTableView.dataSource = self;
    _myAttentionTableView.backgroundColor = [UIColor clearColor];
    _myAttentionTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_myAttentionTableView registerClass:[YMMyAttentionTableViewCell class] forCellReuseIdentifier:myAttentionCell];
    [self.view addSubview:_myAttentionTableView];
    [_myAttentionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_officAcitvityView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-3);
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type == 1) {
        return _attentionMyDoctorArry.count;
    }else{
        return _otherDoctorArry.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMMyAttentionTableViewCell *cell = [[YMMyAttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myAttentionCell];
    cell.isStar = YES;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_type == 1) {
        cell.model = _attentionMyDoctorArry[indexPath.row];
    }else{
        cell.model = _otherDoctorArry[indexPath.row];
    }
    [cell drawBottomLine:0 right:0];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
    if (_type == 1) {
        vc.doctorID = _attentionMyDoctorArry[indexPath.row].store_id;
    }else{
        vc.doctorID = _otherDoctorArry[indexPath.row].store_id;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark  -- 点击免费问诊btn YMMyAttentionTableViewCellDelegate
//点击免费问诊按钮事件
-(void)doctorLibaryMedicalCareBtn:(NSIndexPath *)indexPath
{

    [self initAlterView:indexPath];
}
-(void)initAlterView:(NSIndexPath *)indexPath{

    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (_type == 1) {
     [alterVC addAction:[UIAlertAction actionWithTitle:@"拨打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
         //我的医生
         YMMyAttentionModel *myDoctModel = self.attentionMyDoctorArry[indexPath.row];
         NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",myDoctModel.live_store_tel];
         UIWebView * callWebview = [[UIWebView alloc] init];
         [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
         [self.view addSubview:callWebview];
         
     }]];
    }
    [alterVC addAction:[UIAlertAction actionWithTitle:@"在线聊天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        if (_type == 1){
            YMMyAttentionModel *model = self.attentionMyDoctorArry[indexPath.row];
            TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:model.member_id];
            vc.title = model.member_names;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            YMMyAttentionModel *model = self.otherDoctorArry[indexPath.row];
            TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:model.member_id];
            vc.title = model.member_names;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alterVC animated:YES completion:nil];
}



#pragma mark - YMOfficialActivityTopViewDelegate
-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView hallButton:(UIButton *)sender{
    if (_type == 1) {
        return;
    }
    _type = 1;
    if (_attentionMyDoctorArry.count >0) {
        [self.myAttentionTableView reloadData];
    }else{
        [self requestData];
    }
}

-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView participateButton:(UIButton *)sender{
    NSLog(@"右");
    if (_type == 2) {
        return;
    }
    _type = 2;
    if (_otherDoctorArry.count >0) {
        [self.myAttentionTableView reloadData];
    }else{
        [self requestData];
    }
}


@end
