//
//  YMHospitalAndDepartmentModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHospitalAndDepartmentModel.h"

@implementation YMHospitalAndDepartmentModel

-(NSMutableArray<YMHospitalModel *> *)hospitallArry{
    _hospitallArry = [NSMutableArray array];
    for (NSDictionary *dic in _hospital_type) {
        [_hospitallArry addObject:[YMHospitalModel modelWithJSON:dic]];
    }
    return _hospitallArry;
}

-(NSMutableArray<YMDepartmentModel *> *)departmentsArry{
    _departmentsArry = [NSMutableArray array];
    for (NSDictionary *dic in _departments) {
        NSMutableDictionary *mudic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        [mudic setObject:dic[@"id"] forKey:@"departemID"];
        [_departmentsArry addObject:[YMDepartmentModel modelWithJSON:dic]];
    }
    return _departmentsArry;
}

@end
