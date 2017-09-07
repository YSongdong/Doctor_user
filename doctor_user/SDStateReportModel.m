//
//  SDStateReportModel.m
//  doctor_user
//
//  Created by dong on 2017/9/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDStateReportModel.h"

@implementation SDStateReportModel

-(NSMutableArray<ReportModel *> *)stateReport{
   NSMutableArray<ReportModel *> *returnDetail = [NSMutableArray array];
    for (NSDictionary *dic in _report) {
        [returnDetail addObject:[ReportModel modelWithDictionary:dic]];
    }

    return returnDetail;
}

@end
