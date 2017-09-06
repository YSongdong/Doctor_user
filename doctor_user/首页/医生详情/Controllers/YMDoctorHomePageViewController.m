//
//  YMDoctorHomePageViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorHomePageViewController.h"
#import "UIButton+LZCategory.h"
#import "YMDoctorCaseTableViewCell.h"
#import "YMDoctorHomePageHeaderTableViewCell.h"
#import "YMGuyongDoctorViewController.h"
#import "YMDoctorDetailsModel.h"

#import "YMDoctorDetailsCaseModel.h"
#import "YMDoctorDetailsHonorModel.h"
#import "YMDoctorDetailsEvaluationModel.h"
#import "YMCaseDetailsViewController.h"

//融云
#import "TalkingViewController.h"


#import "YMDoctorFooterCollectionReusableView.h"

#import "YMNewReservationDoctorViewController.h"
#import <UShareUI/UMSocialUIManager.h>
#import "ShareView.h"
static NSString *const CaseTableViewCell = @"CaseTableViewCell";
static NSString *const HomePageHeaderTableViewCell = @"HomePageHeaderTableViewCell";

@interface YMDoctorHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,YMDoctorHomePageHeaderTableViewCellDelegate,YMDoctorCaseTableViewCellDelegate>

@property(nonatomic,strong)UITableView *doctorHomePageTableView;

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,strong)UIView *doctorHeaderView;

@property(nonatomic,assign)BOOL detailsClick;// 点击：Yes 没点击：NO

@property(nonatomic,strong)YMDoctorDetailsModel *model;

@property(nonatomic,strong)NSMutableArray *interactionData;

@property(nonatomic,strong)UIButton *attentionButton;


@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsCaseModel *> *doctorCaseArry;
@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsHonorModel *> *doctorHonorArry;
@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsEvaluationModel *> *doctorEvaluationArry;

@property(nonatomic,assign)CaseNumber ClickCaseNumber;

@property(nonatomic,assign)NSInteger type;


@property(nonatomic,strong)UIView *reusableView;

@end

@implementation YMDoctorHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医生主页";
    [self leftNavigationBar];
   // [self initRightNaviBtn];
    [self createView];
    [self initVar];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;

}
//viewcontroller 即将消失
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
   

}
-(void)setIsRootVC:(BOOL)isRootVC{

    _isRootVC = isRootVC;

}
- (void)leftButtonOperator {
    if (self.isRootVC) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)createView{
    
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [self createBottomView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_reusableView.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    _doctorHomePageTableView = [[UITableView alloc]init];
    
    _doctorHomePageTableView.delegate = self;
    _doctorHomePageTableView.dataSource = self;
    [_doctorHomePageTableView registerClass:[YMDoctorCaseTableViewCell class] forCellReuseIdentifier:CaseTableViewCell];
    [_doctorHomePageTableView registerClass:[YMDoctorHomePageHeaderTableViewCell class] forCellReuseIdentifier:HomePageHeaderTableViewCell];
     _doctorHomePageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_doctorHomePageTableView];
    [_doctorHomePageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(lineView.mas_top);
    }];
}
-(void) initRightNaviBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn  setImage:[UIImage imageNamed:@"my_share_icon"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 40, 44);
    [rightBtn addTarget:self action:@selector(onShareAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =rightItem;
}

-(void)createBottomView{
    //背景view
    UIView  *grounbView = [[UIView alloc]init];
    grounbView.layer.borderWidth = 1;
    grounbView.layer.borderColor = [UIColor btnBlueColor].CGColor;
    [_bottomView addSubview:grounbView];
    [grounbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView.mas_top).offset(5);
        make.left.equalTo(_bottomView.mas_left).offset(10);
        make.bottom.equalTo(_bottomView.mas_bottom).offset(-5);
        make.right.equalTo(_bottomView.mas_right).offset(-10);
    }];
    grounbView.layer.masksToBounds = YES;
    grounbView.layer.cornerRadius = 18;
  
    _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentionButton setTitle:@" 免费问诊" forState:UIControlStateNormal];
    _attentionButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_attentionButton setImage:[UIImage imageNamed:@"doctor_btn_message"] forState:UIControlStateNormal];
    [_attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_attentionButton setTitleColor:RGBCOLOR(64, 133, 201) forState:UIControlStateNormal];
    [grounbView addSubview:_attentionButton];
    
    [_attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(grounbView);
       // make.width.equalTo(@180);
    }];


    UIButton *reservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reservationButton.backgroundColor = RGBCOLOR(80, 168, 252);
    
    [reservationButton setTitle:@" 预约医生" forState:UIControlStateNormal];
    [reservationButton setImage:[UIImage imageNamed:@"reservationDoctor"] forState:UIControlStateNormal];
    reservationButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [reservationButton addTarget:self action:@selector(reservationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [grounbView addSubview:reservationButton];
 
    [reservationButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(grounbView.mas_top);
//        make.right.bottom.equalTo(grounbView);
//        make.left.equalTo(_attentionButton.mas_right);
        make.left.equalTo(_attentionButton.mas_right);
        make.right.equalTo(grounbView.mas_right);
        make.centerY.equalTo(_attentionButton.mas_centerY);
        make.width.equalTo(_attentionButton.mas_width);
        make.height.equalTo(_attentionButton.mas_height);
    }];
    
    _reusableView =[[UIView alloc]init];
    [self.view addSubview:_reusableView];
    [_reusableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
        make.height.equalTo(@0);
    }];
    
}

-(void)initVar{
    _doctorCaseArry = [NSMutableArray array];
    _doctorHonorArry = [NSMutableArray array];
    _doctorEvaluationArry = [NSMutableArray array];
    _ClickCaseNumber = CaseCaseNumber;
    
}

//请求医生信息
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=doctor&op=doctorInfo" params:@{@"store_id":self.doctorID,@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            
            NSMutableDictionary *addBaseUrlDic = [[NSMutableDictionary alloc]init];
            [addBaseUrlDic addEntriesFromDictionary:showdata];
            weakSelf.model = [YMDoctorDetailsModel modelWithJSON:addBaseUrlDic];
            [weakSelf requrtCase];
            
            [weakSelf refreshView];
        }
        
    }];
   
}
//关注
-(void)attentionRequrt{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_page&op=follow" params:@{@"friend_frommid":[YMUserInfo sharedYMUserInfo].member_id,@"friend_tomid":_model.member_id,@"type":@(_type)} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if ([_model.is_follow integerValue]==1) {
            
            weakSelf.model.is_follow = @"0";
            YMDoctorHomePageHeaderTableViewCell *cell = [self.doctorHomePageTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.isFollowDoctor = NO;
            NSString *follow_num = [NSString stringWithFormat:@"%ld",[self.model.follow_num integerValue]-1];
            self.model.follow_num =follow_num;
        }else{
            weakSelf.model.is_follow = @"1";
            YMDoctorHomePageHeaderTableViewCell *cell = [self.doctorHomePageTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.isFollowDoctor = YES;
            NSString *follow_num = [NSString stringWithFormat:@"%ld",[self.model.follow_num integerValue]+1];
            self.model.follow_num =follow_num;
        }
        
        if ([self.delegate respondsToSelector:@selector(setIsFollowNSString:andIndexPath:)]) {
            [self.delegate setIsFollowNSString:self.model.is_follow andIndexPath:self.indexPath];
        }
        [weakSelf refreshView];
    }];
   

}


-(void)refreshView{
    [_reusableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20*_model.doctor_time.count);
    }];
    NSInteger i = 0;
    for (YMDoctorTimeModel *model in _model.doctorTimeArry) {
        YMDoctorFooterCollectionReusableView *view = [[YMDoctorFooterCollectionReusableView alloc]init];
        view.model = model;
        [_reusableView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20*i);
            make.height.mas_equalTo(20);
            make.left.right.equalTo(_reusableView);
        }];
        i++;
    }
    [_doctorHomePageTableView reloadData];
}

#pragma makr     ---按钮点击事件buttonClick------
//免费问诊
-(void)attentionButtonClick:(UIButton *)sender{
    if ([_model.is_follow integerValue]==1) {
        TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:_model.huanxinpew];
        vc.title = _model.member_names;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        _type = 1;
        UIAlertController *VC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"免费问诊必须先关注医生" preferredStyle:UIAlertControllerStyleAlert];
        
        [VC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [VC addAction:[UIAlertAction actionWithTitle:@"关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //请求关注
            [self attentionRequrt];
            
        }]];
        
        [self presentViewController:VC animated:YES completion:nil];
    }
    
}
//预约医生
-(void)reservationButtonClick:(UIButton *)sender{
    NSLog(@"预约");

    YMNewReservationDoctorViewController *vc
    = [[YMNewReservationDoctorViewController alloc]init];
    vc.member_id = _model.member_id;
    vc.member_aptitude_money= self.model.member_aptitude_money;
    [self.navigationController pushViewController:vc animated:YES];
}
//分享按钮
-(void)onShareAction:(UIButton *) sender
{
    [self shareBoardBySelfDefined];

}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 0;
    }
    return 10;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =RGBCOLOR(234, 234, 234);
    return headerview ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat cellheight = 174.f;
        
        if (_detailsClick) {
            cellheight+= [YMDoctorHomePageHeaderTableViewCell DetailsViewHeight:_model.member_service detailsClick:_detailsClick]+18;
            
            cellheight +=[YMDoctorHomePageHeaderTableViewCell memberPersonalInfoHeight:_model.member_Personal]+18;
            
        }else{
            cellheight+= [YMDoctorHomePageHeaderTableViewCell DetailsViewHeight:_model.member_service detailsClick:_detailsClick]+20;
        }
        return cellheight +[YMDoctorHomePageHeaderTableViewCell goodAtHeight:_model.specialty_tags];
    }else{
        switch (_ClickCaseNumber) {
            case CaseTreatmentNumber:{
                NSLog(@"");
                return 0;
            }
                break;
            case CaseCaseNumber:{
                return [YMDoctorCaseTableViewCell cellCaseHeight:_doctorCaseArry];
            }
                break;
            case CaseHonorNumber:{
                NSLog(@"");
                return [YMDoctorCaseTableViewCell cellHonorHeight:_doctorHonorArry];
            }
                break;
            case CaseServerNumber:{
                NSLog(@"");
                return [YMDoctorCaseTableViewCell cellEvaluationHeight:_doctorEvaluationArry];
            }
                break;
            default:
                return 0;
                break;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        YMDoctorHomePageHeaderTableViewCell *cell = [[YMDoctorHomePageHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomePageHeaderTableViewCell];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clcickEvent = _detailsClick;
        cell.model = _model;
        
        return cell;
    }else{
        YMDoctorCaseTableViewCell *cell = [[YMDoctorCaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CaseTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.doctorCaseArry = _doctorCaseArry;
        cell.doctorHonorArry = _doctorHonorArry;
        cell.doctorEvaluationArry = _doctorEvaluationArry;
        cell.selectCaseNumber = _ClickCaseNumber;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark YMDoctorHomePageHeaderTableViewCellDelegate

-(void)HeaderTableViewCell:(YMDoctorHomePageHeaderTableViewCell *)headerTableViewCell sender:(UIButton *)sender{
    _detailsClick = !_detailsClick;
    [_doctorHomePageTableView reloadData];
}
//关注医生
-(void)selectdFollowDoctorBtnClick
{
    if ([_model.is_follow integerValue]==1) {
        _type = 2;
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"关注" message:@"是否取消对当前医生对关注" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //关注请求
            [self attentionRequrt];
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        _type = 1;
        [self attentionRequrt];
    }
}
#pragma mark - YMDoctorCaseTableViewCellDelegate
-(void)DoctorCaseViewCell:(YMDoctorCaseTableViewCell *)DoctorCaseViewCell clickTopNumber:(CaseNumber )caseNumber{
    
    _ClickCaseNumber = caseNumber;
    

    switch (caseNumber) {
        case CaseTreatmentNumber:{
            NSLog(@"");
           
        }
            break;
        case CaseCaseNumber:{
            NSLog(@"");
            if (_doctorCaseArry.count>0) {
                [_doctorHomePageTableView reloadData];
            }else{
                [self requrtCase];
            }
        }
            break;
        case CaseHonorNumber:{
            if (_doctorHonorArry.count>0) {
                [_doctorHomePageTableView reloadData];
            }else{
                [self requrtHonor:1];
            }
            
        }
            break;
        case CaseServerNumber:{
            if (_doctorEvaluationArry.count>0) {
                [_doctorHomePageTableView reloadData];
            }else{
                [self requrtEvaluation:1];
            }
            
        }
            break;
        default:
            break;
    }
}
//案例中心
-(void)requrtCase{
    NSDictionary* params = @{@"doctor_member_id":_model.member_id?:@0,
                @"member_id":[YMUserInfo sharedYMUserInfo].member_id ?:@0,
                @"is_admin":@0};
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=case&op=index"
                                                 params:params
                                              withModel:nil
                                               waitView:self.view
                                         complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSMutableArray class]] || [showdata isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in showdata) {
                [weakSelf.doctorCaseArry addObject:[YMDoctorDetailsCaseModel modelWithJSON:dic]];
            }
            
        }
     [weakSelf.doctorHomePageTableView reloadData];
        
    }];
}
//荣誉中心
-(void)requrtHonor:(NSInteger)page{
    __weak typeof(self) weakSelf = self;
    NSDictionary* params = @{@"member_id":_model.member_id?:@0,
                             @"curpage":@(page)?:@0,
                             @"is_admin":@0};
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=honor&op=getHonorList"
                                                 params:params
                                              withModel:nil
                                               waitView:self.view
                                         complateHandle:^(id showdata, NSString *error) {
                                             if (showdata == nil) {
                                                 return ;
                                             }
                                             
                                             if ([showdata isKindOfClass:[NSMutableArray class]] || [showdata isKindOfClass:[NSArray class]]) {
                                                 for (NSDictionary *dic in showdata) {
                                                     [weakSelf.doctorHonorArry addObject:[YMDoctorDetailsHonorModel modelWithJSON:dic]];
                                                 }
                                             }
                                             [weakSelf.doctorHomePageTableView reloadData];
                                             
                                         }];
}
//服务评价
-(void)requrtEvaluation:(NSInteger)page{
    NSDictionary* params = @{@"store_id":_model.store_id,
                             @"curpage":@(page)?:@1};
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=doctor&op=getDoctorComments"
                                                 params:params
                                              withModel:nil
                                               waitView:self.view
                                         complateHandle:^(id showdata, NSString *error) {
                                             if (showdata == nil) {
                                                 return ;
                                             }                                     
                                             if ([showdata isKindOfClass:[NSMutableArray class]] || [showdata isKindOfClass:[NSArray class]]) {
                                                 for (NSDictionary *dic in showdata) {
                                                     [weakSelf.doctorEvaluationArry addObject:[YMDoctorDetailsEvaluationModel modelWithJSON:dic]];
                                                 }
                                                 
                                             }
                                             [weakSelf.doctorHomePageTableView reloadData];
                                         }];
}


-(void)DoctorCaseViewCell:(YMDoctorCaseTableViewCell *)doctorCaseViewCell caseModel:(YMDoctorDetailsCaseModel *)caseModel{
    YMCaseDetailsViewController *vc = [[YMCaseDetailsViewController alloc]init];
    vc.case_id =caseModel.case_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//分享
- (void)shareBoardBySelfDefined {
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    
    
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    
    NSMutableArray *titlearr = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:5];
    
    int startIndex = 0;
    
    if (hadInstalledQQ) {
        [titlearr addObjectsFromArray:@[@"QQ好友",]];
        [imageArr addObjectsFromArray:@[@"icon_qq_friend"]];
    } else {
        startIndex += 1;
    }
    if (hadInstalledWeixin) {
        [titlearr addObjectsFromArray:@[@"微信好友",@"微信朋友圈"]];
        [imageArr addObjectsFromArray:@[@"icon_wx_friend",@"icon_wx_circle"]];
    } else {
        startIndex += 2;
    }
    
    
    [titlearr addObjectsFromArray:@[@"新浪微博"]];
    [imageArr addObjectsFromArray:@[@"icon_sina_wb"]];
    
    __weak typeof(self) weakSelf = self;
    
    
    NSString *shareContent = [NSString stringWithFormat:@"http://ys9958.com/shop/index.php?act=invite&op=reg&inviter_id=%@&type=1",[YMUserInfo sharedYMUserInfo].member_id];
    
    ShareView *shareView = [[ShareView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr createQRcode:YES headerImageUrl:_model.member_avatar shareContent:shareContent];
    
    [shareView setBtnClick:^(NSInteger btnTag) {
        NSLog(@"\n点击第几个====%d\n当前选中的按钮title====%@",(int)btnTag,titlearr[btnTag]);
        switch (btnTag + startIndex) {
            case 0: {
                // QQ
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_QQ];
            }
                break;
            case 1: {
                // 微信
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatSession];
            }
                break;
            case 2: {
                // 微信朋友圈
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            }
                break;
            case 3: {
                // 微博
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_Sina];
            }
                
                break;
            default:
                break;
        }
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    
    //    //创建分享消息对象
    //    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //    messageObject.title = @"分享下载";
    //    //创建图片内容对象
    //    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"鸣医通分享" descr:@"我正在使用鸣医通，看病找专家，预约不排队，快来试试吧！" thumImage:[UIImage imageNamed:@"LOGOS"]];
    //    NSString *url;
    //    url = @"http://ys9958.com/shop/index.php?act=invite&op=reg";
    //    shareObject.webpageUrl = [url stringByAppendingFormat:@"&inviter_id=%@&type=1",[YMUserInfo sharedYMUserInfo].member_id];
    //    //分享消息对象设置分享内容对象
    //    messageObject.shareObject = shareObject;
    //    //调用分享接口
    //    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
    //        if (error) {
    //            NSLog(@"************Share fail with error %@*********",error);
    //        }else{
    //            NSLog(@"response data is %@",data);
    //        }
    //    }];
    [self createAlertVC];
}
-(void)createAlertVC
{
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:nil message:@"该功能正在建设中" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}





@end
