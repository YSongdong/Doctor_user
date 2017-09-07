//
//  SDStateReportModel.h
//  doctor_user
//
//  Created by dong on 2017/9/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ReportModel.h"

@interface SDStateReportModel : NSObject

@property(nonatomic,copy) NSString *physical_examination; //总数
@property(nonatomic,copy) NSString *physical_examination_con;
@property(nonatomic,strong) NSArray *report;
-(NSMutableArray<ReportModel *> *)stateReport;
@end
