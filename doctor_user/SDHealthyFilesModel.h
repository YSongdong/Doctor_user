//
//  SDHealthyFilesModel.h
//  doctor_user
//
//  Created by dong on 2017/8/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDHealthyFilesModel : NSObject

@property (nonatomic,copy) NSString *member_id;  //用户id
@property (nonatomic,copy) NSString *health_id;   //健康档案id
@property (nonatomic,copy) NSString *smoking;   //抽烟情况  1 不抽，2 少抽，3 很厉害 ，4 老烟民
@property (nonatomic,copy) NSString *drink;      //喝酒情况  1 不喝，2 少喝 ，3 很厉害  ，4 老酒罐
@property (nonatomic,copy) NSString *drugallergy;  //药物过敏
@property (nonatomic,copy) NSString *otherallergies;  //其他过敏
@property (nonatomic,copy) NSString *specialdisease;   //特病慢病
@property (nonatomic,copy) NSString *hospital;   //就诊医院
@property (nonatomic,copy) NSString *genetic;  //遗传病史


@end
