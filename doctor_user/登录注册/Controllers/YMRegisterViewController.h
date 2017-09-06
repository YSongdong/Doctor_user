//
//  YMRegisterViewController.h
//  doctor_user
//
//  Created by kupurui on 17/2/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YMRegisterViewControllerDelegate <NSObject>

-(void) registSuccessDict:(NSDictionary*)dict;

@end
@interface YMRegisterViewController : UIViewController
@property(nonatomic,weak) id <YMRegisterViewControllerDelegate> delegate;
@end
