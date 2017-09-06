//
//  YMActivityDetailsTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMActivityDetailsTableViewCell : UITableViewCell
+(CGFloat)activityDetailHeight:(NSString *)activityPresent;
@property(nonatomic,copy)NSString *present;
@end
