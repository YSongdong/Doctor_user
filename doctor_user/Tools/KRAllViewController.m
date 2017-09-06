//
//  KRAllViewController.m
//  Dntrench
//
//  Created by kupurui on 16/9/12.
//  Copyright © 2016年 CoderDX. All rights reserved.
//

#import "KRAllViewController.h"
#import "MSCustomTabBar.h"
#import "KRAllNavigationViewController.h"
#import "YMHomeViewController.h"
#import "MessageViewController.h"
#import "YMUserCenterTableViewController.h"
#import "YMNewFaBuXuQiuViewController.h"
#import "SDDoctorTreadsViewController.h"
@interface KRAllViewController () <MSTabBarViewDelegate>

@end

@implementation KRAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    
    // 利用 KVC 来使用自定义的tabBar；
    MSCustomTabBar *tabBar = [[MSCustomTabBar alloc] init];
    tabBar.tabBarView.viewDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    
     self.selectedIndex = 0;
    
    [self addAllChildViewController];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    //设置状态栏颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)initialize {
    if (self == [KRAllViewController class]) {
        UITabBar *bar = [UITabBar appearance];
        //bar.translucent = NO;
        bar.tintColor = [UIColor colorWithRed:0 green:102.0/255 blue:167.0/255 alpha:1];
        [bar setBarTintColor:[UIColor whiteColor]];
        //[bar setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
    }
    
}
#pragma mark - Private Methods

// 添加全部的 childViewcontroller
- (void)addAllChildViewController
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YMHomeViewController *homeView = [storyBoard instantiateViewControllerWithIdentifier:@"YMHomeViewController"];
    KRAllNavigationViewController *homeNav = [[KRAllNavigationViewController alloc] initWithRootViewController:homeView];
 
    
    SDDoctorTreadsViewController *doctorTreadVC = [[SDDoctorTreadsViewController alloc] init];
    KRAllNavigationViewController * doctrorTreadNav= [[KRAllNavigationViewController alloc] initWithRootViewController:doctorTreadVC];
    
//    YMNewFaBuXuQiuViewController *xuquVC = [[YMNewFaBuXuQiuViewController alloc]init];
//    KRAllNavigationViewController * xuqiuNav= [[KRAllNavigationViewController alloc] initWithRootViewController:xuquVC];
    
    
    MessageViewController *messageVC = [storyBoard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    KRAllNavigationViewController *messageNav = [[KRAllNavigationViewController alloc] initWithRootViewController:messageVC];
  
    
    YMUserCenterTableViewController *userVC = [storyBoard instantiateViewControllerWithIdentifier:@"YMUserCenterTableViewController"];
    KRAllNavigationViewController *userNav = [[KRAllNavigationViewController alloc] initWithRootViewController:userVC];
 
    self.viewControllers = @[homeNav,doctrorTreadNav,messageNav,userNav];
   
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    KRAllNavigationViewController *nav = [[KRAllNavigationViewController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
   // vc.navigationItem.title = title;
    //    nav.tabBarItem.title = title;
    //    nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
    
    [self addChildViewController:nav];
    
    
}

#pragma mark - MSCustomTabBarViewDelegate

- (void)msTabBarView:(MSTabBarView *)view didSelectItemAtIndex:(NSInteger)index
{
    // 切换到对应index的viewController
    self.selectedIndex = index;
    
}

- (void)msTabBarViewDidClickCenterItem:(MSTabBarView *)view
{
    YMNewFaBuXuQiuViewController *xuquVC = [[YMNewFaBuXuQiuViewController alloc]init];
    KRAllNavigationViewController * xuqiuNav= [[KRAllNavigationViewController alloc] initWithRootViewController:xuquVC];
    [self presentViewController:xuqiuNav animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
