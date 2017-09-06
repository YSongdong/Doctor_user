//
//  SDHealthyStateFormViewController.m
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDHealthyStateFormViewController.h"


#import "SDHealthyManagerViewController.h"


#import "SDStateFormExplairTableViewCell.h"
#import "SDDoctorGroupTableViewCell.h"
#import "SDGreenChannelTableViewCell.h"
#import "SDHealthyManagerTableViewCell.h"
#define SDSTATEFORMEXPLAIRTABLEVIEE_CELL @"SDStateFormExplairTableViewCell"
#define SDDOCTORGROUPTABLEVIEW_CELL  @"SDDoctorGroupTableViewCell"
#define SDGREENCHANNELTABLEVIEW_CELL @"SDGreenChannelTableViewCell"
#define SDHEALTHYMANAGERTABLEVIEW_CELL @"SDHealthyManagerTableViewCell"
@interface SDHealthyStateFormViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *formTableView;

@property (nonatomic,strong) UILabel *reportCountLab; //报告数



@end

@implementation SDHealthyStateFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUITableView];
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
            return 5;
        }else if ([self.btnType isEqualToString:@"4"]){
            return 1;
        }else if ([self.btnType isEqualToString:@"6"]){
            return 2;
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
        if ([self.btnType isEqualToString:@"4"]) {
            //绿色住院通道
            SDGreenChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDGREENCHANNELTABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else  if ([self.btnType isEqualToString:@"6"]) {
            //医生服务到家
            SDHealthyManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDHEALTHYMANAGERTABLEVIEW_CELL forIndexPath:indexPath];
            cell.ManagerType= self.btnType;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            
            SDDoctorGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDDOCTORGROUPTABLEVIEW_CELL forIndexPath:indexPath];
            cell.classType = self.btnType;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        }
        tijianLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        tijianLabel.font = [UIFont systemFontOfSize:15];
        [tijianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(10);
            make.centerY.equalTo(headerView.mas_centerY);
        }];
        
        self.reportCountLab = [[UILabel alloc]init];
        [headerView addSubview:self.reportCountLab];
        self.reportCountLab.text = @"( 1 / 2 )";
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
        healthyManagerVC.btnType = @"7";
        [self.navigationController pushViewController:healthyManagerVC animated:YES];
        
    }
    



}
//购买次数
-(void)buyCountBtnAction:(UIButton *)sender{

    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
