//
//  SDDoctorGroupTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol SDDoctorGroupTableViewCellDelegate <NSObject>

-(void)selectdDownBtnIndexPath:(NSIndexPath *)indexPath;

@end


@interface SDDoctorGroupTableViewCell : UITableViewCell

@property(nonatomic,strong) NSString *classType;

@property(nonatomic,strong) NSIndexPath *indexPath;

@property(nonatomic,weak) id <SDDoctorGroupTableViewCellDelegate> delegate;

@property (nonatomic,assign) BOOL isOpen;

-(void)setdictManageType:(NSString *)type andIndexPath:(NSIndexPath *)indexPath andWithDict:(NSDictionary *)dict;

@end
