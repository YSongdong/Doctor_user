//
//  SDDatePickerView.h
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDDatePickerViewDelegate <NSObject>

-(void)selectdTimeNSDict:(NSDictionary *)dic;

@end
@interface SDDatePickerView : UIView

@property(nonatomic,weak) id <SDDatePickerViewDelegate> delegate;

@end
