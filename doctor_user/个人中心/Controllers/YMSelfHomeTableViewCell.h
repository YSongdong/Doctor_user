//
//  YMSelfHomeTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMSelfHomeTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL lastOne;//最后一个Cell

@property(nonatomic,assign) BOOL lineInterval;//间隔

@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,copy)NSString *titleName;

@property(nonatomic,copy)NSString *subTitlename;//不传值的时是隐藏状态

@property(nonatomic,assign)BOOL hiddrightImage;

@end
