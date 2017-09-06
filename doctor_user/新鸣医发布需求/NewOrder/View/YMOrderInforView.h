//
//  YMOrderInforView.h
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YMDemandBidSelectionModel.h"
#import "YMDoctorOrderProcessModel.h"

@class YMOrderInforView;
@protocol YMOrderInforViewDelegate <NSObject>

-(void)orderInfoView:(YMOrderInforView *)orderView orderDetails:(UIButton *)sender;

@end

@interface YMOrderInforView : UIView

@property(nonatomic,weak)id<YMOrderInforViewDelegate> delegate;

@property(nonatomic,strong)YMDemandBidSelectionModel *model;

@property(nonatomic,strong)YMDoctorOrderProcessModel *doctorOrdermodel;

@end
