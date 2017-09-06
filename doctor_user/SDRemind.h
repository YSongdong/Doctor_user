//
//  SDRemind.h
//  doctor_user
//
//  Created by dong on 2017/8/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDRemind : NSObject

//----创建plist文件--
+(void)createPlist:(NSString *)nameStr;
// ------取出用药提醒----
+(NSArray *)takeDurgRemind:(NSString *)filesName;

// --------//plist文件，获取其路径-------
+(NSString *)obtainFilesPath:(NSString *)name;

//---------保存plist文件-----
+(void) saveData:(NSArray *)data andFilesPath:(NSString *)filesPath;

// --------删除指定id的数据------
+(void) delDataId:(NSString *)delId andFilesPath:(NSString *)name;

// ------删除指定就医提醒ID ------
+(void) delDataJiuYiId:(NSString *)delId andFilesPath:(NSString *)name;

//-------删除plist文件
+(void)delPlistFiles:(NSString *)name;

@end
