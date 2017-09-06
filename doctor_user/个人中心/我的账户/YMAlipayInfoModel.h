//
//  YMAlipayInfoModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMAlipayInfoModel : NSObject

@property(nonatomic,copy)NSString *alipayId;//支付宝ID
@property(nonatomic,copy)NSString *mem_name;//支付宝名字
@property(nonatomic,copy)NSString *card_num;//支付宝帐号

@end
