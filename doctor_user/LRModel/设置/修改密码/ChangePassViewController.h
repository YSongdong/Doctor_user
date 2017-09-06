//
//  ChangePassViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/8.
//  Copyright © 2017年 mac. All rights reserved.
//
typedef enum : NSUInteger {
    changeLoginType,
    changePayType,
} changeType;

@interface ChangePassViewController : UIViewController

@property (nonatomic,assign)NSInteger step ;

@property(nonatomic,assign)changeType type;

- (void)finishFindpassOperate ;
- (void)getDataSuccess ;

@end
