//
//  YMUserInfoMemberTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMUserInfoMemberModel.h"

@class YMUserInfoMemberTableViewCell;

@protocol YMUserInfoMemberTableViewCellDelegate <NSObject>

-(void)userInfoMemberCell:(YMUserInfoMemberTableViewCell *)userInfoMemberCell  model:(YMUserInfoMemberModel *)model add:(BOOL)add ;


@end

@interface YMUserInfoMemberTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL editStatus;//是否为编辑状态

@property(nonatomic,strong)YMUserInfoMemberModel *model;

@property(nonatomic,weak)id<YMUserInfoMemberTableViewCellDelegate> delegate;

@property(nonatomic,assign)BOOL selectedStatus;//选中状态 不是编辑状态下也需要传

@end
