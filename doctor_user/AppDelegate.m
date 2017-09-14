//
//  AppDelegate.m
//  doctor_user
//
//  Created by kupurui on 17/2/4.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>


#import <RongIMKit/RongIMKit.h>
#import <UserNotifications/UserNotifications.h>
#import "NSObject+YMUserInfo.h"


// 引入JPush功能所需头文件
//#import "JPUSHService.h"
//
//// iOS10注册APNs所需头文件
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <RongIMKit/RongIMKit.h>
//#import <UserNotifications/UserNotifications.h>
//#import "NSObject+YMUserInfo.h"
//#endif
//// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import <UMSocialCore/UMSocialCore.h>
#import <AVFoundation/AVFoundation.h>

#import "YMHomeViewController.h"
#import "YMLoginAndRegisterViewController.h"

#import "YMStartUpViewController.h"

#import "YMGuidePageViewController.h"

#import "KRWebViewController.h"
#import "KRAllNavigationViewController.h"
#import "YMActivityDetailsViewController.h"
#import "YMDoctorHomePageViewController.h"

#import "KRAllViewController.h"


//本地推送
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "HealthyHelperViewController.h"

static NSString *const inputadvertisingClick = @"inputadvertisingClick";

static NSString *const FirstEnterTheHomepage = @"FirstEnterTheHomepage";

static NSString *const firstInstallationVersion2=@"firstInstallationVersion2";

static NSString *const payResultFinish = @"payResultFinish";


@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate,
RCIMUserInfoDataSource,RCIMReceiveMessageDelegate,YMStartUpViewControllerDelegate,YMGuidePageViewControllerDelegate,UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate
{
    BOOL hidden;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    


    self.window = [[UIWindow alloc]init];

    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58a2632b9f06fd221e000b44"];
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxc890d8cd02612c8b" appSecret:@"cf790ea52b818a8d908c1ecb48dd61d5" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105984396"/*设置QQ平台的appID*/  appSecret:@"5VUrhSWjkG32p0p4" redirectURL:@"https://ys9958.com//api//index.php?act=users_hire&op=gvrp"];

    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2249280340"  appSecret:@"16b6f7e8cf2cb86ef9c113135d74b979" redirectURL:@"https://ys9958.com//api//index.php?act=users_hire&op=gvrp"];
    //融云
    [[RCIM sharedRCIM]initWithAppKey:@"p5tvi9dsp6ap4"];
    [RCIM sharedRCIM].receiveMessageDelegate = self ;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    [[RCIM sharedRCIM]setUserInfoDataSource:self];
    
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        // 可以添加自定义categories
//        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
//        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
//    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
////    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    [JPUSHService setupWithOption:launchOptions appKey:@"09614d215869eb060e07718e"
//                          channel:nil
//                 apsForProduction:YES
//            advertisingIdentifier:nil];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"09614d215869eb060e07718e"
                          channel:nil
                 apsForProduction:YES
            advertisingIdentifier:nil];  // 这里是没有advertisingIdentifier的情况，有的话，大家在自行添加
    //注册远端消息通知获取device token
    [application registerForRemoteNotifications];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:FirstEnterTheHomepage]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longinSuccess) name:@"longinSuccess" object:nil];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerDeviceId) name:@"kJPFNetworkDidLoginNotificationo" object:nil];

    [self startUp];
    
    [self checkVersion];   //检测升级
   
    return YES;
}

-(void)checkVersion
{
    NSString *newVersion;
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1206472785"];//这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"通过appStore获取的数据信息：%@",jsonResponseString);
    
    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    解析json数据
    
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"localVersion版本号是：%@",localVersion);
    
    NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，是否下载新版本？",localVersion,newVersion];
    
    //2.0版本的时候需要清除用户信息
    if ([localVersion floatValue]>1.9&&![[NSUserDefaults standardUserDefaults] boolForKey:firstInstallationVersion2]){
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:firstInstallationVersion2];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
        
        NSMutableDictionary *mut = [[self readDic] mutableCopy];
        if (![NSString isEmpty: mut[@"login"] ]) {
            [mut removeObjectForKey:@"login"];
        }
        [self whriteToFielWith:mut];
    }
    
    if (data) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = json[@"results"];
        
        for (NSDictionary *dic in array) {
            
            newVersion = [dic valueForKey:@"version"];
        }
        
        NSLog(@"通过appStore获取的版本号是：%@",newVersion);
        
        //对比发现的新版本和本地的版本
        if ([newVersion floatValue] > [localVersion floatValue])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"升级提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            
            [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"现在升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/鸣医通/id1206472785?l=zh&ls=1&mt=8"]];
                //这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
                NSLog(@"点击现在升级按钮");
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击下次再说按钮");
            }]];
        }
    }
    
}

- (void)switchRootViewController {

    NSDictionary *dic = [self readDic];
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"login"];
    NSLog(@"%@",str);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userInfo"]);
    if ([dic[@"login"] isEqualToString:@"1"]) {
//        [self registerDeviceId];
        NSDictionary *userInfo = dic[@"userInfo"];
        if(![[NSUserDefaults standardUserDefaults] boolForKey:FirstEnterTheHomepage]){
           YMGuidePageViewController *vc = [YMGuidePageViewController new];
            
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:FirstEnterTheHomepage];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            vc.delegate = self;
            self.window.rootViewController =vc;
            [self.window makeKeyAndVisible];
            
        }else{
            
            [[YMUserInfo sharedYMUserInfo] setValuesForKeysWithDictionary:userInfo];
           // UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           // YMHomeViewController *homeView = storyBoard.instantiateInitialViewController;
            
            KRAllViewController *homeView = [[KRAllViewController alloc]init];
            
            self.window.rootViewController =homeView;
            [self.window makeKeyAndVisible];
            [self configHuanxin];
        }
//        [JPUSHService setTags:[NSSet setWithObject:userInfo[@"member_id"]] aliasInbackground:nil];
        
        NSNotification *notifi =[NSNotification notificationWithName:@"kJPFNetworkDidLoginNotificationo" object:nil userInfo:nil];
       [[NSNotificationCenter defaultCenter] postNotification:notifi];
    } else {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
        
        YMLoginAndRegisterViewController *vc =  storyBoard.instantiateInitialViewController;
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
    }

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

{
  
    NSLog(@"%@",url.host);
    if ([url.host isEqualToString:@"safepay"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
        
        return YES;
    }
    
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];//微信支付
    }
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                
                [[NSNotificationCenter defaultCenter]postNotificationName:payResultFinish object:nil userInfo:@{@"pay":@"1"}];
                
                
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                [[NSNotificationCenter defaultCenter]postNotificationName:payResultFinish object:nil userInfo:@{@"pay":@"0"}];
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
}

- (BOOL)onRCIMCustomAlertSound:(RCMessage *)message {
    if ([[YMUserInfo sharedYMUserInfo].sound isEqualToString:@"1"]) {
        return YES ;
    }
    else {
        return NO ;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //设置应用程序图片右上角的数字(如果想要取消右上角的数字, 直接把这个参数值为0)
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-[UIScreen mainScreen].bounds.size.width, -[UIScreen mainScreen].bounds.size.height) forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application ªis about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// 获得Device Token
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//     NSLog(@"这里的Token就是我们设备要告诉服务端的Token码 == %@",deviceToken);//这里的Token就是我们设备要告诉服务端的Token码

    [JPUSHService registerDeviceToken:deviceToken];
}
// 获得Device Token失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
  
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
    NSLog(@"%@",notification);
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
    NSLog(@"%@",userInfo);
}

#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];

    NSLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    
    NSLog(@"%@",userInfo);
    [self pushNotificationCenter:userInfo];
    
}
//
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];

    [self showTopViewWith:userInfo];

    completionHandler(UIBackgroundFetchResultNewData);
    [application cancelAllLocalNotifications];
    [JPUSHService resetBadge];
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    
  
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}



#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        [self showTopViewWith:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)showTopViewWith:(NSDictionary *)userInfo {

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    __block UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    //topLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    topLabel.font = [UIFont systemFontOfSize:13];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.text = userInfo[@"aps"][@"alert"];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:topLabel];
    [self.window addSubview:topView];
    UIButton *close = [[UIButton alloc]init];
    [topView addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).with.offset(10);
        make.right.equalTo(topView.mas_right).with.offset(-10);
    }];
    [close setImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(hiddenTop:) forControlEvents:UIControlEventTouchUpInside];
//    [UIView animateWithDuration:0.5 animations:^{
//        CGRect rect = topLabel.frame;
//        rect.origin.y = 0;
//        topLabel.frame = rect;
//        [self.window.rootViewController.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
//
//    }];
    [self performSelector:@selector(hiddenTop:) withObject:topView afterDelay:5];
}

- (void)hiddenTop:(UIView *)label {
    if (label) {
        if ([label isKindOfClass:[UIButton class]]) {
            [label.superview removeFromSuperview];
        } else {
            [label removeFromSuperview];
            label = nil;
        }
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        
         [self showTopViewWith:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}

- (void)configHuanxin {
    
   NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
    [dic setObject:[self readDic][@"userInfo"][@"member_id"] forKey:@"member_id"];
    [self getRongyunToken];
}

-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    if ([[YMUserInfo sharedYMUserInfo].vibrates isEqualToString:@"1"]) {
        AudioServicesPlaySystemSound(1600);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }else {
        
    }
    if (message.receivedStatus  == ReceivedStatus_UNREAD) {
        if (left > 0) {
        }
    }
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *))completion {
    
    
    RCUserInfo *userInfo =  [[RCIM sharedRCIM]currentUserInfo];
    if ([userId isEqualToString:userInfo.userId]) {
        userInfo.name = [YMUserInfo sharedYMUserInfo].member_name;
        if ([[YMUserInfo sharedYMUserInfo].member_avatar length] > 0) {
            userInfo.portraitUri = [YMUserInfo sharedYMUserInfo].member_avatar;
        } else {
            userInfo.portraitUri = [YMUserInfo sharedYMUserInfo].default_avatar;
        }
        
      return  completion(userInfo);
    }
    
    else {
        
        NSDictionary *dic = @{@"member_id":userId};
        [[KRMainNetTool sharedKRMainNetTool ]sendRequstWith:@"act=users_personal&op=liaos" params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
            if (!error) {
                
                NSString *name = @"" ;
                if (![showdata[@"member_names"]isEqual:[NSNull null]]) {
                    name = showdata[@"member_names"];
                }

                NSString *portrait = showdata[@"member_avatar"];
                RCUserInfo *userInfo = [[RCUserInfo alloc]initWithUserId:userId name:name portrait:portrait];
                return completion(userInfo);
            }
        }];
    }
    
}

#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


-(void)startUp{
    YMStartUpViewController *vc = [[YMStartUpViewController alloc]init];
    vc.delegate =self;
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

-(void)StartUpView:(YMStartUpViewController *)StartUpView{
    [self switchRootViewController];
}
-(void)StartUpView:(YMStartUpViewController *)StartUpView inputadvertising:(BOOL)inputadvertising requrtUrl:(NSString *)reqrutUrl{

    if (inputadvertising) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:inputadvertisingClick];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:reqrutUrl forKey:@"webUrl"];
        
        [self switchRootViewController];
        
    }
}

-(void)GuidePageController:(YMGuidePageViewController *)GuidePageController IKnow:(BOOL)IKnow{
    [self switchRootViewController];
}

-(void)GuidePageController:(YMGuidePageViewController *)GuidePageController inputPerson:(BOOL)inputPerson{
    [self switchRootViewController];
}

-(void)longinSuccess{
    [self switchRootViewController];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)whriteToFielWith:(NSDictionary *)dic {
    //需求一：创建xxx/Documents/test文件夹
    //1.拼接文件夹的路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *testDirPath = [documentsPath stringByAppendingPathComponent:@"test.plist"];
    //2.获取NSFileManager单例对象(shared/default/standard)
    if ([dic writeToFile:testDirPath atomically:YES]) {
        NSLog(@"写入成功");
    }
    
}


-(void)registerDeviceId
{
    [JPUSHService registrationID];
    NSLog(@"registrationID:%@",[JPUSHService registrationID]);
    //在登录成功对应的方法中设置标签及别名
    //注意：在退出登陆时，要去除对标签及别名的绑定
    /**tags alias
     *空字符串（@“”）表示取消之前的设置
     *nil,此次调用不设置此值
     *每次调用设置有效的别名，覆盖之前的设置
     */
   
    NSDictionary *dic = [self readDic];
    NSDictionary *userInfo = dic[@"userInfo"];

    [[YMUserInfo sharedYMUserInfo] setValuesForKeysWithDictionary:userInfo];
    
    NSMutableSet *setrt= [NSMutableSet setWithObjects:[NSString stringWithFormat:@"%@",[YMUserInfo sharedYMUserInfo].member_id], nil];
    
    [JPUSHService setTags:setrt alias:[YMUserInfo sharedYMUserInfo].member_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);//对应的状态码返回为0，代表成功
    }];

}

-(void)pushNotificationCenter:(NSDictionary *)userInfo{
    
    NSString *content =[userInfo objectForKey:@"content"];
    
    if ([NSString isEmpty:content]) {
        return;
    }
    
    UIViewController *getCurrentVC = [self getCurrentVC];
    switch ([[userInfo objectForKey:@"content_type"] integerValue]) {
        case 1:{
            KRWebViewController *vc= [[KRWebViewController alloc]init];
            vc.saoceUrl =content;
           [getCurrentVC.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            YMActivityDetailsViewController *vc = [[YMActivityDetailsViewController alloc]init];
            vc.activityId = content;
             [getCurrentVC.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 3:{
            YMDoctorHomePageViewController *vc = [[YMDoctorHomePageViewController alloc]init];
            vc.doctorID = content;
            [getCurrentVC.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

-(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        
        NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;   
}

-(void)selectorpadk:(id)error{
    NSLog(@"%@",error);
}

@end
