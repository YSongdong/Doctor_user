//
//  SDCircumstFilesTableViewCell.h
//  doctor_user
//
//  Created by dong on 2017/8/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SDCircumstFilesTableViewCellDelegate <NSObject>

-(void)selectdSomkeAndWineBtn:(NSDictionary *)dic;

@end


@interface SDCircumstFilesTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString *smoking; //抽烟情况

@property (nonatomic,strong) NSString *drink; //喝酒情况

@property (nonatomic,weak) id <SDCircumstFilesTableViewCellDelegate> delegate;

@end
