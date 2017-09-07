//
//  SDHealthyStateFormViewController.m
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDHealthyStateFormViewController.h"


#import "SDHealthyManagerViewController.h"
#import "SDStateReportModel.h"

//下载
#import "DownLoadManager.h"


#import "SDStateFormExplairTableViewCell.h"
#import "SDDoctorGroupTableViewCell.h"
#import "SDGreenChannelTableViewCell.h"
#import "SDHealthyManagerTableViewCell.h"
#define SDSTATEFORMEXPLAIRTABLEVIEE_CELL @"SDStateFormExplairTableViewCell"
#define SDDOCTORGROUPTABLEVIEW_CELL  @"SDDoctorGroupTableViewCell"
#define SDGREENCHANNELTABLEVIEW_CELL @"SDGreenChannelTableViewCell"
#define SDHEALTHYMANAGERTABLEVIEW_CELL @"SDHealthyManagerTableViewCell"
@interface SDHealthyStateFormViewController () <UITableViewDelegate,UITableViewDataSource,SDDoctorGroupTableViewCellDelegate,UIDocumentInteractionControllerDelegate>

@property (nonatomic,strong) UITableView *formTableView;
@property (nonatomic,strong) SDStateReportModel *model;
@property (nonatomic,strong) UILabel *reportCountLab; //报告数
@property (nonatomic,strong) UIDocumentInteractionController *documentController;//阅读

@end

@implementation SDHealthyStateFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUITableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestDataWithUrl];

}


-(void)initUITableView{
    if ([self.btnType isEqualToString:@"1"]) {
        self.title = @"个人健康状态表";
        self.formTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    }else if ([self.btnType isEqualToString:@"3"]){
        self.title = @"名医体检解读";
        [self initBottomView];
        self.formTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-100) style:UITableViewStyleGrouped];
        
    }else if ([self.btnType isEqualToString:@"4"]){
        self.title = @"绿色住院通道";
        [self initGreenBottomView];
        self.formTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
        
    }else if ([self.btnType isEqualToString:@"6"]){
        self.title = @"医生服务到家";
        [self initGreenBottomView];
        self.formTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
        
    }else if ([self.btnType isEqualToString:@"8"]){
        self.title = @"绿色就诊通道";
        [self initGreenBottomView];
        self.formTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
        
    }
    [self.view addSubview:self.formTableView];
    self.formTableView.delegate = self;
    self.formTableView.dataSource = self;
    //隐藏线条
    self.formTableView.separatorStyle =NO;

    [self.formTableView registerNib:[UINib nibWithNibName:SDSTATEFORMEXPLAIRTABLEVIEE_CELL bundle:nil] forCellReuseIdentifier:SDSTATEFORMEXPLAIRTABLEVIEE_CELL];
    [self.formTableView registerNib:[UINib nibWithNibName:SDDOCTORGROUPTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDDOCTORGROUPTABLEVIEW_CELL];
    [self.formTableView registerNib:[UINib nibWithNibName:SDGREENCHANNELTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDGREENCHANNELTABLEVIEW_CELL];
    [self.formTableView registerNib:[UINib nibWithNibName:SDHEALTHYMANAGERTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDHEALTHYMANAGERTABLEVIEW_CELL];
}
-(void)initBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-100, SCREEN_WIDTH, 100)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#acacac"];
    [self.view addSubview:bottomView];
    
    //其他服务
    UILabel *otherLabel = [[UILabel alloc]init];
    [bottomView addSubview:otherLabel];
    otherLabel.text = @"注：超过套餐后，如果需要报告解读，单次解读价格为299元/次";
    otherLabel.font = [UIFont systemFontOfSize:12];
    otherLabel.numberOfLines = 2;
    otherLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.left.equalTo(bottomView.mas_left).offset(10);
        make.right.equalTo(bottomView.mas_right).offset(-10);
    }];
    
    //拨打电话
    UIButton *countBtn  =[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(bottomView.frame)-50, SCREEN_WIDTH, 50)];
    countBtn.backgroundColor = [UIColor NaviBackgrounColor];
    [countBtn addTarget:self action:@selector(onCountAction:) forControlEvents:UIControlEventTouchUpInside];
    [countBtn setTitle:@"购买次数" forState:UIControlStateNormal];
    countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:countBtn];
    
}
-(void)initGreenBottomView{

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor lineColor];
    [self.view addSubview:bottomView];
    
    //预约服务
    UIButton *yuyueBtn = [[UIButton alloc]init];
    [bottomView addSubview:yuyueBtn];
    [yuyueBtn setTitle:@"预约服务" forState:UIControlStateNormal];
    [yuyueBtn setTitleColor:[UIColor NaviBackgrounColor] forState:UIControlStateNormal];
    yuyueBtn.backgroundColor = [UIColor whiteColor];
    yuyueBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [yuyueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(1);
        make.left.equalTo(bottomView.mas_left);
        make.bottom.equalTo(bottomView);
    }];
    [yuyueBtn addTarget:self action:@selector(onYuyueBtnActon:) forControlEvents:UIControlEventTouchUpInside];
    
    //购买次数
    UIButton *buyCountBtn = [[UIButton alloc]init];
    [bottomView addSubview:buyCountBtn];
    [buyCountBtn setTitle:@"购买次数" forState:UIControlStateNormal];
    buyCountBtn.backgroundColor = [UIColor NaviBackgrounColor];
    buyCountBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [buyCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yuyueBtn.mas_right).offset(0);
        make.right.equalTo(bottomView);
        make.width.equalTo(yuyueBtn.mas_width);
        make.height.equalTo(yuyueBtn.mas_height);
        make.centerY.equalTo(yuyueBtn.mas_centerY);
    }];
    [buyCountBtn addTarget:self action:@selector(buyCountBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark  ---UITableView---
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if ([self.btnType isEqualToString:@"1"]) {
            return 2; 
        }else if ([self.btnType isEqualToString:@"3"]){
           // 3 鸣医体检解读
            return self.model.report.count;
            
        }else if ([self.btnType isEqualToString:@"4"]){
            //绿色住院通道
           return self.model.report.count;
        }else if ([self.btnType isEqualToString:@"6"]){
            //医生服务到家
            return self.model.report.count;
        }else if ([self.btnType isEqualToString:@"8"]){
            //绿色就诊通道
            return self.model.report.count;
        }
        
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        SDStateFormExplairTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSTATEFORMEXPLAIRTABLEVIEE_CELL forIndexPath:indexPath];
        cell.textType =self.btnType;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if ([self.btnType isEqualToString:@"4"] || [self.btnType isEqualToString:@"8"]) {
            //绿色住院通道
            SDGreenChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDGREENCHANNELTABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dict = self.model.report[indexPath.row];
            [cell setdictManageType:self.btnType andIndexPath:indexPath andWithDict:dict];
            return cell;
        }else  if ([self.btnType isEqualToString:@"6"]) {
            //医生服务到家
            SDHealthyManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDHEALTHYMANAGERTABLEVIEW_CELL forIndexPath:indexPath];
            NSDictionary *dict = self.model.report[indexPath.row];
            [cell setdictManageType:self.btnType andIndexPath:indexPath andWithDict:dict];
           // cell.ManagerType= self.btnType;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            
            SDDoctorGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDDOCTORGROUPTABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.classType = self.btnType;
            cell.indexPath = indexPath;
            cell.delegate = self;
            NSDictionary *dict = self.model.report[indexPath.row];
            [cell setdictManageType:self.btnType andIndexPath:indexPath andWithDict:dict];
            
            BOOL  isDownFinish = [self isFinishExistFilesName:nil];
            if (isDownFinish) {
                cell.isOpen = YES;
            }
           
            return cell;
        }
    }
    return nil;
}
#pragma amrk ----UITableViewDelegate-----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if ([self.btnType isEqualToString:@"1"]) {
           return 154;
        }else if ([self.btnType isEqualToString:@"3"]) {
            return 170;
        }else if ([self.btnType isEqualToString:@"4"]) {
            return 190;
        }else if ([self.btnType isEqualToString:@"6"]) {
            return 190;
        }else if ([self.btnType isEqualToString:@"8"]) {
            return 190;
        }

    }else{
        if ([self.btnType isEqualToString:@"1"]) {
            return 90;
        }else if ([self.btnType isEqualToString:@"3"]) {
           return 90;
        }else if ([self.btnType isEqualToString:@"4"]) {
            return 67;
        }else if ([self.btnType isEqualToString:@"6"]) {
            return 67;
        }else if ([self.btnType isEqualToString:@"8"]) {
            return 67;
        }
       
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01f;
    }else{
        return 38;
    
     }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        UIView *headerView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tijianLabel = [[UILabel alloc]init];
        [headerView addSubview:tijianLabel];
        if ([self.btnType isEqualToString:@"1"]) {
           tijianLabel.text =@"体检报告";
        }else if ([self.btnType isEqualToString:@"3"]){
            tijianLabel.text =@"报告解读";
        }else if ([self.btnType isEqualToString:@"4"]){
            tijianLabel.text =@"服务次数";
        }else if ([self.btnType isEqualToString:@"6"]){
            tijianLabel.text =@"服务到家";
        }else if ([self.btnType isEqualToString:@"8"]){
            tijianLabel.text =@"服务次数";
        }
        tijianLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        tijianLabel.font = [UIFont systemFontOfSize:15];
        [tijianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(10);
            make.centerY.equalTo(headerView.mas_centerY);
        }];
        
        self.reportCountLab = [[UILabel alloc]init];
        [headerView addSubview:self.reportCountLab];
        if (![self.model.physical_examination isEqualToString:@"0"]) {
            self.reportCountLab.text =[NSString stringWithFormat:@"(%@/%@)",self.model.physical_examination_con,self.model.physical_examination];
        }else{
            self.reportCountLab.text = @"( 1 / 2 )";
        }
        self.reportCountLab.textColor = [UIColor NaviBackgrounColor];
        self.reportCountLab.font = [UIFont systemFontOfSize:15];
        [self.reportCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tijianLabel.mas_right).offset(5);
            make.centerY.equalTo(tijianLabel.mas_centerY);
        }];
        
        return headerView;
    }
    return nil;

}
#pragma mark -----bottomView按钮点击事件-----
//名医体检解读
-(void)onCountAction:(UIButton *)sender{
    if ([self.btnType isEqualToString:@"3"]) {
        //购买次数
        
    }
    
}
//预约服务
-(void)onYuyueBtnActon:(UIButton *)sender{
    if ([self.btnType isEqualToString:@"6"]) {
        //医生服务到家
        self.hidesBottomBarWhenPushed = YES;
        SDHealthyManagerViewController *healthyManagerVC = [[SDHealthyManagerViewController alloc]init];
        healthyManagerVC.p_health_id = self.p_health_id;
        healthyManagerVC.btnType = @"7";
        [self.navigationController pushViewController:healthyManagerVC animated:YES];
        
    }else if ([self.btnType isEqualToString:@"4"]) {
        //绿色住院通到
        self.hidesBottomBarWhenPushed = YES;
        SDHealthyManagerViewController *healthyManagerVC = [[SDHealthyManagerViewController alloc]init];
        healthyManagerVC.p_health_id = self.p_health_id;
        healthyManagerVC.btnType = @"4";
        [self.navigationController pushViewController:healthyManagerVC animated:YES];
        
    }else if ([self.btnType isEqualToString:@"8"]) {
        //绿色住院通到
        self.hidesBottomBarWhenPushed = YES;
        SDHealthyManagerViewController *healthyManagerVC = [[SDHealthyManagerViewController alloc]init];
        healthyManagerVC.p_health_id = self.p_health_id;
        healthyManagerVC.btnType = @"8";
        [self.navigationController pushViewController:healthyManagerVC animated:YES];
        
    }
    



}
//购买次数
-(void)buyCountBtnAction:(UIButton *)sender{

    


}
#pragma mark ----cell点击下载事件-------
-(void)selectdDownBtnIndexPath:(NSIndexPath *)indexPath{
  //  SDStateReportModel *model = self.dataArr[indexPath.row];
    
    

}
-(void) starDownIndexPath:(NSIndexPath *)indexPath{
    // 启动任务
    __weak typeof(self) weakSelf = self;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"下载中";
    hud.contentColor= [UIColor blackColor];
    
    [[DownLoadManager sharedInstance]downLoadWithURL:nil progress:^(float progress) {
        
        hud.progress = progress;
        
    } success:^(NSString *fileStorePath) {
        NSLog(@"###%@",fileStorePath);
        //关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
        //下载完成
        SDDoctorGroupTableViewCell *cell = [weakSelf.formTableView cellForRowAtIndexPath:indexPath];
        cell.isOpen = YES;
        
    } faile:^(NSError *error) {
        [weakSelf.view showErrorWithTitle:error.userInfo[NSLocalizedDescriptionKey] autoCloseTime:2];
        //关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }];
    
}
//判断文件是否存在
-(BOOL) isFinishExistFilesName:(NSString *)name{
    BOOL isExist =  NO;
    NSArray *dataArr = [[DownLoadManager sharedInstance]setObtainFilesAll];
    NSString *filesPath = name.md5String;
    for (NSString *str in dataArr) {
        if ([str isEqualToString:filesPath]) {
            isExist = YES;
        }
    }
    return isExist;
}

//预览
-(void) openReadAppFilesName:(NSString *)filesName{
    NSString *filesPath =[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:filesName];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filesPath]];
    self.documentController.delegate = self;
    
    self.documentController.UTI = @"com.microsoft.word.doc";
    
    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    
}
#pragma mark - UIDocumentInteractionController 代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.bounds;
}


#pragma mark  ---- 数据相关------
- (void)requestDataWithUrl {
    if ([self.btnType isEqualToString:@"3"]) {
        //名医体检解读
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"p_health_id"] =self.p_health_id;
        param[@"type"] =@"2";
        [self requestLoadDataWithUrl:PrivateDoctorReport_Url andParams:param.copy];
    }else  if ([self.btnType isEqualToString:@"6"]) {
        //医生服务到家--预约列表
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"p_health_id"] =self.p_health_id;
        param[@"type"] =@"2";
        [self requestLoadDataWithUrl:PrivateDoctorMentList_Url andParams:param.copy];
    }else  if ([self.btnType isEqualToString:@"4"]) {
        //绿色住院通道--预约列表
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"p_health_id"] =self.p_health_id;
        param[@"type"] =@"3";
        [self requestLoadDataWithUrl:PrivateDoctorMentList_Url andParams:param.copy];
    }else  if ([self.btnType isEqualToString:@"8"]) {
        //绿色住院通道--预约列表
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"p_health_id"] =self.p_health_id;
        param[@"type"] =@"4";
        [self requestLoadDataWithUrl:PrivateDoctorMentList_Url andParams:param.copy];
    }

}
-(void) requestLoadDataWithUrl:(NSString *)url andParams:(NSDictionary *)param{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendNowRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            if (showdata  == nil) {
                return ;
            }
            if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
                weakSelf.model = [SDStateReportModel modelWithDictionary:showdata];
               
                [weakSelf.formTableView reloadData];
                
            }
            
        }else{
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
        
    }];

}
-(SDStateReportModel *)model{
    
    if (!_model) {
        _model =[[SDStateReportModel alloc]init];
    }
    
    return _model;
}
-(void)setBtnType:(NSString *)btnType{
    _btnType = btnType;
    
}
-(void)setP_health_id:(NSString *)p_health_id{
    
    _p_health_id = p_health_id;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
