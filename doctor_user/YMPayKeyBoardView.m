//
//  YMPlayKeyBoard.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMPayKeyBoardView.h"

@implementation YMPayKeyBoardView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(229, 229, 229);
        [self initKeyBoardNumber];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}


#pragma 键盘自定义视图
- (void)initKeyBoardNumber
{
    self.frame=CGRectMake(0, kScreenHeight-243, kScreenWidth, 170);
    int space=1;
    CGFloat width = (kScreenWidth-2)/3.f;
    CGFloat height = (self.frame.size.height-4)/4.f;
    NSInteger line = -1;
    for (int i=0; i<12; i++) {
        NSString *str=[NSString stringWithFormat:@"%d",i+1];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        
        if (i%3==0) {
            line ++;
        }
        button.frame = CGRectMake(i%3*(width+space), line*height+(line+1)*space, width, height);
        button.backgroundColor=[UIColor whiteColor];
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:24];
        [button setTitle:str forState:UIControlStateNormal];
        button.tag=i+1;
        if (i==9||i==11) {
            button.backgroundColor=RGBCOLOR(210, 215, 221);
            [button setTitle:@"" forState:UIControlStateNormal];
            if (i==11) {
                [button setImage:[UIImage imageNamed:@"key_delete_icon"] forState:UIControlStateNormal];
            }
            
        }
        if (i==10) {
            button.tag=0;
            [button setTitle:@"0" forState:UIControlStateNormal];
        }
        
        
        [button addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

#pragma 键盘点击按钮事件
- (void)keyBoardAciont:(UIButton *)sender
{
    
    UIButton* btn = (UIButton*)sender;
    
    NSInteger number = btn.tag;
    
    if (nil == _delegate) {
        NSLog(@"button tag [%ld]",(long)number);
        return;
    }
    
    if (number <= 9 && number >= 0) {
        if ([self.delegate respondsToSelector:@selector(numberKeyBoard:)]) {
            [self.delegate numberKeyBoard:number];
        }
        return;
    }
    if (12 == number) {
        if ([self.delegate respondsToSelector:@selector(clearKeyBoard)]) {
            [self.delegate clearKeyBoard];
        }
        return;
    }    
}


@end
