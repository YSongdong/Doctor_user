//
//  YMOrderDetailsViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderDetailsViewController.h"
#import "YMOrderDetailsCenterTableViewCell.h"
#import "YMOrderDetailsImagesTableViewCell.h"
#import "YMOrderDetailsDescriptionTableViewCell.h"
#import "YMOrderDetailsUserInfoTableViewCell.h"

#import "YMDemandDetailModel.h"
static NSString *const orderDetailsUserInfoCell = @"orderDetailsUserInfoCell";
static NSString *const orderDetailsCenterCell = @"orderDetailsCenterCell";
static NSString *const orderDetailsDescriptionCell= @"orderDetailsDescriptionCell";
static NSString *const orderDetailsImages = @"orderDetailsImages";

@interface YMOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *orderDetailsTableView;
@property(nonatomic,strong)YMDemandDetailModel *model;
@property (nonatomic,strong) NSString * demand_type;


@end

@implementation YMOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initTableView];
    [self requrtData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTableView{
    UIView *kongbaiView = [[UIView alloc]init];
    [self.view addSubview:kongbaiView];
    _orderDetailsTableView = [[UITableView alloc]init];
    _orderDetailsTableView.backgroundColor = [UIColor clearColor];
    _orderDetailsTableView.delegate = self;
    _orderDetailsTableView.dataSource = self;
    //自适应高度
    _orderDetailsTableView.rowHeight = UITableViewAutomaticDimension;
    
    _orderDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_orderDetailsTableView registerClass:[YMOrderDetailsUserInfoTableViewCell class] forCellReuseIdentifier:orderDetailsUserInfoCell];
    [_orderDetailsTableView registerClass:[YMOrderDetailsCenterTableViewCell class] forCellReuseIdentifier:orderDetailsCenterCell];
    [_orderDetailsTableView registerClass:[YMOrderDetailsDescriptionTableViewCell class] forCellReuseIdentifier:orderDetailsDescriptionCell];
    [_orderDetailsTableView registerClass:[YMOrderDetailsImagesTableViewCell class] forCellReuseIdentifier:orderDetailsImages];
    [self.view addSubview:_orderDetailsTableView];
    [_orderDetailsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=demandDetail"
     params:@{@"demand_id":[NSString isEmpty:_demand_id]?@"":_demand_id}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         //找到订单类型
         self.demand_type = showdata[@"demand_type"];
         if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
             weakSelf.model = [YMDemandDetailModel modelWithJSON:showdata];
             [weakSelf.orderDetailsTableView reloadData];
         }
     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.demand_type isEqualToString:@"1"] ||[self.demand_type isEqualToString:@"0"]) {
        //询医问诊
        if (_model.demand_imgs.count >0) {
            return 8;
        }
        return 7;
    }else{
        if (_model.demand_imgs.count >0) {
            return 9;
        }
        return 8;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.demand_type isEqualToString:@"1"] ||[self.demand_type isEqualToString:@"0"]) {
        //询医问诊
        switch (indexPath.row) {
            case 0:
                return 100;
                break;
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
                return 44;
                break;
            case 6:{
                return [YMOrderDetailsDescriptionTableViewCell heightForDescriptionComment:_model.demand_content]+10;
            }break;
            case 7:{
                return _model.demand_imgs.count *315;
            }
                break;
            default:
                return 0;
                break;
        }

    }else{
        switch (indexPath.row) {
            case 0:
                return 100;
                break;
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
                return 44;
                break;
            case 7:{
                return [YMOrderDetailsDescriptionTableViewCell heightForDescriptionComment:_model.demand_content]+10;
            }break;
            case 8:{
                return _model.demand_imgs.count *315;
            }
                break;
            default:
                return 0;
                break;
        }
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.demand_type isEqualToString:@"1"] ||[self.demand_type isEqualToString:@"0"]) {
        
        //询医问诊
        if (indexPath.row == 0) {
            YMOrderDetailsUserInfoTableViewCell *cell = [[YMOrderDetailsUserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailsUserInfoCell];
            cell.model = _model;
            return cell;
        }else if(indexPath.row == 6){
            YMOrderDetailsDescriptionTableViewCell *cell = [[YMOrderDetailsDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailsDescriptionCell];
            cell.descriptionComment = _model.demand_content;
            return cell;
        }else if(indexPath.row == 7){
            YMOrderDetailsImagesTableViewCell *cell = [[YMOrderDetailsImagesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailsImages];
            cell.imageArry = _model.demand_imgs;
            return cell;
        }else{
            YMOrderDetailsCenterTableViewCell *cell = [[YMOrderDetailsCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailsCenterCell];
            
            switch (indexPath.row) {
                case 1:{
                    cell.titleName = @"需求类型:";
                    if ([self.demand_type isEqualToString:@"0"] ) {
                        cell.subTitleName = @"预约订单";
                    }else if ([self.demand_type isEqualToString:@"1"] ) {
                        cell.subTitleName = @"询医问诊";
                    }else if ([self.demand_type isEqualToString:@"2"]){
                         cell.subTitleName = @"市内坐诊";
                    }else if ([self.demand_type isEqualToString:@"3"]){
                         cell.subTitleName = @"活动讲座";
                    }
                    
                    //cell.backgroundColor = [UIColor clearColor];
                }
                    break;
                    
                case 2:{
                    cell.titleName = @"科室信息:";
                    cell.subTitleName = _model.small_ks;
                   // cell.backgroundColor = [UIColor clearColor];
                }
                    break;
                case 3:{
                    cell.titleName = @"医师资格:";
                    cell.subTitleName = _model.aptitude;
                    //cell.backgroundColor = [UIColor clearColor];
                }
                    break;
                case 4:{
                    cell.titleName = @"就诊时间:";
                    cell.subTitleName = _model.demand_time;
                }
                    break;
                case 5:{
                    cell.titleName = @"就诊区域:";
                    cell.subTitleName = _model.hospital_name;
                    //cell.backgroundColor = [UIColor clearColor];
                }
                    break;
                default:
                    break;
            }
            
            return cell;
        }

    }else{
        if (indexPath.row == 0) {
            YMOrderDetailsUserInfoTableViewCell *cell = [[YMOrderDetailsUserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailsUserInfoCell];
            cell.model = _model;
            return cell;
        }else if(indexPath.row == 7){
            YMOrderDetailsDescriptionTableViewCell *cell = [[YMOrderDetailsDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailsDescriptionCell];
            cell.descriptionComment = _model.demand_content;
            return cell;
        }else if(indexPath.row == 8){
            YMOrderDetailsImagesTableViewCell *cell = [[YMOrderDetailsImagesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailsImages];
            cell.imageArry = _model.demand_imgs;
            return cell;
        }else{
            YMOrderDetailsCenterTableViewCell *cell = [[YMOrderDetailsCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailsCenterCell];
            
            switch (indexPath.row) {
                case 1:{
                    cell.titleName = @"需求类型:";
                    if ([self.demand_type isEqualToString:@"0"] ) {
                        cell.subTitleName = @"预约订单";
                    }else if ([self.demand_type isEqualToString:@"1"] ) {
                        cell.subTitleName = @"询医问诊";
                    }else if ([self.demand_type isEqualToString:@"2"]){
                        cell.subTitleName = @"市内坐诊";
                    }else if ([self.demand_type isEqualToString:@"3"]){
                        cell.subTitleName = @"活动讲座";
                    }
                   // cell.backgroundColor = [UIColor clearColor];
                }
                    break;
                    
                case 2:{
                    cell.titleName = @"科室信息:";
                    cell.subTitleName = _model.small_ks;
                   // cell.backgroundColor = [UIColor clearColor];
                }
                    break;
                case 3:{
                    cell.titleName = @"医师资格:";
                    cell.subTitleName = _model.aptitude;
                   // cell.backgroundColor = [UIColor clearColor];
                }
                    break;
               
                case 4:{
                    cell.titleName = @"需求时间:";
                    cell.subTitleName = _model.demand_time;
                }
                    break;
                case 5:{
                    cell.titleName = @"";
                    cell.subTitleName = _model.demand_time2;
                   // cell.backgroundColor = [UIColor whiteColor];
                }
                    break;
                case 6:{
                    cell.titleName = @"需求区域:";
                    cell.subTitleName = _model.hospital_name;
                   // cell.backgroundColor = [UIColor clearColor];
                }
                    break;
                default:
                    break;
            }
            
            return cell;
        }

    }
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
