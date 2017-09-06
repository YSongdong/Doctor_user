//
//  YMNetWorkTool.m
//  doctor_user
//
//  Created by 王梅 on 2017/4/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

//上架
////#define baseURL1 @"https://ys9958.com/api/index.php?"
////测试
//#define baseURL1 @"https://test.ys9958.com/api/index.php?"

#import "YMNetWorkTool.h"

#import "AFNetworking.h"


static NSString * isShow = @"1";

@implementation YMNetWorkTool
singleton_implementation(KRMainNetTool)

//需要显示加载动画的接口方法 不上传文件
+ (void)sendRequstWith:(NSString *)url params:(NSDictionary *)dic withModel:(Class)model waitView:(UIView *)waitView complateHandle:(void(^)(id showdata,NSString *error))complet {
    //拼接网络请求url
    NSString *path = [NSString stringWithFormat:@"%@%@",BASEURL,url];
    
    NSLog(@"%@",path);

    [waitView showRoundProgressWithTitle:nil];
    //开始网络请求
    [[AFHTTPSessionManager manager] POST:path parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *num = responseObject[@"status"];
        //判断返回的状态，200即为服务器查询成功，500服务器查询失败
        //NSLog(@"%@",responseObject);
        if ([num longValue] == 200) {
            if (model == nil) {
                if (responseObject[@"show_data"]) {
                    if ([isShow isEqualToString:@"1"]) {
                        [waitView hideBubble];
                    }
                    
                    complet(responseObject[@"show_data"],nil);
                } else {
                    if ([isShow isEqualToString:@"1"]) {
                        [waitView hideBubble];
                    }
                    
                    complet(responseObject[@"message"],nil);
                }
                
            } else {
                [waitView hideBubble];
                complet([self getModelArrayWith:responseObject[@"show_data"] andModel:model],nil);
            }
        } else if ([num longValue] == 500){
            
            if (model == nil) {
                if (responseObject[@"show_data"]) {
//                    if ([isShow isEqualToString:@"1"]) {
//                        
//                    }
                    
                    complet(responseObject[@"show_data"],responseObject[@"message"]);
                } else {
//                    if ([isShow isEqualToString:@"1"]) {
//                                            }
                    
                    complet(nil,responseObject[@"message"]);
                    [waitView showErrorWithTitle:responseObject[@"message"] autoCloseTime:2];
                }
                
            } else {
                [waitView hideBubble];
                complet([self getModelArrayWith:responseObject[@"show_data"] andModel:model],nil);
            }

        }else {
            if ([responseObject[@"message"] length] > 5) {
                
                //                [1]	(null)	@"message" : @"请在资料管理填写个人资料"
                [waitView showErrorWithTitle:responseObject[@"message"] autoCloseTime:2];
            } else {
                [waitView showErrorWithTitle:responseObject[@"message"] autoCloseTime:2];
            }
            
            complet(responseObject[@"show_data"],responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //网络请求失败，隐藏HUD，服务器响应失败。网络问题 或者服务器崩溃
        //[waitView hideBubble];
        NSLog(@"%@",error);
        [waitView showErrorWithTitle:@"网络错误" autoCloseTime:2];
        complet(nil,@"网络错误");
    }];
}

//把模型数据传入返回模型数据的数组
+ (NSArray *)getModelArrayWith:(NSArray *)array andModel:(Class)modelClass {
    NSMutableArray *mut = [NSMutableArray array];
    //遍历模型数据 用KVC给创建每个模型类的对象并赋值过后放进数组
    for (NSDictionary *dic in array) {
        id model = [modelClass new];
        [model setValuesForKeysWithDictionary:dic];
        [mut addObject:model];
    }
    return [mut copy];
}




@end
