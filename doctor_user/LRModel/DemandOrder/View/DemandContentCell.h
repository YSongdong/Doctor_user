//
//  DemandContentCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemandContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ttitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic,assign)BOOL isLoadEnd ;

@property (nonatomic,strong)NSArray *images;


+ (CGFloat )getContentHeightWithContent:(NSString *)content ;


+ (CGFloat)getImageContentWithImages:(NSArray *)images
                           commplete:(void(^)(CGFloat height))commpleteBlock ;

@end
