//
//  RemindTableViewCell.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeadlthyHelperAllModel.h"


@protocol RemindTableViewCellDelegate <NSObject>

//选择时间
-(void)selectdRemindTimeBtnAction:(NSIndexPath *)indexPath;
//选择科室
-(void)selectdDepBtnAction:(NSIndexPath *)indexPath;

//删除提醒
-(void)selectdDelRemindBtnAction:(NSIndexPath *)indexPath andMedicalID:(NSString *)medicaiID;

//保存提醒
-(void)selectdSaveBtnAction:(NSIndexPath *)saveIndexPath andNSDict:(NSDictionary *)dic ;


//关闭弹框
-(void)closeRmoveView;

@end


@interface RemindTableViewCell : UITableViewCell
@property (nonatomic,strong) HeadlMedicalModel *model;
@property (nonatomic,weak) id <RemindTableViewCellDelegate> delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *departmentLabel; //科室选择

@property (weak, nonatomic) IBOutlet UILabel *timeLabel; //时间

@property (nonatomic,assign) BOOL isAdd; //是否添加


@end
