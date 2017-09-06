//
//  YMNetWorkTool.h
//  doctor_user
//
//  Created by 王梅 on 2017/4/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMNetWorkTool : NSObject


+ (void)sendRequstWith:(NSString *)url params:(NSDictionary *)dic withModel:(Class)model waitView:(UIView *)waitView complateHandle:(void(^)(id showdata,NSString *error))complet;

@end
