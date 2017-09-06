//
//  YMMyContentTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCheckPingModel.h"

@interface YMMyContentTableViewCell : UITableViewCell

@property(nonatomic,strong)YMCheckPingModel *model;

+(CGFloat)heightForContent:(NSString *)content forLabelAyy:(NSArray *)labelArry;

@end
