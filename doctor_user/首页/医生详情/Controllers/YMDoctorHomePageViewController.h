//
//  YMDoctorHomePageViewController.h
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"


@protocol YMDoctorHomePageViewControllerDelegate <NSObject>

-(void) setIsFollowNSString:(NSString *)followStr andIndexPath:(NSIndexPath *)indexPath;

@end


@interface YMDoctorHomePageViewController : BaseViewController
@property (nonatomic, strong) NSString *doctorID;

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak) id <YMDoctorHomePageViewControllerDelegate> delegate;

@property (nonatomic,assign) BOOL isRootVC; //是否回到根视图

@end
