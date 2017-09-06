//
//  YMUserInfo.m
//  doctor_user
//
//  Created by kupurui on 17/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMUserInfo.h"
#import <objc/runtime.h>
@implementation YMUserInfo
singleton_implementation(YMUserInfo)
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

-(NSString *)member_id{
    if ([NSString isEmpty:_member_id]) {
        return @"";
    }else{
       return _member_id;
    }
}

//- (void)valueChange {
//   NSDictionary *dic = [self readDic];
//   NSMutableDictionary *user = dic[@"userInfo"];
//    
//    u_int count;
//    // 传递count的地址过去 &count
//    objc_property_t *properties  =class_copyPropertyList([self class], &count);
//    //arrayWithCapacity的效率稍微高那么一丢丢
//    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
//    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
//    for (int i = 0; i < count ; i++)
//    {
//        
//        //此刻得到的propertyName为c语言的字符串
//        const char* propertyName = property_getName(properties[i]);
//        //此步骤把c语言的字符串转换为OC的NSString
//        
//        
//        
//    }
//    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
//    // You must free the array with free().
//    free(properties);
//    
//   
//    
//}
@end
