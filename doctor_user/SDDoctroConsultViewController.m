//
//  SDDoctroConsultViewController.m
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDDoctroConsultViewController.h"


#import "TalkingViewController.h"

#import "SDDoctorConsultModel.h"

#import "SDDoctorInfoTableViewCell.h"
#import "SDDoctorHonourTableViewCell.h"
#import "SDHonourOneTableViewCell.h"
#define SDDOCTORINFOTABLEVIEW_CELL  @"SDDoctorInfoTableViewCell"
#define SDDOCTORHONOURTABLEVIEW_CELL  @"SDDoctorHonourTableViewCell"
#define SDHONOURONETABLEVIEW_CELL   @"SDHonourOneTableViewCell"
@interface SDDoctroConsultViewController ()<UITableViewDelegate,UITableViewDataSource,SDDoctorInfoTableViewCellDelegate>

@property(nonatomic,strong) UITableView *doctorTableView;
@property(nonatomic,assign)BOOL detailsClick;// 点击：Yes 没点击：NO
@property(nonatomic,strong) SDDoctorConsultModel *model;
@end

@implementation SDDoctroConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"我的私人医生";
    [self initTableView];
    [self initGreenBottomView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestLoadData];
}


-(void)initTableView{
    
    self.doctorTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) ];
    [self.view addSubview:self.doctorTableView];
    //self.doctorTableView.backgroundColor = [UIColor colorWithHexString:@"#EEEFF6"];
    self.doctorTableView.delegate = self;
    self.doctorTableView.dataSource= self;
    //隐藏线条
    self.doctorTableView.separatorStyle = NO;
    //自适应高度
    self.doctorTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.doctorTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.doctorTableView registerNib:[UINib nibWithNibName:SDDOCTORINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDDOCTORINFOTABLEVIEW_CELL];
    [self.doctorTableView registerNib:[UINib nibWithNibName:SDDOCTORHONOURTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDDOCTORHONOURTABLEVIEW_CELL];
    [self.doctorTableView registerNib:[UINib nibWithNibName:SDHONOURONETABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDHONOURONETABLEVIEW_CELL];
    
}
-(void)initGreenBottomView{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor lineColor];
    [self.view addSubview:bottomView];
    
    //预约服务
    UIButton *yuyueBtn = [[UIButton alloc]init];
    [bottomView addSubview:yuyueBtn];
    [yuyueBtn setTitle:@"在线咨询" forState:UIControlStateNormal];
    [yuyueBtn setTitleColor:[UIColor NaviBackgrounColor] forState:UIControlStateNormal];
    yuyueBtn.backgroundColor = [UIColor whiteColor];
    yuyueBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [yuyueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(1);
        make.left.equalTo(bottomView.mas_left);
        make.bottom.equalTo(bottomView);
    }];
    [yuyueBtn addTarget:self action:@selector(beConsultBtnActon:) forControlEvents:UIControlEventTouchUpInside];
    
    //购买次数
    UIButton *buyCountBtn = [[UIButton alloc]init];
    [bottomView addSubview:buyCountBtn];
    [buyCountBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    buyCountBtn.backgroundColor = [UIColor NaviBackgrounColor];
    buyCountBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [buyCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yuyueBtn.mas_right).offset(0);
        make.right.equalTo(bottomView);
        make.width.equalTo(yuyueBtn.mas_width);
        make.height.equalTo(yuyueBtn.mas_height);
        make.centerY.equalTo(yuyueBtn.mas_centerY);
    }];
    [buyCountBtn addTarget:self action:@selector(iphoneConsultBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark ----UITableViewSoucre----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
       return 1;
    }else{
       return self.model.honor.count;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SDDoctorInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDDOCTORINFOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.delegate = self;
        cell.clcickEvent = _detailsClick;
        cell.model =  self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
//        if (indexPath.row ==4) {
//            
//            SDDoctorHonourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDDOCTORHONOURTABLEVIEW_CELL forIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }else{
        
            SDHonourOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDHONOURONETABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
//        }
        
    }
    return nil;
    
}
#pragma mark  --- UITableViewDelegate-----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat cellheight = 200.f;
        
        if (_detailsClick) {
            cellheight+= [SDDoctorInfoTableViewCell DetailsViewHeight:self.model.member_personal detailsClick:_detailsClick];
            
          //  cellheight +=[SDDoctorInfoTableViewCell memberPersonalInfoHeight:@"再见、不再见再见、不再见再见、不再见再见、不再见再见、不再见"];
            
        }else{
            cellheight+= [SDDoctorInfoTableViewCell DetailsViewHeight:self.model.member_personal detailsClick:_detailsClick];
        }
        return cellheight;
        
    }else{
        
        if (indexPath.row == 4) {
            
            return 160;
            
        }else{
        
            return UITableViewAutomaticDimension;
        }
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01f;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0.01f;
    }else{
    
        return 40;
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {
    
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        
        UILabel *headerLab = [[UILabel alloc]init];
        [headerView addSubview:headerLab];
        headerLab.text = @"个人荣誉";
        headerLab.textColor = [UIColor colorWithHexString:@"#000000"];
        headerLab.font = [UIFont systemFontOfSize:14];
        
        [headerLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(10);
            make.centerY.equalTo(headerView.mas_centerY);
        }];
        
        
        return headerView;
        
    }

    return  nil;
}




#pragma mark -- 查看详情按钮事件-----
-(void)HeaderTableViewCell:(SDDoctorInfoTableViewCell *)headerTableViewCell sender:(UIButton *)sender{
    _detailsClick = !_detailsClick;
    [_doctorTableView reloadData];
}

#pragma mark  --- 按钮点击事件---- 
//在线咨询
-(void)beConsultBtnActon:(UIButton *)sender{
    TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:_model.huanxinpew];
    vc.title = _model.member_names;
    [self.navigationController pushViewController:vc animated:YES];

}
//电话咨询
-(void)iphoneConsultBtnAction:(UIButton *)sender{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.live_store_tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}
#pragma mark  --- 数据相关-------

-(void)requestLoadData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendNowRequstWith:PrivateDoctorIndex_Url params:@{@"doctor_id":self.doctor_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            if (showdata == nil) {
                return ;
            }
            if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
                
                weakSelf.model = [SDDoctorConsultModel modelWithDictionary:showdata];
                
                [weakSelf.doctorTableView reloadData];
            }
            
        }else{
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
        
    }];



}
-(SDDoctorConsultModel *)model{
    
    if (!_model) {
        _model = [[SDDoctorConsultModel alloc]init];
    }
    return _model;
}
-(void)setDoctor_id:(NSString *)doctor_id{
    
    _doctor_id = doctor_id;
    
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
