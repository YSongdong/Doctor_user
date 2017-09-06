//
//  YMBillRecordView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMBillRecordView.h"

@interface YMBillRecordView()

@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation YMBillRecordView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

-(void)initView{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

@end
