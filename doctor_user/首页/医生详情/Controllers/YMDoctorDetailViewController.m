//
//  YMDoctorDetailViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorDetailViewController.h"
#import "YMDoctorDetailBaseTableViewCell.h"
#import "YMDoctorDetailIntroduceTableViewCell.h"
#import "YMGuyongDoctorViewController.h"
#import "TalkingViewController.h"
#import <UShareUI/UMSocialUIManager.h>

@interface YMDoctorDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *lianxiBtn;
@property (weak, nonatomic) IBOutlet UIButton *guyongBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lianxiBtnHghit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *guyongBtnHghit;
@property (nonatomic, strong) NSDictionary *myData;
@end

@implementation YMDoctorDetailViewController
{
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    NSMutableArray *array4;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.navigationItem.title = @"医生资料";
    
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share-拷贝-5"] style:UIBarButtonItemStyleDone  target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = myButton;
    
    array1 = [@[[@{@"name":@"姓名："} mutableCopy],[@{@"name":@"年龄："}mutableCopy],[@{@"name":@"学历："}mutableCopy]] mutableCopy];
    array2 = [@[[@{@"name":@"科室："} mutableCopy],[@{@"name":@"医师资质："}mutableCopy],[@{@"name":@"就职医院："}mutableCopy]] mutableCopy];
    array3 = [@[[@{@"name":@"医生擅长："}mutableCopy]] mutableCopy];
    array4 = [@[[@{@"name":@"医生简介："}mutableCopy]] mutableCopy];
    if (self.fromVC) {
        self.lianxiBtnHghit.constant = 0;
        self.guyongBtnHghit.constant = 0;
        self.lianxiBtn.hidden = YES;
        self.guyongBtn.hidden = YES;
    }
    [self loadData];
}

//点击事件
- (void)clickEvent {
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareImageToPlatformType:platformType];
    }] ;

}

- (void)loadData {
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_hire" params:@{@"store_id":self.doctorID} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.myData = [showdata copy];
        for (NSMutableDictionary *dic in array1) {
            if ([array1 indexOfObject:dic] == 0) {
                dic[@"detail"] = showdata[@"member_names"];
            } else if ([array1 indexOfObject:dic] == 1) {
                dic[@"detail"] = showdata[@"member_age"];
            } else {
                dic[@"detail"] = showdata[@"member_education"];
            }
        }
        for (NSMutableDictionary *dic in array2) {
            if ([array2 indexOfObject:dic] == 0) {
                dic[@"detail"] = [NSString stringWithFormat:@"%@-%@",showdata[@"member_bm"],showdata[@"member_ks"]];
            } else if ([array2 indexOfObject:dic] == 1) {
                dic[@"detail"] = showdata[@"member_aptitude"];
            } else {
                dic[@"detail"] = showdata[@"member_occupation"];
            }
        }
        NSMutableDictionary *dic = array3[0];
        dic[@"content"] = showdata[@"member_service"];
        NSMutableDictionary *dic1 = array4[0];
        dic1[@"content"] = showdata[@"member_Personal"];
        [self.tableView reloadData];
        
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (IBAction)taking:(UIButton *)sender {
    //
    TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:1 targetId:self.myData[@"huanxinid"]];
    vc.title = self.myData[@"member_names"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 1;
    } else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YMDoctorDetailBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
        [cell setDetailWithDic:array1[indexPath.row]];
        return cell;
    } else if (indexPath.section == 1) {
        YMDoctorDetailBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
        [cell setDetailWithDic:array2[indexPath.row]];
        return cell;
    } else if (indexPath.section == 2) {
        YMDoctorDetailIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"introCell"];
        [cell setDetailWithDic:array3[indexPath.row]];
        return cell;
    } else {
        YMDoctorDetailIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"introCell"];
        [cell setDetailWithDic:array4[indexPath.row]];
        return cell;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = YES;
}

- (IBAction)guyongDoctor:(id)sender {
    
    YMGuyongDoctorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"guyongView"];
    vc.doctorId = self.doctorID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = @"分享下载";
    //创建图片内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"鸣医通分享" descr:@"我正在使用鸣医通，看病找专家，预约不排队，快来试试吧！" thumImage:[UIImage imageNamed:@"LOGOS"]];
    NSString *url = @"https://www.ys9958.com/shop/index.php?act=doctor&op=index";
    shareObject.webpageUrl = [url stringByAppendingFormat:@"&id=%@",self.doctorID];
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
