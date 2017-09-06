//
//  YMImportantReminderTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMImportantReminderTableViewCell : UITableViewCell

@property(nonatomic,strong)NSArray *tipsArry ;

+(CGFloat)heightForTipsArry:(NSArray *)tipsArry;

@end
