//
//  YMCaseDetailsMonthInformationModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseDetailsMonthInformationModel.h"

@implementation YMCaseDetailsMonthInformationModel


-(NSMutableArray<YMCaseDetailsDayInformationModel *> *)monthDetail{
    NSMutableArray<YMCaseDetailsDayInformationModel *> *returnDetail = [NSMutableArray array];
    for (NSDictionary *dic in _detail) {
        [returnDetail addObject:[YMCaseDetailsDayInformationModel modelWithJSON:dic]];
    }
    return returnDetail;
}

@end
