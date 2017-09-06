//
//  YMRegisteredViewTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMRegisteredViewTableViewCell;
@protocol YMRegisteredViewTableViewCellDelegate <NSObject>

-(void)registeredViewCell:(YMRegisteredViewTableViewCell *)registeredViewCell setOn:(BOOL)On;

@end

@interface YMRegisteredViewTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMRegisteredViewTableViewCellDelegate> delegate;

@property(nonatomic,assign)BOOL On;

@property(nonatomic,copy)NSString *feiyong;

@end
