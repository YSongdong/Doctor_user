//
//  YMInputTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^INPUT_END)(NSString *str);
@interface YMInputTableViewCell : UITableViewCell

@property (nonatomic, strong) INPUT_END block;
- (void)setDetailWithDic:(NSDictionary *)dic dataDic:(NSDictionary *)dataDic;
@property (nonatomic, strong) NSString *canClick;
@property (nonatomic, strong) NSString *vcType;//1.向下箭头 2.向右箭头
@property (nonatomic, strong) NSString *textType;//1.病人姓名 2.最近一次诊断 3.最近二次诊断 4.就诊时间一 5.就诊时间二 6.第二次 7.团队 8.姓名 9.身份证号 10.需求标题
@end
