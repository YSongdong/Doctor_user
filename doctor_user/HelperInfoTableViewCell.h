//
//  HelperInfoTableViewCell.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeadlthyHelperAllModel.h"

@protocol HelperInfoTableViewCellDelegate <NSObject>

-(void) selectdHealtheFilesBtnAction;

@end



@interface HelperInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)HeadlthyAllMealthModel *model;

@property(nonatomic,weak) id <HelperInfoTableViewCellDelegate> delegate;


@end
