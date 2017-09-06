//
//  YMOrderViewController.h
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMOrderViewController;
@protocol YMOrderViewControllerDelegate <NSObject>

-(void)orderView:(YMOrderViewController *)orderView demand_sn:(NSString *)demand_sn;

@end

@interface YMOrderViewController : UIViewController

@property(nonatomic,weak)id<YMOrderViewControllerDelegate> delegate;


@property(nonatomic,assign)BOOL returnRoot; //是不是回到首页

@property(nonatomic,assign)BOOL isYiNan; //是否疑难杂症


@end
