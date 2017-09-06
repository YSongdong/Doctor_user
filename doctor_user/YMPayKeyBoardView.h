//
//  YMPlayKeyBoard.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YMPayKeyBoardViewDelegate <NSObject>
- (void)numberKeyBoard:(NSInteger) number;//返回数字
-(void)clearKeyBoard;

@end

@interface YMPayKeyBoardView : UIView

@property(nonatomic,weak)id<YMPayKeyBoardViewDelegate> delegate;

@end
