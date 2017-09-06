//
//  YMUserInfoTableViewController.h
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//
typedef void(^callBlock)(NSString * name,NSString * idNum) ;

#import <UIKit/UIKit.h>

@interface YMUserInfoTableViewController : UITableViewController
@property (nonatomic, strong) NSString *vcType;//1 基本信息 2 隐私信息

@property (nonatomic,copy) callBlock block;

@end
