//
//  YMLocalBanner.h
//  ShuangHe
//
//  Created by 谭攀 on 16/10/16.
//  Copyright © 2016年 shuanghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMLocalBannerModel.h"

@class YMLocalBanner;
@protocol YMLocalBannerViewDelegate <NSObject>
@optional
- (void)banner:(YMLocalBanner *)banner didClickBanner:(YMLocalBannerModel *)model;

- (void)banner:(YMLocalBanner *)banner didChangeViewWithIndex:(NSInteger )index;

@end


@interface YMLocalBanner : UIView

@property (nonatomic, strong) NSArray<YMLocalBannerModel *> *models;

@property (nonatomic, weak) id<YMLocalBannerViewDelegate> delegate;

/**
 *  是否自动换页,必须在setModel之前赋值
 */
@property (nonatomic, assign) BOOL autoScroll;

- (void)removeTimer;

@end
