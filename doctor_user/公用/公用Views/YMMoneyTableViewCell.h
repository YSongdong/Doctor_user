//
//  YMMoneyTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BTN_CLICK)(NSInteger clickTag);//1.开始.2.结束
@interface YMMoneyTableViewCell : UITableViewCell
@property (nonatomic, strong) BTN_CLICK block;
- (void)setTimeWithDic:(NSDictionary *)dic;
@property (nonatomic, strong) NSString *vcType;
@end
