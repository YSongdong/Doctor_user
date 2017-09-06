//
//  YMDoctorActivityModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMSignUpAndDorctorModel.h"

@interface YMDoctorActivityModel : NSObject

@property(nonatomic,copy)NSString *leagure_name;
@property(nonatomic,copy)NSMutableArray<YMSignUpAndDorctorModel *> *hospital;

@end
