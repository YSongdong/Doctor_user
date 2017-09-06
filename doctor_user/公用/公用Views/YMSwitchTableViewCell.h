//
//  YMSwitchTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^inputChage)(BOOL isSwitch,NSString *text);
@interface YMSwitchTableViewCell : UITableViewCell
- (void)setDetailWithDic:(NSDictionary *)dic andDataDic:(NSDictionary *)dataDic;
@property (nonatomic, strong) inputChage block;
@end
