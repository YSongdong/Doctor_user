//
//  SDMinePrivateDoctorViewController.m
//  doctor_user
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDMinePrivateDoctorViewController.h"


#import "SDHealthyStateFormViewController.h"
#import "SDHealthyManagerViewController.h"
#import "SDOtherSeverViewController.h"
#import "SDFilesMeesageViewController.h"
#import "SDDoctroConsultViewController.h"

#import "SDMyPrivateDoctorModel.h"


#import "SDMineInfoTableViewCell.h"
#import "SDSeverTypeTableViewCell.h"
#define SDMINEINFOTABLEVIEW_CELL  @"SDMineInfoTableViewCell"
#define SDSEVERTYPETABLEVIEW_CELL  @"SDSeverTypeTableViewCell"
@interface SDMinePrivateDoctorViewController ()<UITableViewDelegate,UITableViewDataSource,SDMineInfoTableViewCellDelegate,SDSeverTypeTableViewCellDelegate>

@property(nonatomic,strong) UITableView *privDoctTableView;
@property(nonatomic,strong) SDMyPrivateDoctorModel *model;
@property(nonatomic,strong) UILabel *telLabel; //bottomLab联系电话
@end

@implementation SDMinePrivateDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的私人医生";
    [self initRightBtn];
    [self inintUITableView];
    [self initBottomView];
    
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestLoadData];

}
-(void)initRightBtn{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 23)];
    [rightBtn setTitle:@"续费" forState:UIControlStateNormal];
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    rightBtn.layer.cornerRadius = 5;
    rightBtn.layer.masksToBounds = YES;
    [rightBtn addTarget:self action:@selector(addCostBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

}
-(void)initBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-100, SCREEN_WIDTH, 100)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#acacac"];
    [self.view addSubview:bottomView];
    
    //其他服务
    UILabel *otherLabel = [[UILabel alloc]init];
    [bottomView addSubview:otherLabel];
    otherLabel.text = @"其他增值服务:VIP健康沙龙、高端商务酒会、护理服务、车险服务、法律咨询服务 (点击查看具体活动及相关服务)";
    otherLabel.font = [UIFont systemFontOfSize:12];
    otherLabel.numberOfLines = 2;
    otherLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.left.equalTo(bottomView.mas_left).offset(10);
        make.right.equalTo(bottomView.mas_right).offset(-10);
    }];
    
    //拨打电话
    UIButton *telBtn  =[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(bottomView.frame)-50, SCREEN_WIDTH, 50)];
    telBtn.backgroundColor = [UIColor whiteColor];
    [telBtn addTarget:self action:@selector(telBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:telBtn];
    
    self.telLabel = [[UILabel alloc]init];
    [telBtn addSubview:self.telLabel];
    self.telLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.telLabel.text = @"责任私人医生: 李海权-153153646";
    self.telLabel.font = [UIFont systemFontOfSize:14];
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(telBtn.mas_left).offset(10);
        make.centerY.equalTo(telBtn.mas_centerY);
    }];
    
    UIImageView *telImageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_TelNumber"]];
    [telBtn addSubview:telImageView];
    [telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(telBtn.mas_right).offset(-10);
        make.centerY.equalTo(_telLabel.mas_centerY);
    }];
    
}

-(void) inintUITableView{

    self.privDoctTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    [self.view addSubview:self.privDoctTableView];
    self.privDoctTableView.delegate = self;
    self.privDoctTableView.dataSource = self;
    self.privDoctTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.privDoctTableView registerNib:[UINib nibWithNibName:SDMINEINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDMINEINFOTABLEVIEW_CELL];
     [self.privDoctTableView registerNib:[UINib nibWithNibName:SDSEVERTYPETABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDSEVERTYPETABLEVIEW_CELL];
}
#pragma mark -- UITableViewScoure---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SDMineInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDMINEINFOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.model = self.model;
        return cell;
  
    }else{
        SDSeverTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSEVERTYPETABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.model = self.model;
        return cell;
    
    }

}
#pragma mark --- UItableViewDelegate----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 190;
    } else{
       return 280;
    }

}

#pragma mark  ---- 点击续费按钮事件=-----
//续费
-(void)addCostBtnAction:(UIButton *)sender{


    

}
#pragma mark  --- 个人健康按钮事件-------
//个人健康状况
-(void)selectdHealthyStatesBtn:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    SDFilesMeesageViewController *filesVC = [[SDFilesMeesageViewController alloc]init];
    filesVC.p_health_id = self.model.p_health_id;
    [self.navigationController pushViewController:filesVC animated:YES];

}
//健康管理方案
-(void)selectdHealthyManamgerBtn:(UIButton *)sender{
   
}
//体检报告查看
-(void)selectdTiJianBtn:(UIButton *)sender{
    
    self.hidesBottomBarWhenPushed = YES;
    SDHealthyStateFormViewController *healthyStateVC= [[SDHealthyStateFormViewController alloc]init];
    healthyStateVC.btnType =@"1";
    [self.navigationController pushViewController:healthyStateVC animated:YES];

}
#pragma mark  --- 服务按钮事件--------
-(void)selectdSeverBtnTag:(NSInteger)tag{

    switch (tag) {
        case 0:
        {
          //全身健康体检
        
        }
            break;
        case 1:
        {
            //名医体检解读
            self.hidesBottomBarWhenPushed = YES;
            SDHealthyStateFormViewController *healthyStateVC= [[SDHealthyStateFormViewController alloc]init];
            healthyStateVC.p_health_id = self.model.p_health_id;
            healthyStateVC.btnType =@"3";
            [self.navigationController pushViewController:healthyStateVC animated:YES];
        }
            
            break;
        case 2:
        {
            //医生专属咨询
            self.hidesBottomBarWhenPushed = YES;
            SDDoctroConsultViewController *doctorCousultVC = [[SDDoctroConsultViewController alloc]init];
            doctorCousultVC.doctor_id =self.model.doctor_id;
            [self.navigationController pushViewController:doctorCousultVC animated:YES];
        }
            break;
        case 3:
        {
            //医生服务到家
            self.hidesBottomBarWhenPushed = YES;
            SDHealthyStateFormViewController *healthyStateVC= [[SDHealthyStateFormViewController alloc]init];
            healthyStateVC.p_health_id = self.model.p_health_id;
            healthyStateVC.btnType =@"6";
            [self.navigationController pushViewController:healthyStateVC animated:YES];
        }
            break;
        case 4:
        {
            //健康管理方案
            self.hidesBottomBarWhenPushed = YES;
            SDHealthyManagerViewController *managerVC = [[SDHealthyManagerViewController alloc]init];
            
            managerVC.p_health_id= self.model.p_health_id;
            managerVC.btnType = @"2";
            [self.navigationController pushViewController:managerVC animated:YES];
        }
            break;
        case 5:
        {
            //绿色住院通道
            self.hidesBottomBarWhenPushed = YES;
            SDHealthyStateFormViewController *healthyStateVC= [[SDHealthyStateFormViewController alloc]init];
            healthyStateVC.p_health_id = self.model.p_health_id;
            healthyStateVC.btnType =@"4";
            [self.navigationController pushViewController:healthyStateVC animated:YES];
        }
            break;
        case 6:
        {
            //绿色就诊通道
            self.hidesBottomBarWhenPushed = YES;
            SDHealthyStateFormViewController *healthyStateVC= [[SDHealthyStateFormViewController alloc]init];
            healthyStateVC.p_health_id = self.model.p_health_id;
            healthyStateVC.btnType =@"8";
            [self.navigationController pushViewController:healthyStateVC animated:YES];
        }
            break;
        case 7:
        {
            //年度健康报告
            self.hidesBottomBarWhenPushed = YES;
            SDHealthyManagerViewController *managerVC = [[SDHealthyManagerViewController alloc]init];
            managerVC.btnType = @"5";
            managerVC.p_health_id= self.model.p_health_id;
            [self.navigationController pushViewController:managerVC animated:YES];
        }
            break;
        case 8:
        {
            //其他增值服务
            self.hidesBottomBarWhenPushed = YES;
            SDOtherSeverViewController *otherSeverVC = [[SDOtherSeverViewController alloc]init];
            [self.navigationController pushViewController:otherSeverVC animated:YES];
        }
            break;
        default:
            break;
    }

}

//拨打私人医生电话
-(void)telBtnAction:(UIButton *)sender{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.member_mobiles];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}
#pragma mark  --- 数据相关------
-(SDMyPrivateDoctorModel *)model{

    if (!_model) {
        _model = [[SDMyPrivateDoctorModel alloc]init];
    }
    return _model;

}
-(void)requestLoadData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendNowRequstWith:PrivateDoctor_Url params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if (!error) {
            if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
                weakSelf.model = [SDMyPrivateDoctorModel modelWithDictionary:showdata];
            }
            weakSelf.telLabel.text =[NSString stringWithFormat:@"责任私人医生:%@-%@",weakSelf.model.member_names,weakSelf.model.member_mobiles];
            [weakSelf.privDoctTableView reloadData];
        }else{
            
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
