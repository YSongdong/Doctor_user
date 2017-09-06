//
//  YMSeekingConsultationViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSeekingConsultationViewController.h"
#import "YMOrderInforView.h"
#import "YMBottomView.h"
#import "YMDoctorOrderProcessModel.h"

#import "YMDoctorAskedTableViewCell.h"//医生嘱述
#import "YMSeekingConsultationDoctorInofTableViewCell.h"
#import "YMOrderFuaFulfillTableViewCell.h"
#import "YMContractViewController.h"
#import "YMOrderSectionView.h"
#import "YMOrderContentView.h"
#import "YMOrderCommentViewController.h"
#import "TalkingViewController.h"
#import "YMOrderDetailsViewController.h"
#import "YMDemandBidSelectionModel.h"

#import "YMDoctorHomePageViewController.h"

//分享
#import "SDNewShareView.h"
#import <UMSocialCore/UMSocialCore.h>

static NSString *const doctorAskedCell = @"doctorAskedCell";

static NSString *const seekingConsultationDoctorInofCell = @"seekingConsultationDoctorInofCell";

static NSString *const orderFuaFulfillTableCell = @"orderFuaFulfillTableCell";

@interface YMSeekingConsultationViewController ()<YMOrderInforViewDelegate,YMBottomViewDelegate,UITableViewDelegate,UITableViewDataSource,YMOrderFuaFulfillTableViewCellDelegate,YMDoctorAskedTableViewCellDelegate,YMSeekingConsultationDoctorInofTableViewCellDelegate,YMOrderContentViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)YMOrderInforView *orderInfoView;

@property(nonatomic,strong)YMBottomView *bottomView;

@property(nonatomic,strong)UITableView *seekingConsultationTableView;

@property(nonatomic,strong)NSArray *titleContent;

@property(nonatomic,strong)YMDoctorOrderProcessModel *model;

@property(nonatomic,strong)NSArray *headerDataArry;

@property(nonatomic,strong)UIView *commentView;

@property(nonatomic,strong)YMOrderContentView *orderContentView;

@property(nonatomic,strong)YMDemandBidSelectionModel *bidSectionmodel;

@end

@implementation YMSeekingConsultationViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initVar];
    [self initView];
    [self initShareView];
    [self requrtData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initVar{
    _headerDataArry = @[@{@"titleNumber":@"01",
                          @"title":@"选标阶段",
                          @"subTitle":@"已选标"},
                        @{@"titleNumber":@"02",
                          @"title": [_demand_type integerValue] == 1?@"医生嘱述:": @"工作完成，确认付款",
                          @"subTitle":@""},
                        @{@"titleNumber":@"03",
                          @"title":@"完成工作，双方评价",
                          @"subTitle":@""}];
}
-(void)initView{
    [self initBottomView];
    [self initOrderInfoView];
    [self initTableView];
    
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
             [weakSelf  refreshData];
         }
         //显示隐藏分享按钮
         NSString *shareStr = weakSelf.model.mingyi_status;
         if ([shareStr integerValue] == 4) {
             //显示右边导航栏按钮
              [[self.navigationController.navigationBar.subviews objectAtIndex:1] setHidden:NO];
         }else{
             //隐藏右边导航栏按钮
             [[self.navigationController.navigationBar.subviews objectAtIndex:1] setHidden:YES];

         }
         
     }];
}
//创建分享按钮
-(void)initShareView{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(selectdShareBtnAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


-(void)refreshData{
    switch ([_model.demand_type intValue]) {
        case 1:
            self.title = @"询医问诊";
            break;
        case 2:
            self.title = @"市内坐诊";
            break;
        case 3:
            self.title = @"活动讲座";
            break;
        default:
            break;
    }
    _bidSectionmodel = [[YMDemandBidSelectionModel alloc]init];
    _bidSectionmodel.demand_id = _model.demand_id;
    _bidSectionmodel.demand_sn = _model.order_sn;
    _bidSectionmodel.money = _model.money;
    _bidSectionmodel.title = _model.title;
    _bidSectionmodel.demand_time = _model.demand_time;
    _orderInfoView.model = _bidSectionmodel;

    [_seekingConsultationTableView reloadData];
}

-(void)initBottomView{
    _bottomView = [[YMBottomView alloc]init];
    _bottomView.type = MYBottomBlueType;
    _bottomView.bottomTitle = @"联系医生";
    _bottomView.bottomImageName = @"speech-bubble_blue";
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
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

-(void)initTableView{
    _seekingConsultationTableView = [[UITableView alloc]init];
    _seekingConsultationTableView.backgroundColor = [UIColor clearColor];
    _seekingConsultationTableView.delegate = self;
    _seekingConsultationTableView.dataSource = self;
    _seekingConsultationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_seekingConsultationTableView registerClass:[YMDoctorAskedTableViewCell class] forCellReuseIdentifier:doctorAskedCell];
    [_seekingConsultationTableView registerClass:[YMSeekingConsultationDoctorInofTableViewCell class] forCellReuseIdentifier:seekingConsultationDoctorInofCell];
    
    [_seekingConsultationTableView registerClass:[YMOrderFuaFulfillTableViewCell class] forCellReuseIdentifier:orderFuaFulfillTableCell];
    [self.view addSubview:_seekingConsultationTableView];
    [_seekingConsultationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_orderInfoView.mas_bottom);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}


#pragma mark - 

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([_model.mingyi_status integerValue] < 2) {
        return 1;
    }else if ([_model.mingyi_status integerValue] >=4) {
        return 3;
    }else{
       return 2;
    }
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            
            return [YMSeekingConsultationDoctorInofTableViewCell heightForTips:_model.tips];

        }
            break;
        case 1:{
            if ([_demand_type integerValue] != 1) {
                return 44;
            }
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    YMOrderSectionView *sectionView = [[YMOrderSectionView alloc]init];
    sectionView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:sectionView];
    NSDictionary *headerDic = _headerDataArry[section];
    sectionView.type = HeaderTopllTye;
    sectionView.titleLeftStr = headerDic[@"title"];
    sectionView.titleNumberStr =headerDic[@"titleNumber"];
    sectionView.titleRightStr = headerDic[@"subTitle"];
    
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(headerView);
        make.top.equalTo(headerView.mas_top).offset(10);
    }];
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            YMSeekingConsultationDoctorInofTableViewCell *cell = [[YMSeekingConsultationDoctorInofTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:seekingConsultationDoctorInofCell];
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
            cell.model =_model;
            cell.delegate = self;
            return cell;
        }
            break;
        case 2:{
            YMOrderFuaFulfillTableViewCell *cell = [[YMOrderFuaFulfillTableViewCell alloc]init];
            cell.delegate = self;
            cell.model =_model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
        vc.doctorID = _model.doctor_store_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - YMBottomViewDelegate
-(void)bottomView:(YMBottomView *)bottomClick{
    NSLog(@"联系医生");
    TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:_model.huanxinid];
    vc.title = _model.member_names;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - YMOrderInforViewDelegate

-(void)orderInfoView:(YMOrderInforView *)orderView orderDetails:(UIButton *)sender{
    NSLog(@"查看详情");
    YMOrderDetailsViewController *vc = [[YMOrderDetailsViewController alloc]init];
    vc.demand_id = _model.demand_id;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - YMSeekingConsultationDoctorInofTableViewCellDelegate
-(void)SeekingConsultationDoctorView:(YMSeekingConsultationDoctorInofTableViewCell *)cell lookHetong:(UIButton *)sender{
    YMContractViewController *vc = [[YMContractViewController alloc]init];
    vc.order_id = _order_id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - YMDoctorAskedTableViewCellDelegate
//付款
-(void)doctorAskedViewCell:(YMDoctorAskedTableViewCell *)doctorAskedViewCell aplayButton:(UIButton *)aplayButton{
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=surePay"
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
//仲裁
-(void)doctorAskedViewCell:(YMDoctorAskedTableViewCell *)doctorAskedViewCell arbitration:(UIButton *)arbitration{
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=arbitrate"
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
   

    NSMutableDictionary *dic =  [commentDic mutableCopy];
    [dic setObject:[NSString isEmpty:_order_id ]?@"":_order_id forKey:@"order_id"];
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
         [altkf show];
     }];
}

-(void)orderContentView:(YMOrderContentView *)view changeButton:(UIButton *)sender{
    [self requrtPingTags];
}

-(void)orderContentView:(YMOrderContentView *)view closeButton:(UIButton *)sender{
    [self hiddenBalance:nil];
}

#pragma mark - UIAlertViewDelegate

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        YMOrderCommentViewController *vc = [[YMOrderCommentViewController alloc]init];
        vc.order_id = _model.order_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享鸣医订单" descr:concent thumImage:[UIImage imageNamed:@"share_iconImg"]];
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
