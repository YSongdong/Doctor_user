//
//  YMSexTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SEX_END)(NSString *str,BOOL isSex);

@interface YMSexTableViewCell : UITableViewCell

- (void)setDetailWithDic:(NSDictionary *)dic;

@property (nonatomic, strong) SEX_END block;

@end

