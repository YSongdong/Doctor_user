//
//  YMActivityDetailsViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMActivityDetailsViewController.h"
#import "YMActivityBottomView.h"
#import "YMActivityDetailsTableViewCell.h"
#import "YMActivitySignUpViewController.h"
#import "YMMingDoctorsActivityViewController.h"

#import "YMActivityDetailsModel.h"

#import <UShareUI/UMSocialUIManager.h>

#import "ShareView.h"
//#import "YMMiYIFirstSingleViewController.h"
#import "YMNewFirstActivityViewController.h"

static NSString *const detailsTableViewCell = @"detailsTableViewCell";

@interface YMActivityDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,YMActivityBottomViewDelegate,UIWebViewDelegate>

@property(nonatomic,strong)YMActivityBottomView *bottomView;

@property(nonatomic,strong)UITableView *activityDetailTableView;

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)YMActivityDetailsModel *model;


@end

@implementation YMActivityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    [self initView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated{
     [self requrtData];
}

-(void)initView{
    [self initNavigationRightView];
    [self createBottomView];
    [self createWebView];
}

-(void)initNavigationRightView{
    UIView *rightBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22 *2)];
    [rightBtnView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightBtnBigger.backgroundColor = [UIColor clearColor];
    rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:11];
    [rightBtnBigger setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    [rightBtnBigger addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnView addSubview:rightBtnBigger];
    [rightBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightBtnView);
    }];
    [rightBtnBigger LZSetbuttonType:LZCategoryTypeBottom];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -17;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightBarButtonItem];
    } else {
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
}

-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=activities&op=activityDetail" params:@{@"member_id":@([[YMUserInfo sharedYMUserInfo].member_id integerValue]),@"activity_id":self.activityId} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            weakSelf.model = [YMActivityDetailsModel modelWithJSON:showdata];
            [weakSelf refreshPage];
        }
        
    }];
}
-(void)refreshPage{
     [_webView loadHTMLString:_model.content baseURL:nil];
    _bottomView.bottomTitle = _model.stauts_str;
}

-(void)createWebView{
    _webView = [[UIWebView alloc]init];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

-(void)createTabelview{
    _activityDetailTableView = [[UITableView alloc]init];
    _activityDetailTableView.delegate = self;
    _activityDetailTableView.dataSource = self;
    _activityDetailTableView.backgroundColor = [UIColor clearColor];
    [_activityDetailTableView registerClass:[YMActivityDetailsTableViewCell class] forCellReuseIdentifier:detailsTableViewCell];
    _activityDetailTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_activityDetailTableView];
    [_activityDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

-(void)createBottomView{
    _bottomView = [[YMActivityBottomView alloc]init];
    _bottomView.backgroundColor = RGBCOLOR(64, 133, 201);
    _bottomView.delegate = self;
    _bottomView.bottomTitle = @"报名参加";
    _bottomView.type = BottomActivityType;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    return [YMActivityDetailsTableViewCell activityDetailHeight:_aa];
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMActivityDetailsTableViewCell *cell = [[YMActivityDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailsTableViewCell];
//    cell.present =_aa;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - YMActivityBottomViewDelegate

-(void)activityBottomView:(YMActivityBottomView *)ActivityBottomView bottomClick:(UIButton *)sender{
    
    if ([_model.is_apply integerValue] == 0 && [_model.is_first integerValue]==1) {
        
//        YMMiYIFirstSingleViewController * vc = [[YMMiYIFirstSingleViewController alloc]init];
//        vc.activity_id = _model.activity_id;
//        vc.activityTitle = _model.title;
        
        YMNewFirstActivityViewController *vc = [[YMNewFirstActivityViewController alloc]init];
        vc.activity_id = _model.activity_id;
        vc.activityTitle = _model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if ([_model.is_apply integerValue] ==1) {
            return;
        }
        switch ([_model.stauts integerValue]) {
            case 0:{
    //            _bottomView.bottomTitle = @"报名参加";
                YMActivitySignUpViewController *vc = [[YMActivitySignUpViewController alloc]init];
                vc.activityId = self.activityId;
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
            case 1:{
    //            _bottomView.bottomTitle = @"正在审核中，请耐心等待";
            }
                break;
            case 2:{
    //            _bottomView.bottomTitle = @"审核通过";
            }
                break;
            case 3:{
    //            _bottomView.bottomTitle = @"审核失败";
            }
                break;
            case 4:{
    //            _bottomView.bottomTitle = @"报名成功";
                YMMingDoctorsActivityViewController *vc = [[YMMingDoctorsActivityViewController alloc]init];
                vc.activityId = self.activityId;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
   
}

-(void)shareClick:(UIButton *)button{
    NSLog(@"分享");
    [self shareBoardBySelfDefined];
}

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
    
    
    
    ShareView *shareView = [[ShareView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr];
    
    __weak typeof(self) weakSelf = self;
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
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = @"分享下载";
    
    NSString *connetStr = self.model.title;
    //创建图片内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"鸣医通分享" descr:connetStr thumImage:[UIImage imageNamed:@"LOGOS"]];
    
//    NSString *url;
//    url = @"http://ys9958.com/shop/index.php?act=invite&op=reg";
    
    NSString *sharUrl = [NSString stringWithFormat:@"%@%@%@",BASEURL,@"act=activities&op=activityShare&activity_id=",self.activityId];
    
    shareObject.webpageUrl = sharUrl;
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
