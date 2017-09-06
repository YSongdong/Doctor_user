//
//  YMYuYueOrderViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMYuYueOrderViewController.h"
#import "YMOrderInforView.h"
#import "YMBottomView.h"
#import "YMDoctorOrderProcessModel.h"
#import "YMNewPlayerViewController.h"
#import "YMOrderSectionView.h"

#import "YMYuYueOrderInfoTableViewCell.h"
#import "YMDoctorAskedTableViewCell.h"
#import "YMOrderFuaFulfillTableViewCell.h"

#import "YMOrderContentView.h"
#import "YMOrderCommentViewController.h"
#import "YMOrderContentView.h"

#import "YMDemandBidSelectionModel.h"
#import "YMOrderDetailsViewController.h"
#import "YMContractViewController.h"
#import "YMDoctorInfoTableViewCell.h"
#import "YMDoctorHomePageViewController.h"


#import "TalkingViewController.h"

//分享
#import "SDNewShareView.h"
#import <UMSocialCore/UMSocialCore.h>

static NSString *const yuYueOrderInfoTableCell = @"yuYueOrderInfoTableCell";
static NSString *const doctorAskedTableCell = @"doctorAskedTableCell";
static NSString *const orderFuaFulfillTableCell= @"orderFuaFulfillTableCell";
static NSString *const doctorInfoTableCell = @"doctorInfoTableCell";

@interface YMYuYueOrderViewController ()<YMOrderInforViewDelegate,YMBottomViewDelegate,UITableViewDelegate,UITableViewDataSource,YMDoctorAskedTableViewCellDelegate,YMOrderFuaFulfillTableViewCellDelegate,YMOrderContentViewDelegate,YMYuYueOrderInfoTableViewCellDelegate,YMDoctorInfoTableViewCellDelegate>

@property(nonatomic,strong)YMOrderInforView *orderInfoView;
@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,strong)YMDoctorOrderProcessModel *model;

@property(nonatomic,strong)UITableView *yuYueOrderTableView;

@property(nonatomic,strong)NSArray *headerDataArry;

@property(nonatomic,strong)UIView *commentView;

@property(nonatomic,strong)YMOrderContentView *orderContentView;

@property(nonatomic,strong)NSArray *tuijianArry;


@end

@implementation YMYuYueOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initVar];
    [self initView];
    [self initShareView];
    self.title = @"预约订单";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requrtData];
}

-(void)initVar{
    _headerDataArry = @[@{@"titleNumber":@"01",
                          @"title":@"等待医生确认订单",
                          @"subTitle":@""},
                        @{@"titleNumber":@"02",
                          @"title":@"医生嘱述:",
                          @"subTitle":@""},
                        @{@"titleNumber":@"03",
                          @"title":@"完成工作，双方评价",
                          @"subTitle":@""}];
}

-(void)initView{
    [self initOrderInfoView];
    [self initBottomView];
    [self initTableView];
}
//创建分享按钮
-(void)initShareView{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(selectdShareBtnAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)initOrderInfoView{
    _orderInfoView = [[YMOrderInforView alloc]init];
    _orderInfoView.delegate = self;
    _orderInfoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_orderInfoView];
    [_orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@80);
    }];
}

-(void)initBottomView{
    _bottomView = [[YMBottomView alloc]init];
    _bottomView.type = MYBottomBlueType;
    _bottomView.bottomTitle = @"关闭订单";
    _bottomView.bottomImageName = @"power-button";
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
//    _bottomView = [[YMBottomView alloc]init];
//    _bottomView.type = MYBottomWhiteAndLeftIconType;
//    _bottomView.bottomTitle = @"联系医生";
//    _bottomView.bottomImageName = @"speech-bubble_blue";
//    _bottomView.delegate = self;
//    [self.view addSubview:_bottomView];
//    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.height.equalTo(@44);
//    }];
}


-(void)initTableView{
    _yuYueOrderTableView = [[UITableView alloc]init];
    _yuYueOrderTableView.backgroundColor = [UIColor clearColor];
    _yuYueOrderTableView.delegate = self;
    _yuYueOrderTableView.dataSource = self;
    _yuYueOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_yuYueOrderTableView registerClass:[YMYuYueOrderInfoTableViewCell class] forCellReuseIdentifier:yuYueOrderInfoTableCell];
    [_yuYueOrderTableView registerClass:[YMDoctorAskedTableViewCell class] forCellReuseIdentifier:doctorAskedTableCell];
    [_yuYueOrderTableView registerClass:[YMOrderFuaFulfillTableViewCell class] forCellReuseIdentifier:orderFuaFulfillTableCell];
    
    [_yuYueOrderTableView registerClass:[YMDoctorInfoTableViewCell class] forCellReuseIdentifier:doctorInfoTableCell];

    [self.view addSubview:_yuYueOrderTableView];
    [_yuYueOrderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_orderInfoView.mas_bottom);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=userOrderProcess"
     params:@{@"order_id":[NSString isEmpty:_order_id]?@"":_order_id}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         
         if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
             weakSelf.model = [YMDoctorOrderProcessModel modelWithJSON:showdata];
             [weakSelf refreshData];
         }
         
         //显示隐藏分享按钮
         NSString *shareStr = weakSelf.model.yuyue_status;
         if ([shareStr integerValue] == 6) {
             [[self.navigationController.navigationBar.subviews objectAtIndex:1] setHidden:NO];
         }else{
             [[self.navigationController.navigationBar.subviews objectAtIndex:1] setHidden:YES];
             
         }
         [weakSelf.yuYueOrderTableView reloadData];
     }];
}

-(void)requrtRejectYuyue{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"aact=new_order&op=rejectYuyue"
     params:@{@"order_id":_model.order_id,@"":_model.note}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         
         if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
             
             
             [weakSelf.yuYueOrderTableView reloadData];
            
         }
     }];
}

//判断bottom 显示状态
-(void)refreshData{
    _orderInfoView.doctorOrdermodel = _model;
    if ([_model.yuyue_status integerValue] == 0) {
        _bottomView.bottomTitle = @"托管酬金";
        _bottomView.bottomImageName = @"";
        // [self requrtRejectYuyue];
    }else if([_model.yuyue_status integerValue] == 1) {
        _bottomView.bottomTitle = @"关闭订单";
        _bottomView.bottomImageName = @"power-button";
        [_yuYueOrderTableView reloadData];
    }else{
        _bottomView.bottomTitle = @"联系医生";
        _bottomView.bottomImageName = @"speech-bubble_blue";
        [_yuYueOrderTableView reloadData];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([_model.yuyue_status integerValue] < 2 ) {
        return 1;
    }else if ([_model.yuyue_status integerValue] > 5) {
        return 3;
    }else{
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            return [YMYuYueOrderInfoTableViewCell heightForNote:_model.note];
        }
            break;
        case 1:{
            return [YMDoctorAskedTableViewCell DoctorAskedHeight:_model.instructions_content picNum:_model.instructions_img.count referralInfo:_model.fuzhen_tips];
        }
            break;
        case 2:{
                return 44;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    YMOrderSectionView *sectionView = [[YMOrderSectionView alloc]init];
    sectionView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:sectionView];
    NSDictionary *headerDic = _headerDataArry[section];
    sectionView.titleNumberStr =headerDic[@"titleNumber"];
    
    if (section == 0) {
        if ([_model.yuyue_status integerValue] > 2) {
             sectionView.titleLeftStr = @"医生已确认订单";
        }else{
          sectionView.titleLeftStr = headerDic[@"title"];
        }
        
    }else{
        sectionView.titleLeftStr = headerDic[@"title"];
    }
    
    
    sectionView.type = HeaderTopllTye;
    switch (section) {
        case 0:{
            switch ([_model.yuyue_status integerValue]) {
                case 0:
                    sectionView.titleRightStr = @"待支付";
                    break;
                case 1:
                    sectionView.titleRightStr = @"已付款";
                    ;
                    break;
                case 2:
                    sectionView.titleRightStr = @"签订合同";
                    break;
                case 3:
                    sectionView.titleRightStr = @"订单失败";
                    sectionView.type = HeaderFailureType;
                    break;
                default:
                    sectionView.titleRightStr = @"";
                    break;
            }
        }
            break;
        case 1:{
            if ([_model.yuyue_status integerValue]<6) {
                    sectionView.status = titleStatusGrayStatus;
                }else{
                    sectionView.status = titleStatusDefaultStatus;
                }
        }
            break;
        case 2:{
            if ([_model.yuyue_status integerValue]<5) {
                sectionView.status = titleStatusGrayStatus;
            }else{
                sectionView.status = titleStatusDefaultStatus;
            }
        }
            break;
        default:
            break;
    }
    
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(headerView);
        make.top.equalTo(headerView.mas_top).offset(10);
    }];
    return headerView;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_model.yuyue_status integerValue] == 3) {
        
        YMYuYueOrderInfoTableViewCell *cell = [[YMYuYueOrderInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:yuYueOrderInfoTableCell];
        cell.model = _model;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        switch (indexPath.section) {
            case 0:{
                YMYuYueOrderInfoTableViewCell *cell = [[YMYuYueOrderInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:yuYueOrderInfoTableCell];
                cell.model = _model;
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case 1:{
                YMDoctorAskedTableViewCell *cell = [[YMDoctorAskedTableViewCell alloc]init];
                ;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.yuYue = YES;
                cell.model =_model;
                cell.delegate = self;
                
                return cell;
            }
                break;
            case 2:{
                YMOrderFuaFulfillTableViewCell *cell = [[YMOrderFuaFulfillTableViewCell alloc]init];
                cell.delegate = self;
                cell.model = _model;
//                if ([_model.yuyue_status integerValue] == 6) {
//                    cell.whetherPay = YES;
//                    cell.evaluation = YES;
//                }else{
//                    cell.whetherPay = NO;
//                    cell.evaluation = NO;
//                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            default:
                return nil;
                break;
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
        vc.doctorID = _model.doctor_store_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - YMOrderInforViewDelegate 

-(void)orderInfoView:(YMOrderInforView *)orderView orderDetails:(UIButton *)sender{
    YMOrderDetailsViewController *vc = [[YMOrderDetailsViewController alloc]init];
    vc.demand_id = _model.demand_id;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"查看详情");
}
#pragma mark - YMBottomViewDelegate

-(void)bottomView:(YMBottomView *)bottomClick{
    if ([_model.yuyue_status integerValue] == 0) {
        NSLog(@"去支付");
        YMNewPlayerViewController *vc = [[YMNewPlayerViewController alloc]init];
        vc.payData = @{@"sn":_model.order_sn,@"should_pay":_model.should_pay};
        vc.noJump = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([_model.yuyue_status integerValue] == 1) {
        NSLog(@"关闭订单");
        UIAlertView *altkf = [[UIAlertView alloc]initWithTitle:@"是否关闭订单" message:@"关闭订单，费用将返回个人帐户如有延迟请耐心等待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        altkf.tag = 1001;
        
        [altkf show];
    }else{
        TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:_model.huanxinid];
        vc.title = _model.member_names;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 1001) {
            __weak typeof(self) weakSelf = self;
            [[KRMainNetTool sharedKRMainNetTool]
             sendRequstWith:@"act=new_order&op=closeDemand"
             params:@{@"demand_id":_model.demand_id}
             withModel:nil
             waitView:self.view
             complateHandle:^(id showdata, NSString *error) {
                 if (showdata == nil) {
                     
                     return ;
                 }
                 
                 if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
                     UIViewController *ctrl = [[weakSelf navigationController] popViewControllerAnimated:YES];
                     if (ctrl == nil) {
                         [weakSelf dismissViewControllerAnimated:YES completion:nil];
                     }
                 }
                 
             }];
        }else{
            YMOrderCommentViewController *vc = [[YMOrderCommentViewController alloc]init];
            vc.order_id = _model.order_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

#pragma mark - YMDoctorAskedTableViewCellDelegate
//付款
-(void)doctorAskedViewCell:(YMDoctorAskedTableViewCell *)doctorAskedViewCell aplayButton:(UIButton *)aplayButton{
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=surePay"
     params:@{@"order_id":_model.order_id}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         
         [self requrtData];
         
     }];
}
//仲裁
-(void)doctorAskedViewCell:(YMDoctorAskedTableViewCell *)doctorAskedViewCell arbitration:(UIButton *)arbitration{
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=arbitrate"
     params:@{@"order_id":_model.order_id}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         [self requrtData];
         
     }];
}

#pragma mark - YMOrderFuaFulfillTableViewCellDelegate
//查看评价
-(void)orderFuaFulfillCell:(YMOrderFuaFulfillTableViewCell *)cell lookevaluationButton:(UIButton *) sender{
    NSLog(@"查看评价");
    
    YMOrderCommentViewController *vc = [[YMOrderCommentViewController alloc]init];
    vc.order_id = _model.order_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//去评价
-(void)orderFuaFulfillCell:(YMOrderFuaFulfillTableViewCell *)cell evaluationButton:(UIButton *)sender{
    NSLog(@"去评价");
    [self requrtPingTags];
    _commentView = [[UIView alloc]init];
    
    
    [self.view addSubview:_commentView];
    
    [UIView animateWithDuration:0.2 animations:^{
        [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            self.navigationController.navigationBarHidden = YES;
        }];
    } completion:^(BOOL finished) {
        _commentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBalance:)];
    [_commentView addGestureRecognizer:tap];
    
    
    _orderContentView = [[YMOrderContentView alloc]init];
    _orderContentView.delegate = self;
    
    [_commentView addSubview:_orderContentView];
    
    [_orderContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_commentView);
        make.height.equalTo(@250);
    }];
    
}

-(void)requrtPingTags{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=getPingTags"
     params:nil
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         
         if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
             weakSelf.orderContentView.labeArry = [showdata copy];
         }
         
     }];
}

-(void)hiddenBalance:(UITapGestureRecognizer *)tapGesture{
    self.navigationController.navigationBarHidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
    } completion:^(BOOL finished) {
        [_commentView removeAllSubviews];
        [_commentView removeFromSuperview];
        
    }];
}

#pragma mark - YMOrderContentViewDelegate

-(void)orderContentView:(YMOrderContentView *)view userSubPing:(NSDictionary *)commentDic submitButton:(UIButton *)sender{
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:2];
    YMOrderFuaFulfillTableViewCell *cell = [self.yuYueOrderTableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *dic =  [commentDic mutableCopy];
    [dic setObject:_model.order_id forKey:@"order_id"];
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=userSubPing"
     params:dic
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         [self hiddenBalance:nil];
         NSLog(@"评论成功");
         UIAlertView *altkf = [[UIAlertView alloc]initWithTitle:@"恭喜你，评论成功" message:@"顺便看看TA对我的评价吧" delegate:self cancelButtonTitle:@"不用了" otherButtonTitles:@"去看看", nil];
         altkf.tag = 1002;
         [altkf show];
         
         //改变评价
         cell.evaluation = YES;
     }];
}

-(void)orderContentView:(YMOrderContentView *)view changeButton:(UIButton *)sender{
    [self requrtPingTags];
}

-(void)orderContentView:(YMOrderContentView *)view closeButton:(UIButton *)sender{
    [self hiddenBalance:nil];
}



#pragma mark - YMYuYueOrderInfoTableViewCellDelegate
//查看合同
-(void)yuYueOrderView:(YMYuYueOrderInfoTableViewCell *)cell lookHeTongClick:(UIButton *)sender{
    YMContractViewController *vc = [[YMContractViewController alloc]init];
    vc.order_id = _model.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}

//签合同
-(void)yuYueOrderView:(YMYuYueOrderInfoTableViewCell *)cell qianHeTongClick:(UIButton *)sender{
    YMContractViewController *vc = [[YMContractViewController alloc]init];
    vc.order_id = _model.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}
//支付
-(void)yuYueOrderView:(YMYuYueOrderInfoTableViewCell *)cell payServerCharge:(UIButton *)sender{
    
}

#pragma mark - YMDoctorInfoTableViewCellDelegate

-(void)doctorInfoCell:(YMDoctorInfoTableViewCell *)cell bidModel:(YMBidListModel *)bidModel{
    
}
#pragma mark  --- 分享-----
-(void)selectdShareBtnAction{
    
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    
    NSMutableArray *titlearr = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:5];
    
    int startIndex = 0;
    
    if (hadInstalledWeixin) {
        [titlearr addObjectsFromArray:@[@"微信", @"微信朋友圈"]];
        [imageArr addObjectsFromArray:@[@"person",@"friends"]];
    } else {
        startIndex += 2;
    }
    //
    //    if (hadInstalledQQ) {
    //        [titlearr addObjectsFromArray:@[@"QQ", @"QQ空间"]];
    //        [imageArr addObjectsFromArray:@[@"qq",@"qzone"]];
    //    } else {
    //        startIndex += 2;
    //    }
    //
    //    [titlearr addObjectsFromArray:@[@"微博"]];
    //    [imageArr addObjectsFromArray:@[@"sina"]];
    
    __weak typeof(self) weakSelf = self;
    
    SDNewShareView *newShareView = [[SDNewShareView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"分享到"];
    [newShareView setBtnClick:^(NSInteger btnTag) {
        NSLog(@"\n点击第几个====%d\n当前选中的按钮title====%@",(int)btnTag,titlearr[btnTag]);
        switch (btnTag + startIndex) {
            case 0: {
                // 微信
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatSession];
            }
                break;
            case 1: {
                // 微信朋友圈
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            }
                break;
            case 2: {
                // QQ
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_QQ];
            }
                break;
            case 3: {
                // QQ空间
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_Qzone];
            }
                break;
            case 4: {
                // 微博
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_Sina];
            }
                break;
            default:
                break;
        }
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:newShareView];
    
    
}
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title =@"分享";
    
    //分享内容
    NSMutableString *concent = [NSMutableString string];
    [concent appendString:self.model.member_names];
    [concent appendString:[NSString stringWithFormat:@" %@",self.model.member_ks]];
    [concent appendString:@" 我在鸣医通上面轻松预约到了他,很有耐心......"];
    
    //创建图片内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"" descr:concent thumImage:[UIImage imageNamed:@"share_iconImg"]];
    
    NSString *url;
    url = @"http://weixin.ys9958.com/index.php/Wap/Invite/OrderSharing?";
    NSString *urlStr = [NSString stringWithFormat:@"%@order=%@",url,self.model.order_id];
    
    shareObject.webpageUrl =urlStr;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
    
}



@end
