//
//  AddHistoryViewController.h
//  doctor_user
//
//  Created by dong on 2017/8/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddHistoryViewControllerDelegate <NSObject>

-(void)selectdSaveBtn:(NSDictionary *)data;

@end

@interface AddHistoryViewController : UIViewController

@property (nonatomic,strong) NSString *member_id; //	用户id
@property (nonatomic,strong) NSString *health_id;  //健康档案id

@property (nonatomic,weak) id <AddHistoryViewControllerDelegate> delegate;
@end
