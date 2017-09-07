//
//  SDHealthyStateFormViewController.h
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDHealthyStateFormViewController : UIViewController

@property(nonatomic,strong) NSString *btnType; //1 体检报告查看  3 鸣医体检解读 4 绿色住院通道  6医生服务到家   8 绿色就诊通道 

@property(nonatomic,strong) NSString * p_health_id; //私人医生会员
@end
