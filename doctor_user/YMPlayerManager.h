//
//  YMPlayerManager.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    AplayPayType,
    WXPayType,
    banalcePlayType,
} payType;

@class YMPlayerManager;
@protocol YMPlayerManagerDelegate <NSObject>

-(void)playSuccess:(YMPlayerManager *)manager;

@end

@interface YMPlayerManager : NSObject


@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,assign)payType type;

@property(nonatomic,weak)id<YMPlayerManagerDelegate> delegate;

/*
 * view:需要加在动画
 */
-(instancetype)initManagerView:(UIView *)view;

-(void)startPay;


@end
