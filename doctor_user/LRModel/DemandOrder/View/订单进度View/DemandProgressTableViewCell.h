//
//  DemandProgressTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    operateUnknow , //默认不知
    operateContact, //联系医生
    operateChoice, //选标
    operateContract, //发起合同
    operateAddMoney ,//增加酬金
    operateNotifyWork ,//通知开始工作
    operateSurePay ,//确认付款
    operateArbitration,//申请仲裁
    operateEvaluate ,//评价
    operateShowEvaluate ,//查看评价
    
} OperateType;


@protocol DemandProgressTableViewCellDelegate <NSObject>

- (void)didClickWithDifferentType:(OperateType)type ;
@end

@interface DemandProgressTableViewCell : UITableViewCell

@property (nonatomic,assign)NSDictionary *dataList ;

@property (nonatomic,strong)NSDictionary *model ;
@property (nonatomic,weak)id <DemandProgressTableViewCellDelegate>delegate ;




@end
