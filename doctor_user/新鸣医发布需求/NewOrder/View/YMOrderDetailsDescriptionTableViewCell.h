//
//  YMOrderDetailsDescriptionTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMOrderDetailsDescriptionTableViewCell : UITableViewCell

@property(nonatomic,copy)NSString *descriptionComment;
+(CGFloat)heightForDescriptionComment:(NSString *)descriptionComment;
@end
