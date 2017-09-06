//
//  SDTranspView.h
//  doctor_user
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDTranspViewDelegate <NSObject>

//拨打电话
-(void)selectdMakePhoneBtnClick:(NSIndexPath *)indexPath;
//在线聊天
-(void)selectdChatBtnClick:(NSIndexPath *)indexPath;

@end




@interface SDTranspView : UIView

@property (nonatomic,weak) id <SDTranspViewDelegate> delegate;

@property (nonatomic,strong) NSIndexPath *indexPath;
@end
