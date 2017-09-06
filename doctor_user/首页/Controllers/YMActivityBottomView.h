//
//  YMActivityBottomView.h
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BottomDefaultType,//默认类型
    BottomActivityType,//活动详情
    BottomAccountType,//个人账户
    BottomUserInfoType,
} BottomViewType;

@class YMActivityBottomView;
@protocol YMActivityBottomViewDelegate <NSObject>

-(void)activityBottomView:(YMActivityBottomView *)ActivityBottomView bottomClick:(UIButton *)sender;

@end

@interface YMActivityBottomView : UIView

@property(nonatomic,weak)id<YMActivityBottomViewDelegate> delegate;

@property(nonatomic,copy)NSString *bottomTitle;
@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,assign)BottomViewType type;//将需要赋的值赋以后在给类型。


@end
