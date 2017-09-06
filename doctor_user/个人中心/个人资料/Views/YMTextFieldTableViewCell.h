//
//  YMTextFieldTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMTextFieldTableViewCell;

@protocol YMTextFieldTableViewCellDelegate <NSObject>

-(void)textFieldCell:(YMTextFieldTableViewCell *)textField startEdit:(BOOL)startEdit;

-(void)textFieldCell:(UITextField *)textField inputChange:(NSString *)inputStr;

@end

@interface YMTextFieldTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL showTextfield;

@property(nonatomic,copy)NSString *titleName;

@property(nonatomic,copy)NSString *inputTextFieldName;

@property(nonatomic,copy)NSString *subTitleName;

@property(nonatomic,copy)NSString *textFieldPlaceholder;//提示信息

@property(nonatomic,weak)id<YMTextFieldTableViewCellDelegate> delegate;

@property(nonatomic,assign)NSInteger textFieldTag;

@end
