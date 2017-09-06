//
//  SelectedView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//


#define LINE_WIDTH 1
#define LIST_COUNT 4
#define Button_TAG 1000
#import "SelectedView.h"
#import "ListBtn.h"

@interface SelectedView ()

@property (nonatomic,assign)NSMutableArray *btnLists ;


@end

@implementation SelectedView

- (void)awakeFromNib{
    
    [super awakeFromNib];
  
    [self addSubView];
}



- (void)layoutSubviews {
    

    int index  = 0 ;
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[ListBtn class]]) {
            ListBtn *listBtn = (ListBtn *)view;
            CGFloat width = (self.frame.size.width - (LIST_COUNT - LINE_WIDTH))/ LIST_COUNT ;
            CGFloat x = index * (width + LINE_WIDTH);
            listBtn.frame = CGRectMake(x, 0, width, self.bounds.size.height);
        [listBtn layoutSubviews];
            index ++ ;
        }
    }
}
- (void)addSubView {
    NSArray *titles =@[@"综合  ",@"医院  ",@"科室  ",@"职称  "];
    for (int i = 0; i < 4; i ++) {
        ListBtn *listBtn = [[ListBtn alloc]init];
        [listBtn setHaveListFlag:YES];
      [listBtn attributeStringWithTitle:titles[i]];
        listBtn.tag = Button_TAG + i ;
        [listBtn addTarget:self action:@selector(clickShowListView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:listBtn];
    }
}

- (void)setTitle:(NSString *)title {
    
    UIView *view = self.subviews[_selectedIndex];
    ListBtn *btn = (ListBtn *)view ;
    [btn attributeStringWithTitle: [NSString stringWithFormat:@"%@  ",title]];
}

- (void)setDefaultTitle{
    
    ListBtn *btn1 = self.subviews[1];
    ListBtn *btn2 = self.subviews[2];
    ListBtn *btn3 = self.subviews[3];
    [btn1 attributeStringWithTitle:@"区域"];
    [btn2 attributeStringWithTitle:@"科室"];
    [btn3 attributeStringWithTitle:@"职称"];
}
//lick event
- (void)clickShowListView:(UIButton *)sender {

    _selectedIndex = sender.tag - Button_TAG ;
    self.block(_selectedIndex);
}

@end
