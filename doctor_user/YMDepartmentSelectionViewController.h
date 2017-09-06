//
//  YMDepartmentSelectionViewController.h
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMDepartmentSelectionViewController;

@protocol YMDepartmentSelectionViewControllerDelegate <NSObject>

@optional
-(void)departmentView:(YMDepartmentSelectionViewController *)departmentView  disorder:(NSString *)disorder ename:(NSString *)ename;

-(void)departmentView:(YMDepartmentSelectionViewController *)departmentView  disorder:(NSString *)disorder ename:(NSString *)ename big_ks:(NSString*)big_ks;

@end

@interface YMDepartmentSelectionViewController : UIViewController

@property(nonatomic,weak)id<YMDepartmentSelectionViewControllerDelegate> delegate;

@property(nonatomic,assign)BOOL hiddentopView;

@end
