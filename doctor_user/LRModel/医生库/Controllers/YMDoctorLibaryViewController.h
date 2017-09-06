//
//  YMDoctorLibaryViewController.h
//  doctor_user
//
//  Created by kupurui on 2017/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    doctorDefaultInputType,
    doctorInputSeachType,//点击搜索框
} doctorInputType;


@interface YMDoctorLibaryViewController : UIViewController
@property (nonatomic,assign)NSInteger type ;

@property(nonatomic,assign)doctorInputType doctorInputType;

@end
