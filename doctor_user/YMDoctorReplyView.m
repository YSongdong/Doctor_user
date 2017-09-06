//
//  YMDoctorReplyView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorReplyView.h"

@interface YMDoctorReplyView()

@property(nonatomic,strong)UILabel *userNameLabel;//用户名字
@property(nonatomic,strong)UILabel *doctorContentLabel;//用户回复内容

@end

@implementation YMDoctorReplyView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)createView{
    _userNameLabel = [[UILabel alloc]init];
//    _userNameLabel.text = 
}


@end
