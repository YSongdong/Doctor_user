//
//  YMStartUpViewController.h
//  doctor_user
//
//  Created by 黄军 on 17/5/28.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMStartUpViewController;
@protocol YMStartUpViewControllerDelegate <NSObject>

-(void)StartUpView:(YMStartUpViewController *)StartUpView;

-(void)StartUpView:(YMStartUpViewController *)StartUpView inputadvertising:(BOOL)inputadvertising requrtUrl:(NSString *)reqrutUrl;

@end

@interface YMStartUpViewController : UIViewController

@property(nonatomic,weak)id<YMStartUpViewControllerDelegate> delegate;

@end
