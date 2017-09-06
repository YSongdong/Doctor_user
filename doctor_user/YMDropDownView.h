//
//  YMDropDownView.h
//  doctor_user
//
//  Created by 黄军 on 17/5/21.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSignUpAndDorctorModel.h"

typedef enum : NSUInteger {
    DropDownDefaultType,
    DropDownActivitySignUpType,//活动报名
    DropDownActivityParticipateType,//活动参与
} DropDownType;

@class YMDropDownView;

@protocol YMDropDownViewDelegate <NSObject>

-(void) dropDownView:(YMDropDownView *)dropDownView clickModel:(YMSignUpAndDorctorModel *)model;

@end

@interface YMDropDownView : UIView

@property(nonatomic,strong)NSArray<YMSignUpAndDorctorModel *> *data;

@property(nonatomic,weak)id<YMDropDownViewDelegate> delegate;

@property(nonatomic,assign)CGFloat distanceTopHeight;
@property(nonatomic,assign)DropDownType type;
@end
