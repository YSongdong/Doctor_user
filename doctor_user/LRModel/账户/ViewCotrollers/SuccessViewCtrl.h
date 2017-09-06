//
//  SuccessViewCtrl.h
//  doctor_user
//
//  Created by dong on 2017/7/13.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    bankList,
    withDraw,
}SuccessType;
@interface SuccessViewCtrl : UIViewController

@property (nonatomic,assign)SuccessType type ;

@end
