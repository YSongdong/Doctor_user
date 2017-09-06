//
//  SetViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SetViewController.h"
#import "SetTableViewCell.h"
#import "ChangePassViewController.h"
#import "CasheDisk.h"
#import "JPUSHService.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,SetTableViewCellDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic,strong)NSDictionary *data ;

@property (nonatomic,strong)CasheDisk *cashe ;

@end
@implementation SetViewController
- (void)dealloc {
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"设置" ;
    self.navigationController.navigationBar.hidden = NO ;
    [self setup];
    self.cashe = [CasheDisk new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.tabBarController.tabBar.hidden = YES ;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    
}

- (void)setup{
    
    _tableView.sectionFooterHeight = 5 ;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([YMUserInfo sharedYMUserInfo].member_id) {
        [dic setObject:[YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
    }
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_page&op=set" params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            self.data = showdata ;
            [self.tableView reloadData];
        }
    }];
}

- (IBAction)loginOutOrIn:(id)sender {
   
    //退出登录
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"确认退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
        NSMutableDictionary *mut = [[self readDic] mutableCopy];
        [mut removeObjectForKey:@"login"];
        [self whriteToFielWith:mut];
        [JPUSHService setTags:nil aliasInbackground:nil];
        UIWindow *window = [UIApplication sharedApplication].keyWindow ;
        window.rootViewController = storyBoard.instantiateInitialViewController;
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
   
    [controller addAction:action];
    [controller addAction:action1];
    
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
   
}

- (void)viewWillLayoutSubviews {
    
}


- (void)switchIndicatorClickedWithStatus:(NSInteger)status
                                 andCell:(SetTableViewCell *)cell{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([YMUserInfo sharedYMUserInfo].member_id) {
        [dic setObject:[YMUserInfo sharedYMUserInfo].member_id  forKey:@"member_id"];
    }
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *url ;
    if (indexPath.section == 1 && indexPath.row == 0) {
        [dic setObject:@(status) forKey:@"sound"];
        url = @"act=users_page&op=sound";
    }else  {
        [dic setObject:@(status) forKey:@"vibrates"];
        url = @"act=doctor_page&op=vibrates";
    }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:url params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (!error) {

            NSLog(@"%@",showdata);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SetTableViewCell *cell = [SetTableViewCell setCelltableViewWithTableView:tableView andIndexPath:indexPath];
    cell.delegate = self ;
    if (indexPath.row == 1) {
        [cell drawTopLine:10 right:0];
    }
    if (indexPath.section == 0) {
         if (indexPath.row == 0) {
            cell.titleName.text = @"密码修改";
         }else{
             cell.titleName.text = @"支付密码修改";
         }
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.openSound = [self.data[@"sound"] integerValue];
            cell.titleName.text = @"消息铃声提醒";
        }
        
        if (indexPath.row == 1) {
            cell.titleName.text = @"消息震动提醒";
            cell.openSound = [self.data[@"vibrates"] integerValue];
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            cell.titleName.text = @"清除缓存";
            cell.detailLabel.text = [NSString stringWithFormat:@"%@",[self.cashe getcashSize]] ;

        }
        if (indexPath.row == 1) {
            cell.titleName.text = @"当前版本";
            cell.detailLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        }
    }
    if (indexPath.section == 3) {
        cell.titleName.text = @"拨打客服电话";
        cell.detailLabel.text = self.data[@"mobile"] ;
    }
    return cell ;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3) {
        return 1 ;
    }
        return 2 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4 ;
}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;//section头部高度
}
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =[UIColor clearColor];
    return headerview ;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ChangePassViewController *chanVC = [[ChangePassViewController alloc]init];
        if (indexPath.row == 0) {
            chanVC.type = changeLoginType;
            chanVC.title = @"修改密码";
        }else{
            chanVC.type = changePayType;
            chanVC.title =@"修改支付密码";
        }
        
        [self.navigationController pushViewController:chanVC animated:YES];
    }

    
    // qingchuhuancun
    if (indexPath.section == 2 && indexPath.row == 0) {
      SetTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [self.view showRoundProgressWithTitle:@"清除缓存中"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                    [self.cashe action];
                [self.view hideBubble];
                cell.detailLabel.text = [NSString stringWithFormat:@"缓存0.0M"];
        });
    }
    if (indexPath.section == 3) {
   [self callNumber];
    }
}

- (void)callNumber {
    if (!self.data[@"mobile"]) {
        [self.view showErrorWithTitle:@"未获取到客服号码" autoCloseTime:2];
        return ;
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:self.data[@"mobile"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.self.data[@"mobile"]]]];
    }
}





@end
