//
//  DownLoadManager.h
//  test1
//
//  Created by Mia on 16/7/30.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^successBlock) (NSString *fileStorePath);
typedef void (^faileBlock) (NSError *error);
typedef void (^progressBlock) (float progress);

@interface DownLoadManager : NSObject <NSURLSessionDataDelegate>


@property (copy) successBlock  successBlock;
@property (copy) faileBlock      failedBlock;
@property (copy) progressBlock    progressBlock;


-(void)downLoadWithURL:(NSString *)URL
              progress:(progressBlock)progressBlock
               success:(successBlock)successBlock
                 faile:(faileBlock)faileBlock;

+ (instancetype)sharedInstance;

-(void)stopTask;

//判断文件是否已存在
-(BOOL) getDownFinish;

//获取沙盒中Library/Caches路径里所有的文件
-(NSArray *)setObtainFilesAll;
@end
