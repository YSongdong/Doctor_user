//
//  YMInfoBaseTableViewController.h
//  doctor_user
//
//  Created by kupurui on 17/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMUserInfoMemberModel.h"

@class YMInfoBaseTableViewController;
@protocol YMInfoBaseTableViewControllerDelegate <NSObject>

@optional

-(void)infoBaseController:(YMInfoBaseTableViewController *)infoBase userInfoModel:(YMUserInfoMemberModel *)informodel;

@end

@interface YMInfoBaseTableViewController : UIViewController

@property(nonatomic,weak)id<YMInfoBaseTableViewControllerDelegate> delegate;

@end
