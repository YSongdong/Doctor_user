//
//  SDDetailDescTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SDDetailDescTableViewCell : UITableViewCell

+(CGFloat)cellDetailDescHeight:(NSDictionary *)symptomStr;

@property(nonatomic,strong) NSDictionary *dict; //数据
@end
