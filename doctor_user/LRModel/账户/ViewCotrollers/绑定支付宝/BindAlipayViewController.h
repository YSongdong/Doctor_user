//
//  BindAlipayViewController.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^returnBackBlock)(NSDictionary *dic);
@interface BindAlipayViewController : UIViewController

@property (nonatomic,copy)returnBackBlock block ;


@property (nonatomic,assign)NSInteger ways ;

@end
