//
//  YMExplainAndTipTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMUserContractPageModel.h"

@interface YMExplainAndTipTableViewCell : UITableViewCell

@property(nonatomic,strong)YMUserContractPageModel *model;

+(CGFloat)heightForExplain:(NSString *)explain forTips:(NSString *)tips;

@end
