//
//  KRAllNavigationViewController.m
//  Dntrench
//
//  Created by kupurui on 16/9/12.
//  Copyright © 2016年 CoderDX. All rights reserved.
//

#import "KRAllNavigationViewController.h"

@interface KRAllNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation KRAllNavigationViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    
  
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.childViewControllers.count == 1)
    {
        return NO;
    }
    return YES;
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)initialize {
    if (self == [KRAllNavigationViewController class]) {
        UINavigationBar *bar = [UINavigationBar appearance];
        //[bar setTintColor:[UIColor whiteColor]];
        bar.translucent = NO;

//        [UINavigationBar setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(80, 168, 252)]
//                           forBarPosition:UIBarPositionAny
//                               barMetrics:UIBarMetricsDefault];
//        [UINavigationBar setShadowImage:[UIImage new]];
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#3d85cc"]];
       // [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(80, 168, 252)];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        bar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    
    }//00c3ff
}





@end
