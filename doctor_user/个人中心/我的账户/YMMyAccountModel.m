//
//  YMMyAccountModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyAccountModel.h"


@implementation YMMyAccountModel

-(YMMoneyModel *)moneyModel{
    _moneyModel = [[YMMoneyModel alloc]init];
    if (_money) {
        _moneyModel = [YMMoneyModel modelWithJSON:_money];
    }
    return _moneyModel;
}
-(NSMutableArray<YMBillRecordModel *>*)billRecordArray{
    _billRecordArray = [[NSMutableArray alloc]init];
    if (_order) {
        for (NSDictionary *dic in _order) {
            [_billRecordArray addObject:[YMBillRecordModel modelWithJSON:dic]];
        }
    }
       return _billRecordArray;
}

@end
