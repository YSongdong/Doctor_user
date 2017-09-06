//
//  YMTitleAndTextFieldTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMTitleAndTextFieldTableViewCell;
@protocol YMTitleAndTextFieldTableViewCellDelegate <NSObject>

-(void)TitleAndTextFieldCell:(YMTitleAndTextFieldTableViewCell *)cell textField:(NSString *)content;


@end

@interface YMTitleAndTextFieldTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMTitleAndTextFieldTableViewCellDelegate> delegate;

@property(nonatomic,copy)NSString *titleName;
@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,copy)NSString *subTitleName;

-(void) cancelTextFieldKeyB;
@end
