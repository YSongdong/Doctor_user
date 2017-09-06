//
//  YMGuahaoInfoTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMGuahaoInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *type;

- (void)setDetailWithDic:(NSDictionary *)dic;

@end
