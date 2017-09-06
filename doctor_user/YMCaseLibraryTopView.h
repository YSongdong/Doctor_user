//
//  YMCaseLibraryTopView.h
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMCaseLibraryTopView;
@protocol YMCaseLibraryTopViewDelegate <NSObject>

-(void)caseLibraryTopView:(YMCaseLibraryTopView *)caseLibraryTopView clcikTage:(NSInteger )tage;

@end

@interface YMCaseLibraryTopView : UIView

@property(nonatomic,weak)id<YMCaseLibraryTopViewDelegate> delegate;

@property(nonatomic,copy)NSString  *title;

@end
