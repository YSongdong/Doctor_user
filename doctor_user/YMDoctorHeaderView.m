//
//  YMDoctorHeaderView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/14.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorHeaderView.h"

@interface YMDoctorHeaderView()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *doctorHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *affiliatedHospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicContentLabel;

@end

@implementation YMDoctorHeaderView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self createView];
}

-(void)createView{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

@end
