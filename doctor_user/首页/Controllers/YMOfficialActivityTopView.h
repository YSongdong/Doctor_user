//
//  YMOfficialActivityTopView.h
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMOfficialActivityTopView;

@protocol YMOfficialActivityTopViewDelegate <NSObject>

-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView hallButton:(UIButton *)sender;

-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView participateButton:(UIButton *)sender;

@end

@interface YMOfficialActivityTopView : UIView

@property(nonatomic,weak)id<YMOfficialActivityTopViewDelegate> delegate;

@property(nonatomic,copy)NSString *lefName;
@property(nonatomic,copy)NSString *rightName;

@property(nonatomic,assign)BOOL isRightBtn; //右边按钮

@end
