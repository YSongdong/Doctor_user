//
//  YMSignUpAndDorctorModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMSignUpAndDorctorModel : NSObject

@property(nonatomic,copy)NSString *leaguer_id;//参与对象ID
@property(nonatomic,copy)NSString *leagure_name;//参与对象姓名
@property(nonatomic,copy)NSString *hospital_id;//就诊医院ID
@property(nonatomic,copy)NSString *hospital_name; //就诊医院名称
@property(nonatomic,assign) NSInteger showType;//0:表示显示参与：1:表示就诊
@end
