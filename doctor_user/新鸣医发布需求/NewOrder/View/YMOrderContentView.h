//
//  YMOrderContentView.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMOrderContentView;
@protocol YMOrderContentViewDelegate <NSObject>

-(void)orderContentView:(YMOrderContentView *)view userSubPing:(NSDictionary *)commentDic submitButton:(UIButton *)sender;

-(void)orderContentView:(YMOrderContentView *)view changeButton:(UIButton *)sender;

-(void)orderContentView:(YMOrderContentView *)view closeButton:(UIButton *)sender;

@end

@interface YMOrderContentView : UIView

@property(nonatomic,strong)NSArray *labeArry;

@property(nonatomic,weak)id<YMOrderContentViewDelegate> delegate;

@end
