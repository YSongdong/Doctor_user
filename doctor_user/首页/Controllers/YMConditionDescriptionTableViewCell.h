//
//  YMConditionDescriptionTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMConditionDescriptionTableViewCell;
@protocol YMConditionDescriptionTableViewCellDelegate <NSObject>

-(void)conditionDescriptionCell:(YMConditionDescriptionTableViewCell *)conditionDescriptionCell editContent:(NSString *)editContent;

-(void)conditionDescriptionCell:(YMConditionDescriptionTableViewCell *)conditionDescriptionCell beginEdit:(BOOL)beginEdit;

@end

@interface YMConditionDescriptionTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMConditionDescriptionTableViewCellDelegate> delegate;

@property(nonatomic,copy)NSString *textStr;

@property(nonatomic,copy)NSString  *titleName;
@property(nonatomic,copy)NSString *tipName;

@end
