//
//  YMSeclectCompleteTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMSeclectCompleteTableViewCell;
@protocol YMSeclectCompleteTableViewCellDelegate <NSObject>

-(void)seclectCompleteCell:(YMSeclectCompleteTableViewCell *)seclectCompleteCell lookContract:(UIButton *)sender;

@end
@interface YMSeclectCompleteTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMSeclectCompleteTableViewCellDelegate> delegate;

@end
