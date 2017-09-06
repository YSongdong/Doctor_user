//
//  YMContactAddressTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMContactAddressTableViewCell;

@protocol YMContactAddressTableViewCellDelegate <NSObject>

@optional

-(void)contactaddress:(UITextView *)textView editContent:(NSString *)editContent;

@end


@interface YMContactAddressTableViewCell : UITableViewCell

@property(nonatomic,copy)NSString *addressStr;

@property(nonatomic,weak)id<YMContactAddressTableViewCellDelegate> delegate;

@property(nonatomic,assign)BOOL leftAlignment;

@property(nonatomic,copy)NSString *titleName;
@property(nonatomic,copy)NSString *placeholder;

-(void) cancelTextViewKeyB;

@end
