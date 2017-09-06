//
//  YMSelectBankCardViewController.h
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMWithdrawModel.h"

@class YMSelectBankCardViewController;

@protocol YMSelectBankCardViewControllerDelegate <NSObject>

-(void)selectBankCard:(YMSelectBankCardViewController *) selectBankCard withdraw:(YMWithdrawModel *)model;

@end


@interface YMSelectBankCardViewController : UIViewController

@property(nonatomic,weak)id<YMSelectBankCardViewControllerDelegate> delegate;

@end
