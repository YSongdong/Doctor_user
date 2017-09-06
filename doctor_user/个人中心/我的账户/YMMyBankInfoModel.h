//
//  YMMyBankInfoModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMMyBankInfoModel : NSObject

@property(nonatomic,copy)NSString *bankId;//银行卡ID

@property(nonatomic,copy)NSString *mem_name;//持卡人姓名
@property(nonatomic,copy)NSString *card_num;//银行卡号
@property(nonatomic,copy)NSString *name;//银行卡名称

@end
