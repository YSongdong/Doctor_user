//
//  YMInputTExtViewTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^INPU_END)(NSString *str);
@interface YMInputTExtViewTableViewCell : UITableViewCell
@property (nonatomic, strong) INPU_END block;
- (void)setUpWithDic:(NSDictionary *)dic;
@end
