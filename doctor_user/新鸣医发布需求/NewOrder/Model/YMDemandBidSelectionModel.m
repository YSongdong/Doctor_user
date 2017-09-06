//
//  YMDemandBidSelectionModel.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDemandBidSelectionModel.h"

@implementation YMDemandBidSelectionModel

-(NSMutableArray<YMBidListModel *> *)bidListArry{
    _bidListArry = [NSMutableArray array];
    for (NSDictionary *dic in _bid_list) {
        [_bidListArry addObject:[YMBidListModel modelWithJSON:dic]];
    }
    return _bidListArry;
}

@end
