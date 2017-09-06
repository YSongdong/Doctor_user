//
//  YMMiYiOrderViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/6/2.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YMNewOrderModel.h"
@interface YMMiYiOrderViewCell : UITableViewCell

@property(nonatomic,strong)YMNewOrderModel *model;

@property(nonatomic,assign)BOOL hideMonay;

@end
