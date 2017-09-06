//
//  YMHomeServerTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/13.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>



@class YMHomeServerTableViewCell;

@protocol YMHomeServerTableViewCellDelegate <NSObject>

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell firstLeftButton:(UIButton *)sender;

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell twoLeftButton:(UIButton *)sender;

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell threeLeftButton:(UIButton *)sender;

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell firstSubLeftButton:(UIButton *)sender;

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell twoSubLeftButton:(UIButton *)sender;

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell threeSubLeftButton:(UIButton *)sender;

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell firstSubRightButton:(UIButton *)sender;

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell twoSubRightButton:(UIButton *)sender;

-(void)HomeServerTableViewCell:(YMHomeServerTableViewCell *)cell threeSubRightButton:(UIButton *)sender;
@end

@interface YMHomeServerTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMHomeServerTableViewCellDelegate> delegate;

@end
