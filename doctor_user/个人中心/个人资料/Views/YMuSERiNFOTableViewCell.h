//
//  YMuSERiNFOTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^EDIT_INFO)(NSIndexPath *indexpath,NSString *info);
@interface YMuSERiNFOTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL canEdit;
- (void)setDetailWithIndexpath:(NSIndexPath *)indexPath andDic:(NSDictionary *)dic;
@property (nonatomic, strong) EDIT_INFO block;
@property (nonatomic, strong) NSString *vcType;
@end
