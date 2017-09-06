//
//  YMContractViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMContractViewController.h"
#import "YMBottomView.h"

#import "YMExplainAndTipTableViewCell.h"

#import "YMAppointmentTableViewCell.h"

#import "YMImportantReminderTableViewCell.h"
#import "YMDoctorAskedHeTongTableViewCell.h"
#import "YMHetongContentTableViewCell.h"
#import "YMUserContractPageModel.h"
#import "YMNewPlayerViewController.h"

static NSString *const explainAndTipCell = @"explainAndTipCell";
static NSString *const appointmentTableCell = @"appointmentTableCell";
static NSString *const importantReminderCell = @"importantReminderCell";
static NSString *const doctorAskedCell = @"doctorAskedCell";
static NSString *const heTongContentCell = @"heTongContentCell";

@interface YMContractViewController ()<UITableViewDataSource,UITableViewDelegate,YMBottomViewDelegate>

@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,strong)UITableView *contractTableView;

@property(nonatomic,strong)YMUserContractPageModel *model;

@end

@implementation YMContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"鸣医合同";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);

    
    [self initView];
    [self requrtData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [self initBottomView];
    [self initTableView];
}

-(void)initBottomView{
    _bottomView = [[YMBottomView alloc]init];
    _bottomView.type = MYBottomBlueAndwhiteType;
    _bottomView.bottomTitle = @"签订合同";
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

-(void)initTableView{
    _contractTableView = [[UITableView alloc]init];
    _contractTableView.backgroundColor = [UIColor clearColor];
    _contractTableView.delegate = self;
    _contractTableView.dataSource = self;
    _contractTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_contractTableView registerClass:[YMExplainAndTipTableViewCell class] forCellReuseIdentifier:explainAndTipCell];
    [_contractTableView registerClass:[YMAppointmentTableViewCell class] forCellReuseIdentifier:appointmentTableCell];
    [_contractTableView registerClass:[YMImportantReminderTableViewCell class] forCellReuseIdentifier:importantReminderCell];
    [_contractTableView registerClass:[YMDoctorAskedHeTongTableViewCell class] forCellReuseIdentifier:doctorAskedCell];
    [_contractTableView registerClass:[YMHetongContentTableViewCell class] forCellReuseIdentifier:heTongContentCell];
    [self.view addSubview:_contractTableView];
    [_contractTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=userContractPage"
     params:@{@"order_id":[NSString isEmpty:_order_id]?@"":_order_id}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         
         if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
             weakSelf.model = [YMUserContractPageModel modelWithJSON:showdata];
             if ([weakSelf.model.user_is_sign integerValue] == 1) {
                 _bottomView.type = MYBottomGrayType;
                 _bottomView.userInteractionEnabled = NO;
                 _bottomView.bottomTitle = @"已签订";
             }
             [weakSelf.contractTableView reloadData];
         }
         
     }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_model){
        return 5;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return [YMExplainAndTipTableViewCell heightForExplain:_model.explain forTips:_model.tips];
            break;
        case 1:{
            return 80;
        }
            break;
        case 2:{
            return  [YMImportantReminderTableViewCell heightForTipsArry:_model.tiparr];
        }break;
        case 3:{
            return [YMDoctorAskedHeTongTableViewCell heightForOtherTips:_model.other_tips];
        }break;
        case 4:{
            return [YMHetongContentTableViewCell HegithForContent:_model.content forNote:_model.note];
        }break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            YMExplainAndTipTableViewCell *cell = [[YMExplainAndTipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:explainAndTipCell];
            cell.model = _model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:{
            YMAppointmentTableViewCell *cell = [[YMAppointmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointmentTableCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor =[UIColor clearColor];
            cell.model = _model;
            return cell;
        }
            break;
        case 2:{
            YMImportantReminderTableViewCell *cell = [[YMImportantReminderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:importantReminderCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tipsArry = _model.tiparr;
            return cell;
        }
            break;
        case 3:{
            YMDoctorAskedHeTongTableViewCell *cell = [[YMDoctorAskedHeTongTableViewCell alloc]init];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.other_tips = _model.other_tips;
            return cell;
        }
            break;
        case 4:{
            YMHetongContentTableViewCell *cell = [[YMHetongContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:heTongContentCell];
            cell.model = _model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell
            ;
        }
            break;
        default:
            return nil;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - YMBottomViewDelegate
-(void)bottomView:(YMBottomView *)bottomClick{
    NSLog(@"签合同");
    
    if ([_model.diff_price integerValue] >0) {
       
        YMNewPlayerViewController *vc = [[YMNewPlayerViewController alloc]init];
        NSDictionary *dic = @{@"sn":_model.order_sn,@"should_pay":_model.diff_price};
        vc.payData = [dic copy];
        [self.navigationController pushViewController:vc animated:YES];
        [self showErrorWithTitle:@"托管金额少于实际金额，请补差价!" autoCloseTime:2];
    }else{
    
        [[KRMainNetTool sharedKRMainNetTool]
         sendRequstWith:@"act=new_order&op=userSign"
         params:@{@"order_id":[NSString isEmpty:_order_id]?@"":_order_id}
         withModel:nil
         waitView:self.view
         complateHandle:^(id showdata, NSString *error) {
             if (showdata == nil) {
                 return ;
             }
             
             [self requrtData];
         }];
    }
}
-(void)createAlertVC
{
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:nil message:@"托管金额少于实际金额，请补差价!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}




@end
