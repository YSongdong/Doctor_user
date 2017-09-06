//
//  TakeDrugFootView.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeadlthyHelperAllModel.h"

@protocol TakeDrugFootViewDelegate <NSObject>

-(void)selectdAddTakeDrugBtn;

-(void)selectdSaveBtnAction:(NSDictionary *)dic;

-(void)selectdSwichBtnAction:(NSString *) sound;

@end


@interface TakeDrugFootView : UIView

@property(nonatomic,weak) id<TakeDrugFootViewDelegate>delegate;


@property(nonatomic,strong) HeadlMedictionModel *model;

@property(nonatomic,assign) BOOL isSave;

@property (weak, nonatomic) IBOutlet UILabel *showPlaceLabel;


@end
