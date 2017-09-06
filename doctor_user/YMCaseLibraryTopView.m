//
//  YMCaseLibraryTopView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseLibraryTopView.h"
#import "ListBtn.h"

static NSInteger const Button_TAG = 10000;

@interface YMCaseLibraryTopView ()

@property (nonatomic,assign)NSInteger selectedIndex;

@end

@implementation YMCaseLibraryTopView

-(id)initWithFrame:(CGRect)frame{
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
    
    UIView *lineview = [[UIView alloc]init];
    lineview.backgroundColor = RGBCOLOR(229, 229, 229);
    [self addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    NSArray *doctorCaseArry =@[@"一周内  ",@"浏览量  ",@"职称  ",@"科室  "];
    
    CGFloat single = (SCREEN_WIDTH) /(doctorCaseArry.count * 1.f);
    
    for (int i = 0; i < doctorCaseArry.count; i ++) {
        ListBtn *listBtn = [[ListBtn alloc]init];
        [listBtn setHaveListFlag:YES];
        [listBtn attributeStringWithTitle:doctorCaseArry[i]];
        listBtn.tag = Button_TAG + i ;
        [listBtn addTarget:self action:@selector(clickShowListView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:listBtn];
        
        [listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(single *i);
            make.top.equalTo(self.mas_top);
            make.width.mas_offset(single-1);
            make.bottom.equalTo(lineview.mas_top);
        }];
        if (i != doctorCaseArry.count -1) {
            UIView *verticalLineView = [[UIView alloc]init];
            verticalLineView.backgroundColor = RGBCOLOR(229, 229, 229);
            [self addSubview:verticalLineView];
            [verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(listBtn.mas_right);
                make.top.bottom.equalTo(self);
                make.width.mas_equalTo(1);
            }];
        }
    }
    
}

#pragma mark - setter

- (void)setTitle:(NSString *)title {
    
    UIView *view = self.subviews[_selectedIndex+1];
    ListBtn *btn = (ListBtn *)view ;
    [btn attributeStringWithTitle: [NSString stringWithFormat:@"%@  ",title]];
}

-(void)clickShowListView:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(caseLibraryTopView:clcikTage:)]) {
        _selectedIndex = (sender.tag-Button_TAG)*2;

        [self.delegate caseLibraryTopView:self clcikTage:_selectedIndex];
    }
}



@end
