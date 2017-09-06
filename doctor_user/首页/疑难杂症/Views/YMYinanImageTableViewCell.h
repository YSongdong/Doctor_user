//
//  YMYinanImageTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^INPUT_END)(NSString *str);
typedef void(^IMAGE_BTN)(NSInteger tag);
@interface YMYinanImageTableViewCell : UITableViewCell
- (void)setDetailDataWith:(NSDictionary *)dic;
@property (nonatomic, strong) IMAGE_BTN block;
@property (nonatomic, strong) INPUT_END inpuBlock;
@end
