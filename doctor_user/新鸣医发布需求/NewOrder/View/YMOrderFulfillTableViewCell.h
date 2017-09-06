//
//  YMOrderFulfillTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FulfillButtonAplayType,//支付类型
    FulfillButtonWorkType,//完成工作类型
} FulfillButtonType;


@class YMOrderFulfillTableViewCell;
@protocol YMOrderFulfillTableViewCellDelegate <NSObject>

-(void)orderFulfillViewCell:(YMOrderFulfillTableViewCell *)orderFulfillViewCell leftClick:(UIButton *)sender;

-(void)orderFulfillViewCell:(YMOrderFulfillTableViewCell *)orderFulfillViewCell rightClick:(UIButton *)sender;

@end


@interface YMOrderFulfillTableViewCell : UITableViewCell

@property(nonatomic,copy)NSString *leftStr;
@property(nonatomic,copy)NSString *rightStr;

@property(nonatomic,assign)FulfillButtonType type;

@property(nonatomic,weak)id<YMOrderFulfillTableViewCellDelegate> delegate;


@end
