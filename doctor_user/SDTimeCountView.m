//
//  SDTimeCountView.m
//  doctor_user
//
//  Created by dong on 2017/8/10.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDTimeCountView.h"

@interface SDTimeCountView ()

@property(nonatomic,strong) UIButton *timeBtn;
@property(nonatomic,strong) NSArray *titleArr;
@end


@implementation SDTimeCountView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.titleArr = @[@"一日一次",@"一日二次",@"一日三次"];
    for (int i=0; i<self.titleArr.count; i++) {
        self.timeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*30, self.frame.size.width, 30)];
        [self.timeBtn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.timeBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [self addSubview:self.timeBtn];
        self.timeBtn.layer.borderWidth = 1;
        self.timeBtn.tag = 100+i;
        self.timeBtn.layer.borderColor =[UIColor colorWithHexString:@"#666666"].CGColor;
        [self.timeBtn addTarget:self action:@selector(onTimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;

}
-(void)onTimeBtnAction:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(selectdBtnTitle:andIndexPath:)]) {
        [self.delegate selectdBtnTitle:sender.titleLabel.text andIndexPath:self.indexPath];
        //移除视图
        [self removeFromSuperview];
    }
    


}



@end
