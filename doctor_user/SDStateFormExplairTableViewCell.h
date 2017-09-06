//
//  SDStateFormExplairTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDStateFormExplairTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *explairLabel;

@property (nonatomic, strong) NSString *textType; //1 个人健康状况 2 健康管理方案


@end
