//
//  ContentView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ContentView.h"
#define BASE_TAG 1000
@implementation ContentView
- (void)setDataList:(NSDictionary *)dataList {
    _dataList = dataList ;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    _selectedIndex = selectedIndex ;
    NSInteger fenshu = 5;
    fenshu = _selectedIndex ;
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [self viewWithTag:i + BASE_TAG ];
        if (btn) {
            [btn setImage:[UIImage imageNamed:@"星形_05.png"] forState:UIControlStateNormal];
            if (i <fenshu) {
                [btn setImage:[UIImage  imageNamed:@"星形_03.png"] forState:UIControlStateNormal];
            }
        }
    }

    
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
}

@end
