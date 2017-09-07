//
//  YMUserCenterTableViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMUserCenterTableViewController.h"
#import "YMUserInfoTableViewController.h"
#import "YMMyMoneyViewController.h"
#import "YMUserCenterHeadTableViewCell.h"
#import "YMGuahaoInfoViewController.h"
#import "YMInfoBaseTableViewController.h"
#import "DemandOrderViewController.h"
#import "SetViewController.h"
#import <UShareUI/UMSocialUIManager.h>
#import "SystemMessageViewController.h"
#import "NSObject+YMUserInfo.h"

#import "YMSelfHomeTableViewCell.h"
#import "YMMyAccountViewController.h"
#import "YMHelpCenterViewController.h"
#import "ShareView.h"
#import "YMMyAttentionViewController.h"
#import "SDHosporViewController.h"


#import "YMMyHeaderTableViewCell.h"

#import "YMUserInforModel.h"
#import "YMOrderViewController.h"
#import "HealthyHelperViewController.h"
#import "SDMinePrivateDoctorViewController.h"
static NSString *const selfHomeViewCell = @"selfHomeViewCell";

static NSString *const myHeaderCell = @"myHeaderCell";

static NSString *const saveUsrInfo = @"saveUsrInfo";

@interface YMUserCenterTableViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,YMMyHeaderTableViewCellDelegate>
@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) UIImage *currenLine;

@property (nonatomic, strong) YMUserInforModel *model;

@property (strong, nonatomic) IBOutlet UITableView *userInforTableView;

@property(nonatomic,strong)NSArray *tableData;

@end

@implementation YMUserCenterTableViewController
{
    int freshTag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *foot = [UIView new];
    foot.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    self.tableView.tableFooterView = foot;
    freshTag = 1;
    
    //隐藏导航栏
    self.navigationController.delegate = self;
    
    [_userInforTableView registerClass:[YMMyHeaderTableViewCell class] forCellReuseIdentifier:myHeaderCell];
    
    [self initData];
    
    //设置状态栏颜色
   self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
  
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    self.tabBarController.tabBar.hidden = NO;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{

   return UIStatusBarStyleLightContent;

}
-(void)initData{
    _tableData = @[@[@{@"headerImageName":@"homePage_minePrivate",
                       @"titleName":@"我的私人医生"},
                    @{@"headerImageName":@"homePage_healthyAssistant",
                      @"titleName":@"健康助手"}],
                   @[@{@"headerImageName":@"my_attention_icon",
                       @"titleName":@"我的关注"},
                     @{@"headerImageName":@"my_offer_icon",
                       @"titleName":@"我的优惠券"}],
                   @[@{@"headerImageName":@"my_share_icon",
                       @"titleName":@"推荐给朋友"},
                     @{@"headerImageName":@"my_help_icon",
                       @"titleName":@"帮助中心"}]];
}

- (void)systemBtnClick {
    //系统消息
    SystemMessageViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"showSystemMessageIdentifier"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData {
    UIView *temp;
    if (freshTag == 1) {
        temp = self.view;
    } else {
        temp = nil;
    }
    
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_page&op=index" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:temp complateHandle:^(id showdata, NSString *error) {
        //NSLog(@"showdata------%@",showdata);
        if (showdata == nil) {
            return ;
        }
        NSMutableDictionary *mut = [[weakSelf readDic] mutableCopy];
        mut[@"userInfo"] = [[weakSelf deleteNull:showdata] mutableCopy];
        [weakSelf whriteToFielWith:[mut copy]];
        [[YMUserInfo sharedYMUserInfo] setValuesForKeysWithDictionary:showdata];
        
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:showdata];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:saveUsrInfo];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary *modelDic = [[NSMutableDictionary alloc]initWithDictionary:showdata];
            NSString *registerNumber = [modelDic valueForKey:@"register"];
            
            [modelDic setObject:[NSString isEmpty:registerNumber]?@"":registerNumber forKey:@"registerNumber"];
            weakSelf.model = [YMUserInforModel modelWithJSON:showdata];
        }
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
//    [self.navigationController.navigationBar setBackgroundImage:self.currentImage forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tableData.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    NSArray *subData =_tableData[section-1];
    return subData.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 280;
    } else {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        YMMyHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myHeaderCell forIndexPath:indexPath];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        cell.delegate = self;
        return cell;

    } else {
        
        YMSelfHomeTableViewCell *cell = [[YMSelfHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selfHomeViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageName =[ _tableData[indexPath.section-1][indexPath.row] valueForKey:@"headerImageName"];
        cell.titleName =[ _tableData[indexPath.section-1][indexPath.row] valueForKey:@"titleName"];
        NSArray *subData =_tableData[indexPath.section-1];

        if (indexPath.row == subData.count-1) {
            cell.lastOne =YES;
        }
        
        if (indexPath.row !=0) {
            cell.lineInterval = YES;
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                NSLog(@"我的私人医生");
                
                //判断跳宣传页
                if ([self.model.report_type isEqualToString:@"1"]) {
                    SDMinePrivateDoctorViewController *privateDoctVC = [[SDMinePrivateDoctorViewController alloc]init];
                    [self.navigationController pushViewController:privateDoctVC animated:YES];
                }else{
                    SDHosporViewController *sdHosporVC = [[SDHosporViewController alloc]init];
                    sdHosporVC.title = @"私人医生";
                    sdHosporVC.url = @"http://weixin.ys9958.com/index.php/api/Promote/index";
                    [self.navigationController pushViewController:sdHosporVC animated:YES];
                }
                
            }
                break;
            case 1:{
                NSLog(@"健康助手");
//                YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
//                    [self.navigationController pushViewController:vc animated:YES];
                //添加健康档案
               // [self requestHealtyData];
                
                self.hidesBottomBarWhenPushed = YES;
                HealthyHelperViewController *healthyHelperVC = [[HealthyHelperViewController alloc]init];
                [self.navigationController pushViewController:healthyHelperVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;

            }
               
            default:
                break;
        }
    }else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:{
                NSLog(@"我的关注");
                YMMyAttentionViewController *vc = [[YMMyAttentionViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES
                 ];
            }
                break;
            case 1:{
                NSLog(@"我的优惠券");
                 [self.view showErrorWithTitle:@"该功能正在建设中！" autoCloseTime:2];
            }
            default:
                break;
        }
    }else if(indexPath.section == 3){
        switch (indexPath.row) {
            case 0:{
                [self shareBoardBySelfDefined];
            }
                break;
            case 1:{
                NSLog(@"帮助中心");
                YMHelpCenterViewController *vc = [[YMHelpCenterViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            default:
                break;
        }
    }

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

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = @"分享下载";
    
    
    //创建图片内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"鸣医通分享" descr:@"用鸣医通,轻松解决挂专家号难的烦恼,我在用,你不要犹豫哦! " thumImage:[UIImage imageNamed:@"share_iconImg"]];
//    NSString *url;
//    url = @"http://ys9958.com/shop/index.php?act=invite&op=reg";
//    shareObject.webpageUrl = [url stringByAppendingFormat:@"&inviter_id=%@&type=1",[YMUserInfo sharedYMUserInfo].member_id];
    
     shareObject.webpageUrl = @"http://weixin.ys9958.com/index.php/Wap/Invite/InviteUser";
    
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
-(void)createAlertVC
{
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:nil message:@"该功能正在建设中" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //UIImage *newImage = [self thumbnaiWithImage:image size:CGSizeMake(170, 110)];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.1);
    
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool upLoadData:@"act=doctor_page&op=avatar" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} andData:@[@{@"name":@"member_avatar",@"data":data}] waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self showRightWithTitle:@"上传成功" autoCloseTime:2];
        
        [self performSelector:@selector(loadData) withObject:nil afterDelay:2];
        //[self loadData];
    }];
    
    //[self.imageArray addObject:@{self.upOrDown:data}];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark - YMMyHeaderTableViewCellDelegate

//设置点击
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell setUp:(UIButton *)sender{
    SetViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"settingView"];
    [self.navigationController pushViewController:vc animated:YES];
}
//消息
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell message:(UIButton *)sender{
    SystemMessageViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"showSystemMessageIdentifier"];
    [self.navigationController pushViewController:vc animated:YES];
}
//头像
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell upDataHeaderImage:(UIButton *)sender{

    YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//鸣医
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell myMingyYi:(UIButton *)sender{
    //需求订单
//    DemandOrderViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"demandOrderIdentifeir"];
//    vc.type = 1;
     YMOrderViewController *vc = [[YMOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//服务
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell purchaseServer:(UIButton *)sender{
    
    
}
//报告
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell presentation:(UIButton *)sender{

    
}
//挂号信息
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell registerInfor:(UIButton *)sender{
    YMGuahaoInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"guahaoView"];
    [self.navigationController pushViewController:vc animated:YES];
}
//顶部背景
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell backGroup:(UIButton *)sender{
    YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//进入我的账户
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell myAccount:(UIButton *)sender
{
    YMMyAccountViewController *vc = [[YMMyAccountViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
//进入编辑
-(void)headerCell:(YMMyHeaderTableViewCell *)headerCell upEdit:(UIButton *) sender
{
    YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}






@end
