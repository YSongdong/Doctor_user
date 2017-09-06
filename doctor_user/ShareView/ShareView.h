//
//  ShareView.h
//  haiyibao
//
//  Created by 曹雪莹 on 2016/11/26.
//  Copyright © 2016年 韩元旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

//	点击按钮block回调
@property (nonatomic,copy) void(^btnClick)(NSInteger);


/**
 *  初始化
 *
 *  @param titleArray 标题数组
 *  @param imageArray 图片数组(如果不需要的话传空数组(@[])进来)
 *  @return ShareView
 */

- (instancetype)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArry:(NSArray *)imageArray;

/**
 *  初始化
 *
 *  @param titleArray 标题数组
 *  @param imageArray 图片数组(如果不需要的话传空数组(@[])进来)
 *  @param qrCode 是否创建二维码
 *  @param headerImageUrl 中间头像的地址
 *  @param shareContent 分享的内容
 *  @return ShareView
 */

-(instancetype)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArry:(NSArray *)imageArray createQRcode:(BOOL)qrCode headerImageUrl:(NSString *)headerImageUrl shareContent:(NSString *)shareContent;

@end
