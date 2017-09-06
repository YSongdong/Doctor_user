//
//  YMFaBuSwitchTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMFaBuSwitchTableViewCell;
@protocol YMFaBuSwitchTableViewCellDelegate <NSObject>

-(void)fabuSwitch:(YMFaBuSwitchTableViewCell *)cell setOn:(BOOL)On;

@end

@interface YMFaBuSwitchTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMFaBuSwitchTableViewCellDelegate> delegate;

@property(nonatomic,copy)NSString *titleName;

@property(nonatomic,assign)BOOL On;

@end
