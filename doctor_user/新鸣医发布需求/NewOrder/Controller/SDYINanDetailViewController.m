//
//  SDYINanDetailViewController.m
//  doctor_user
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDYINanDetailViewController.h"


#import "SDYiNanDetailModel.h"

#import "SDYiNanUserInfoTableViewCell.h"
#import "SDYiNanTimeDetailTableViewCell.h"
#import "SDSymptomDescTableViewCell.h"
#import "SDDetailDescTableViewCell.h"
#define SDYINANUSERINFOTABLEVIEW_CELL  @"SDYiNanUserInfoTableViewCell"
#define SDYINANTIMEDETATABLEVIEW_CELL  @"SDYiNanTimeDetailTableViewCell"
#define SDSYMPTOMDESCTABLEVIEW_CELL   @"SDSymptomDescTableViewCell"
#define SDDETAILDESCTABLEVIEW_CELL     @"SDDetailDescTableViewCell"
@interface SDYINanDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *detaTableView;

@property(nonatomic,strong)SDYiNanDetailModel *model;
@property(nonatomic,strong) NSMutableDictionary *detaDescCellDict; //详情cell的数据

@property(nonatomic,strong) UILabel *bottomStateLab; //底部状态lab
@end

@implementation SDYINanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor =[UIColor whiteColor];
    [self inintBottomView];
    [self initTableView];
   
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
     [self requestLoadData];

}
-(void)initTableView{
    
    self.detaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50-64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.detaTableView];
    self.detaTableView.delegate = self;
    self.detaTableView.dataSource = self;
    
    [self.detaTableView registerNib:[UINib nibWithNibName:SDYINANUSERINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDYINANUSERINFOTABLEVIEW_CELL];
    [self.detaTableView registerNib:[UINib nibWithNibName:SDYINANTIMEDETATABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDYINANTIMEDETATABLEVIEW_CELL];
    [self.detaTableView registerNib:[UINib nibWithNibName:SDSYMPTOMDESCTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDSYMPTOMDESCTABLEVIEW_CELL];
    [self.detaTableView registerClass:[SDDetailDescTableViewCell class] forCellReuseIdentifier:SDDETAILDESCTABLEVIEW_CELL ];

}
-(void)inintBottomView{

    UIView *bottView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
    [self.view addSubview:bottView];
    
    self.bottomStateLab = [[UILabel alloc]init];
    [bottView addSubview:self.bottomStateLab];
    self.bottomStateLab.text = @"待处理";
    self.bottomStateLab.font = [UIFont systemFontOfSize:15];
    self.bottomStateLab.textColor = [UIColor colorWithHexString:@"#FF9913"];
    [self.bottomStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottView.mas_centerX);
        make.centerY.equalTo(bottView.mas_centerY);
    }];
    
}

#pragma mark  ---- UITableViewSoucre----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 3 || section == 4 ) {
         return 1;
    }else {
        return 2;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SDYiNanUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDYINANUSERINFOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            SDYiNanTimeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDYINANTIMEDETATABLEVIEW_CELL forIndexPath:indexPath];
            cell.showTimeNameLab.text = @"最近一次就诊";
            cell.timeLabel.text = self.model.diagnosis_time;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            SDYiNanTimeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDYINANTIMEDETATABLEVIEW_CELL forIndexPath:indexPath];
            cell.showTimeNameLab.text = @"最近二次就诊";
            cell.timeLabel.text = self.model.diagnosis_times;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            SDYiNanTimeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDYINANTIMEDETATABLEVIEW_CELL forIndexPath:indexPath];
            cell.showTimeNameLab.text = @"就诊需求时间";
            cell.timeLabel.text = self.model.diseases_time;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            SDYiNanTimeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDYINANTIMEDETATABLEVIEW_CELL forIndexPath:indexPath];
            cell.showTimeNameLab.text = @"                 至";
            cell.timeLabel.text = self.model.diseases_time2;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else if (indexPath.section == 3){
       
        SDSymptomDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSYMPTOMDESCTABLEVIEW_CELL forIndexPath:indexPath];
        cell.syptomStr = self.model.title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
      
        
    }else if (indexPath.section == 4){
        
        SDDetailDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDDETAILDESCTABLEVIEW_CELL forIndexPath:indexPath];
        cell.dict = self.detaDescCellDict.copy;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return nil;

}
#pragma mar ---- UITableViewDelegate----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 100;
        
    }else if(indexPath.section == 3){
        
        return [SDSymptomDescTableViewCell cellSymptomHeight:self.model.title];
    }else if(indexPath.section == 4){
        
        return [SDDetailDescTableViewCell cellDetailDescHeight:self.detaDescCellDict.copy];
    }else{
        return 44;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01f;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f;

}

#pragma mark  -----数据相关-----
-(void)setDiseasesId:(NSString *)diseasesId{

    _diseasesId = diseasesId;

}
-(SDYiNanDetailModel *)model{

    if (!_model) {
        _model = [[SDYiNanDetailModel alloc]init];
    }
    return _model;
}
-(NSMutableDictionary *)detaDescCellDict{

    if (!_detaDescCellDict) {
        _detaDescCellDict = [NSMutableDictionary dictionary];
    }
    return _detaDescCellDict;
}


-(void)requestLoadData{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id;
    param[@"diseases_id"] = self.diseasesId;
    [[KRMainNetTool sharedKRMainNetTool]sendNowRequstWith:DisasesDeta_Url params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
       
        if (showdata == nil) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            
            weakSelf.model = [SDYiNanDetailModel modelWithDictionary:showdata];
            
            weakSelf.detaDescCellDict[@"diseases_company"] = weakSelf.model.diseases_company;
            weakSelf.detaDescCellDict[@"showTimeLab"] = @"详情描述:";
            NSMutableArray *imgs = [NSMutableArray array];
            if ( self.model.diseases_img0 != NULL) {
                [imgs addObject:weakSelf.model.diseases_img0];
            }
            if ( self.model.diseases_img1 != NULL) {
                [imgs addObject:weakSelf.model.diseases_img1];
            }
            if (  self.model.diseases_img2 != NULL ) {
                
                [imgs addObject:weakSelf.model.diseases_img2];
            }
            if ( self.model.diseases_img3 !=NULL) {
                [imgs addObject:weakSelf.model.diseases_img3];
            }
            if (self.model.diseases_img4 != NULL ) {
                
                [imgs addObject:weakSelf.model.diseases_img4];
            }
            weakSelf.detaDescCellDict[@"imgs"] = imgs.copy;
        
            //改变bottomview的状态
            if ([weakSelf.model.status isEqualToString:@"0"]) {
                weakSelf.bottomStateLab.text = @"待处理";
                weakSelf.bottomStateLab.textColor =[UIColor colorWithHexString:@"#FF9913"];
            }else if ([weakSelf.model.status isEqualToString:@"1"]){
                weakSelf.bottomStateLab.text = @"处理中";
                weakSelf.bottomStateLab.textColor =[UIColor colorWithHexString:@"#4595E6"];
            
            }else if ([weakSelf.model.status isEqualToString:@"2"]){
                weakSelf.bottomStateLab.text = @"已完成";
                weakSelf.bottomStateLab.textColor =[UIColor text999Color];
                
            }
            [weakSelf.detaTableView reloadData];
        }
        
    }];




}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

