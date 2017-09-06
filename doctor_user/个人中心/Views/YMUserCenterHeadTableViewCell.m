//
//  YMUserCenterHeadTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMUserCenterHeadTableViewCell.h"
#import "LRMacroDefinitionHeader.h"
@interface YMUserCenterHeadTableViewCell()
//需求的个数
@property (weak, nonatomic) IBOutlet UILabel *xuqiuNum;
//疑难杂症的个数
@property (weak, nonatomic) IBOutlet UILabel *yinanNum;
//挂号的个数
@property (weak, nonatomic) IBOutlet UILabel *guahaoNum;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
//用户名
//@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
//使用记录
//@property (weak, nonatomic) IBOutlet UILabel *useDetailLabel;
@property (weak, nonatomic) IBOutlet UIView *xuqiuView;

@property (weak, nonatomic) IBOutlet UIView *reportView;

@property (weak, nonatomic) IBOutlet UIView *guahaoView;

@property (weak, nonatomic) IBOutlet UIView *headerClickView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UIView *OrderView;//订单View

@end
@implementation YMUserCenterHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    LRViewBorderRadius(self.xuqiuNum, 5, 0, [UIColor clearColor]);
    LRViewBorderRadius(self.yinanNum, 5, 0, [UIColor clearColor]);
    LRViewBorderRadius(self.guahaoNum, 5, 0, [UIColor clearColor]);
    LRViewBorderRadius(self.headImageView, 37.5, 2, [UIColor whiteColor]);
    
   
    
    self.headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [self.headImageView addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(repareHeadBtnClick:)];
    {
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [self.xuqiuView addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(xuqiuBtn:)];
    }
    {
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [self.reportView addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(xuqiuBtn:)];
    }
    {
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [self.guahaoView addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(xuqiuBtn:)];
    }
    UITapGestureRecognizer *gestureR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    [self.headerClickView addGestureRecognizer:gestureR];
    
}

- (void)xuqiuBtn:(UITapGestureRecognizer *)sender {
    if (self.block) {
        self.block(NO,sender.view.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)repareHeadBtnClick:(id)sender {
    if (self.block) {
        self.block(YES,0);
    }
}

- (void)setHeadDataWith:(NSDictionary *)dic {
    if ([dic[@"demand"] isEqualToString:@"0"] || !dic[@"demand"]) {
        //需求
        self.xuqiuNum.backgroundColor = [UIColor clearColor];
    } else {
        self.xuqiuNum.backgroundColor = [UIColor redColor];
    }
    if ([dic[@"cases"] isEqualToString:@"0"] || !dic[@"cases"]) {
        //疑难杂症
        self.yinanNum.backgroundColor = [UIColor clearColor];
    } else {
        self.yinanNum.backgroundColor = [UIColor redColor];
    }
    if ([dic[@"register"] isEqualToString:@"0"] || !dic[@"register"]) {
        //挂号
        self.guahaoNum.backgroundColor = [UIColor clearColor];
    } else {
        self.guahaoNum.backgroundColor = [UIColor redColor];
    }
    self.xuqiuNum.text = @"";
    self.yinanNum.text = @"";
    self.guahaoNum.text = @"";
    NSLog(@"%@",dic);
    if (![dic[@"member_avatar"] isKindOfClass:[NSNull class]]) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"member_avatar"]] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    }
    
//    self.userNameLabel.text = dic[@"member_name"];
//    self.useDetailLabel.text = [NSString stringWithFormat:@"成交记录：%@笔  成交金额：¥%.2lf",dic[@"count"],[dic[@"sum"] doubleValue]];
}
-(void)SingleTap:(UITapGestureRecognizer*)sender{
    NSLog(@"跳转到个人详情页面");
}

@end
