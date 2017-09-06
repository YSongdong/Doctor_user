//
//  MessageViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"


#import <RongIMLib/RongIMLib.h>
#import "SystemMessageViewController.h"
#import "TalkingViewController.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,RCIMConnectionStatusDelegate>
@property (nonatomic,strong)NSMutableDictionary *sysTemMessage ;

@property (nonatomic,strong)NSMutableArray *dataList ;

@property (nonatomic,assign)BOOL isloadSucess;



@end
static NSString *MessageTableViewCellIdentifier = @"message";
@implementation MessageViewController

{
    NSInteger buageCount ;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
   // self.title = @"通讯消息";
    self.displayConversationTypeArray = @[@(ConversationType_PRIVATE),@(ConversationType_SYSTEM)];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"background"];
    [imageView sizeToFit];
    imageView.center = self.view.center ;
    self.emptyConversationView = imageView ;
    self.conversationListTableView.backgroundColor = [UIColor light_GrayColor];
    
    //设置状态栏颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO ;
    [self refreshConversationTableViewIfNeeded];
    [self setbuadgeValue];
}

- (void)notifyUpdateUnreadMessageCount {
    
    [super notifyUpdateUnreadMessageCount] ;
    [self setbuadgeValue];
}
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [super didReceiveMessageNotification:notification];
    [self notifyUpdateUnreadMessageCount];
}
- (void)setbuadgeValue {
    
    int count =  [[RCIMClient sharedRCIMClient]getTotalUnreadCount];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (count > 0) {
            [self.tabBarController.tabBar.items[1]
             setBadgeValue:[NSString stringWithFormat:@"%d",count]];
        }
        else {
            [self.tabBarController.tabBar.items[1] setBadgeValue:nil];
        }
    });
    
}


-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {
    return dataSource ;
}

- (void)setup{
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.001f)];
    footView.backgroundColor = [UIColor whiteColor];
    self.conversationListTableView.tableFooterView = footView ;
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage new];
    [imageView sizeToFit];
    imageView.center = self.view.center ;
    self.emptyConversationView = imageView ;
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    
           RCUserInfo *userInfo = [[RCIM sharedRCIM]getUserInfoCache:model.targetId];
        TalkingViewController *vc  = [[TalkingViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.targetId];
        vc.title = userInfo.name ;
        self.tabBarController.tabBar.hidden = YES ;
        [self.navigationController pushViewController:vc animated:YES];
       buageCount = 0 ;
     [self.tabBarItem setBadgeValue:@""];
}
@end
