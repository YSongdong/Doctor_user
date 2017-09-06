//
//  SDHealthyManagerTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDHealthyManagerTableViewCellDelegte <NSObject>

-(void)selectdDownOrOpenBtn:(UIButton *) sender andIndexPath:(NSIndexPath *)indexPath;

@end

@interface SDHealthyManagerTableViewCell : UITableViewCell

@property(nonatomic,strong) NSString *ManagerType;
@property (nonatomic,weak) id <SDHealthyManagerTableViewCellDelegte> delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,assign) BOOL isOpen;
@end
