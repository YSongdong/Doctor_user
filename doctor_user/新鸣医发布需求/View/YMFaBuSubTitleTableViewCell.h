//
//  YMFaBuSubTitleTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    rightArrowType,
    bottomArrowType,
} arrowType;

@interface YMFaBuSubTitleTableViewCell : UITableViewCell

@property(nonatomic,assign)arrowType type;

@property(nonatomic,copy)NSString *titleName;
@property(nonatomic,copy)NSString *subTitleName;

@property(nonatomic,assign)BOOL hiddenArrow;

@end
