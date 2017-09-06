//
//  SDTimeCountView.h
//  doctor_user
//
//  Created by dong on 2017/8/10.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SDTimeCountViewDelegate <NSObject>

-(void)selectdBtnTitle:(NSString *)title andIndexPath:(NSIndexPath *)indexPath;

@end

@interface SDTimeCountView : UIView

@property (nonatomic,weak) id <SDTimeCountViewDelegate> delegate;

@property(nonatomic,strong) NSIndexPath *indexPath;

@end
