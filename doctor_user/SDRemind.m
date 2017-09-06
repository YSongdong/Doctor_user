//
//  SDRemind.m
//  doctor_user
//
//  Created by dong on 2017/8/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDRemind.h"

@implementation SDRemind

//----创建plist文件--
+(void)createPlist:(NSString *)nameStr{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:nameStr];
    NSMutableArray *takeDurgArr = [NSMutableArray array];
    
    [takeDurgArr writeToFile:myPath atomically:YES];
    
}

// ------取出用药提醒----
+(NSArray *)takeDurgRemind:(NSString *)filesName{
    
    //获取已经创建的沙盒plist文件路径
    NSString *filepath= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0]stringByAppendingPathComponent:filesName];
    NSArray *takeDurgArr = [[NSArray alloc]initWithContentsOfFile:filepath];
    
    return takeDurgArr;
}
// --------//plist文件，获取其路径-------
+(NSString *)obtainFilesPath:(NSString *)name{

    //获取已经创建的沙盒plist文件路径
    NSString *filepath= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0]stringByAppendingPathComponent:name];
    return filepath;
}

//---------保存plist文件-----
+(void) saveData:(NSArray *)data andFilesPath:(NSString *)filesName{

    [data writeToFile:[self obtainFilesPath:filesName] atomically:YES];
    
}
// --------删除指定id的数据------
+(void) delDataId:(NSString *)delId andFilesPath:(NSString *)name{
   NSArray *arr = [self takeDurgRemind:name];
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:arr];
    for (NSDictionary *dict in dataArr) {
        NSString *wranId = dict[@"warn_id"];
        if ([wranId isEqualToString:delId]) {
            [dataArr removeObject:dict];
           
        }
    }
    
    [self saveData:dataArr.copy andFilesPath:name];
}

// ------删除指定就医提醒ID ------
+(void) delDataJiuYiId:(NSString *)delId andFilesPath:(NSString *)name{
    NSArray *arr = [self takeDurgRemind:name];
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:arr];
    for (NSDictionary *dict in dataArr) {
        NSString *wranId = dict[@"medical_id"];
        if ([wranId isEqualToString:delId]) {
            [dataArr removeObject:dict];
            
        }
    }
    
    [self saveData:dataArr.copy andFilesPath:name];
}

//-------删除plist文件
+(void)delPlistFiles:(NSString *)name{
    
    NSArray *arr = [self takeDurgRemind:name];
    NSMutableArray *delArr = [NSMutableArray arrayWithArray:arr];
    [delArr removeAllObjects];
    [self saveData:delArr.copy andFilesPath:name];


}





@end
