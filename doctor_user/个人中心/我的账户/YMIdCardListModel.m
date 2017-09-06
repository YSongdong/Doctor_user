//
//  YMIdCardListModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMIdCardListModel.h"

@implementation YMIdCardListModel
-(NSMutableArray <YMAlipayInfoModel *> *)alipayArry{
    _alipayArry = [[NSMutableArray alloc]init];
    for (NSMutableDictionary *dic in _zfb_list) {
        
        NSMutableDictionary *alipayDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        NSString * alipayId = [dic valueForKey:@"id"];
        
        [alipayDic setValue:[NSString isEmpty:alipayId]?@"":alipayId forKey:@"alipayId"];
        
        [_alipayArry addObject:[YMAlipayInfoModel modelWithJSON:alipayDic]];
    }
    return _alipayArry;
}

-(NSMutableArray <YMMyBankInfoModel *> *)myBankArry{
    _myBankArry = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in _bank_list) {
        
        NSMutableDictionary *bankDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        NSString * bankIdStr = [dic valueForKey:@"id"];
        
        [bankDic setValue:[NSString isEmpty:bankIdStr]?@"":bankIdStr forKey:@"bankId"];
        
        [_myBankArry addObject:[YMMyBankInfoModel modelWithJSON:bankDic]];
    }
    return _myBankArry;
}

@end
