//
//  YMMyReplyTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMMyReplyTableViewCell;
@protocol YMMyReplyTableViewCellDelegate <NSObject>

-(void)MyReplyView:(YMMyReplyTableViewCell *)view commentStr:(NSString  *)commentStr submitButton:(UIButton *)sender;


@end

@interface YMMyReplyTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMMyReplyTableViewCellDelegate> delegate;

@property(nonatomic,strong) NSString *user_hui;

@end
