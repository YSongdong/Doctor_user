//
//  SDDoctorConsultModel.m
//  doctor_user
//
//  Created by dong on 2017/9/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDDoctorConsultModel.h"

@implementation SDDoctorConsultModel

-(NSMutableArray<DoctorConsultHonorModel *> *)consultHonor{
    NSMutableArray <DoctorConsultHonorModel *> *returnDict = [NSMutableArray array];
    for (NSDictionary *dic in _honor) {
        [returnDict   addObject:[DoctorConsultHonorModel modelWithDictionary:dic]];
    }
    return returnDict;

}


@end
