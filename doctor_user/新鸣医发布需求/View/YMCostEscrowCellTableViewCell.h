//
//  YMCostEscrowCellTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMCostEscrowCellTableViewCell;
@protocol YMCostEscrowCellTableViewCellDelegate <NSObject>

-(void)constEscrowCell:(YMCostEscrowCellTableViewCell *)cell textField:(NSString *)content;


@end

@interface YMCostEscrowCellTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMCostEscrowCellTableViewCellDelegate> delegate;

//酬金TF
@property(nonatomic,strong)UITextField *subTextField;


@property(nonatomic,strong)NSString * minimumAmount;

@property(nonatomic,strong)NSString *subText;

@property(nonatomic,strong)NSString *titleName;


@end
