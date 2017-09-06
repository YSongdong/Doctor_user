//
//  TakeDrugTableViewCell.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeadlthyHelperAllModel.h"

@protocol TakeDrugTableViewCellDelegate <NSObject>

-(void)selectdDeleteBtn:(NSIndexPath *)delIndexPath andWarnID:(NSString *)warnID;

-(void)selectdTimeBtnAction:(NSIndexPath *)indexPath;

-(void)selectdSaveBtnAction:(NSDictionary *)dic andIndexPath:(NSIndexPath *)indexPath;

//关闭弹框
-(void)closeRmoveView;

@end


@interface TakeDrugTableViewCell : UITableViewCell

@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,weak) id <TakeDrugTableViewCellDelegate> delegate;

@property (nonatomic,strong) headlthyDetailModel *model;

@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel;  //时间次数label

@property (nonatomic,assign) BOOL isAdd; //是否添加


@end
