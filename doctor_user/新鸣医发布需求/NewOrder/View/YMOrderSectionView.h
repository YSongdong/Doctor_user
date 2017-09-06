//
//  YMOrderSectionView.h
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    titleStatusDefaultStatus,//默认状态:01颜色和图片:蓝色
    titleStatusGrayStatus,//01颜色和图片:灰色
} titleStatus;

typedef enum : NSUInteger {
    HeaderNumberType,//包含数字
    HeaderTopllTye,//tip
    HeaderCloseType,//关闭
    HeaderFailureType,//失败
} HeaderType;//标题的类型



@class YMOrderSectionView;
@protocol YMOrderSectionViewDelegate <NSObject>

@optional
-(void)orderSectionView:(YMOrderSectionView *)View closeButton:(UIButton *)sender;

@end

@interface YMOrderSectionView : UIView

@property(nonatomic,copy)NSString *titleLeftStr;

@property(nonatomic,copy)NSString *titleRightStr;//没有可以不填写

@property(nonatomic,copy)NSString *titleNumberStr;

@property(nonatomic,assign)titleStatus status;


@property(nonatomic,assign)HeaderType type;


@property(nonatomic,weak)id<YMOrderSectionViewDelegate> delegate;



@end
