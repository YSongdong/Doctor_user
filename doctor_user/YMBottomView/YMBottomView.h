//
//  YMBottomView.h
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /*
     * 背景色:蓝色，
     * 文字左边图片：无，
     * 文字颜色：蓝色，
     * 边框：无
     * 按钮背景:白
     * 边框颜色：无
     */
    MYBottomBlueType,

    /*
     * 背景色:蓝色，
     * 文字左边图片：有，
     * 文字颜色：蓝色，
     * 边框：无
     * 按钮背景:白
     * 边框颜色：无
     */
    MYBottomBlueAndLeftIconType,
    /*
     * 背景色:蓝色，
     * 文字左边图片：无，
     * 文字颜色：白色，
     * 边框：无
     * 按钮背景:无
     * 边框颜色：无
     */
    MYBottomBlueAndwhiteType,
    
    /*
     * 背景色:灰色，
     * 文字左边图片：无，
     * 文字颜色：灰色，
     * 边框：无
     * 按钮背景:白
     * 边框颜色：无
     */
    MYBottomGrayType,
    /*
     * 背景色:白色，
     * 文字左边图片：有，
     * 文字颜色：灰色，
     * 边框：有
     * 边框颜色：灰色
     * 按钮背景色：白色
     */
    MYBottomWhiteBackAndGrayTextAndLeftIconType,
    /*
     * 背景色:白色，
     * 文字左边图片：无，
     * 文字颜色：蓝色，
     * 边框：有
     * 边框颜色：灰色
     * 按钮背景：白色
     */
    MYBottomWhiteType,
    /*
     * 背景色:白色，
     * 文字左边图片：有，
     * 文字颜色：蓝色，
     * 边框：有
     * 边框颜色：灰色
     * 按钮背景：白色
     */
    MYBottomWhiteAndLeftIconType,
    
} MYBottomType;

@class YMBottomView;
@protocol YMBottomViewDelegate <NSObject>

-(void)bottomView:(YMBottomView *)bottomClick;

@end

@interface YMBottomView : UIView
@property(nonatomic,copy)NSString *bottomTitle;

@property(nonatomic,copy)NSString *bottomImageName;//没有图片就不用设置

@property(nonatomic,assign)MYBottomType type;

@property(nonatomic,weak)id<YMBottomViewDelegate> delegate;


@end
