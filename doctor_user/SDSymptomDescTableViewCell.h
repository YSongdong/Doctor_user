//
//  SDSymptomDescTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDSymptomDescTableViewCell : UITableViewCell


@property(nonatomic,strong) NSString *syptomStr;

+(CGFloat)cellSymptomHeight:(NSString *)symptomStr;

@end
