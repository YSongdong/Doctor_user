//
//  YMIdCardListModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YMMyBankInfoModel.h"
#import "YMAlipayInfoModel.h"

@interface YMIdCardListModel : NSObject
@property(nonatomic,strong)NSArray *bank_list;//银行卡列表
@property(nonatomic,strong)NSArray *zfb_list;//支付宝列表

@property(nonatomic,strong)NSMutableArray <YMMyBankInfoModel *> *myBankArry;

@property(nonatomic,strong)NSMutableArray<YMAlipayInfoModel *> *alipayArry;

@end
