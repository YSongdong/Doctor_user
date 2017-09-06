//
//  YMUserCenterHeadTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^repare)(BOOL isRepare,NSInteger tag);
@interface YMUserCenterHeadTableViewCell : UITableViewCell

- (void)setHeadDataWith:(NSDictionary *)dic;

@property (nonatomic, strong) repare block;

@end
