//
//  DemandOrderViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

//#import "BaseViewController.h"
//#import "DemandOrderModel.h"
#import "DemandOrderViewController.h"
#import "UITableView+KREmptyData.h"

@interface DemandOrderViewController  : UIViewController


@property (nonatomic,assign)NSInteger type ;

@property (nonatomic,assign)NSInteger page ;

@property (nonatomic,assign)NSInteger selectedIndex ;

@property (nonatomic,strong)NSArray *dataList ;




- (void)setUp ;

 - (void)requestDataWithUrl;

- (void)refreshData ;

//加载
- (void)loadMoreData ;
//- (void)requestDataWithUrl:(NSString *)url ;

@end
