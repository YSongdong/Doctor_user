//
//  YMOrderStatusView.h
//  doctor_user
//
//  Created by 黄军 on 17/6/2.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    allOrderTag=10001,
    processingOrderTag,
    completedOrderTag,
    failureOrderTag,
} OrderTag;

@class YMOrderStatusView;
@protocol YMOrderStatusViewDelegate <NSObject>

-(void)orderStatusView:(YMOrderStatusView *)orderStatus clickTag:(OrderTag)clickTag;

@end

@interface YMOrderStatusView : UIView

@property(nonatomic,weak)id<YMOrderStatusViewDelegate> delegate;

-(void)selectOrderStatus:(OrderTag)orderStatus;

@end
