//
//  YMSwitchView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSwitchView.h"

@implementation YMSwitchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self configerDefaultTintColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self configerDefaultTintColor];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self configerDefaultTintColor];
}

- (void)configerDefaultTintColor{
    self.onTintColor = RGBCOLOR(71, 149, 224);
}



@end
