//
//  YMMyAccountModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMBillRecordModel.h"
#import "YMMoneyModel.h"

@interface YMMyAccountModel : NSObject

@property(nonatomic,copy)NSDictionary *money;//账户信息

@property(nonatomic,copy)NSArray *order;//账单纪录
@property(nonatomic,strong)YMMoneyModel *moneyModel;

@property(nonatomic,strong)NSMutableArray<YMBillRecordModel *> *billRecordArray;

//-(YMMoneyModel *)moneyModel;
//-(NSMutableArray<YMBillRecordModel *>*)billRecordArray;

@end
