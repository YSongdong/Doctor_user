//
//  YMHomeServerView.h
//  doctor_user
//
//  Created by 黄军 on 17/5/13.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ServerLeftButton,
    ServerSubLeftButton,
    ServerSubRightButton,
} serverButton;

@class YMHomeServerView;

@protocol YMHomeServerViewDelegate <NSObject>

-(void)serverView:(YMHomeServerView *)serverView serverType:(serverButton )serverType button:(UIButton *)sender;

@end

@interface YMHomeServerView : UIView

@property(nonatomic,weak)id<YMHomeServerViewDelegate> delegate;

/**
 * @"leftButtonNormal" :@"图片名字"
 * @"leftButtonHig" :@"图片名字"
 * @"subLeftImage":@"图片名字"
 * @"subRightImage":@"图片名字"
 * @"subLeftName":@"label显示的文字"
 * @"subRightName":@"label显示的文字"
 */



@property(nonatomic,strong)NSDictionary *data;

@end
