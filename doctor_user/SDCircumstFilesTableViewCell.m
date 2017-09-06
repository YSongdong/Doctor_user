//
//  SDCircumstFilesTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/8/11.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDCircumstFilesTableViewCell.h"

@interface SDCircumstFilesTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *somkeCircumLabel;//抽烟情况

@property (weak, nonatomic) IBOutlet UILabel *drinkWineLabel;//喝酒情况

@property (nonatomic,strong) UIButton *somkeBtn;
@property (nonatomic,assign) NSInteger somkeTag; //记录上次选中tag
@property (nonatomic,strong) UIButton *wineBtn;
@property (nonatomic,assign) NSInteger wineTag; //记录喝酒选中tag

@property (nonatomic,strong) NSMutableDictionary *param; //记录选中btn

@end


@implementation SDCircumstFilesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createView];
}
-(void)createView{

    NSArray *somkeArr = @[@"不抽",@"少抽",@"很厉害",@"老烟民"];
    NSArray *wineArr = @[@"不喝",@"少喝",@"很厉害",@"老酒罐"];
    for (int i=0; i<somkeArr.count; i++) {
        //抽烟情况
        self.somkeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+i*70+i*10, CGRectGetMaxY(self.somkeCircumLabel.frame)+10, 70, 30)];
        [self addSubview:self.somkeBtn];
        [self.somkeBtn setTitle:somkeArr[i] forState:UIControlStateNormal];
        self.somkeBtn.titleLabel.font  = [UIFont systemFontOfSize:14];
        [self.somkeBtn setTitleColor:[UIColor btnText666Color] forState:UIControlStateNormal];
        [self.somkeBtn setTitleColor:[UIColor textWiterColor] forState:UIControlStateSelected];
        self.somkeBtn.layer.borderWidth = 1;
        self.somkeBtn.layer.borderColor = [UIColor btnLayer999Color].CGColor;
        self.somkeBtn.layer.cornerRadius = 15;
        self.somkeBtn.layer.masksToBounds = YES;
        self.somkeBtn.tag = 100+i;
        [self.somkeBtn addTarget:self action:@selector(onSomkeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        //喝酒情况
        self.wineBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+i*70+i*10, CGRectGetMaxY(self.drinkWineLabel.frame)+10, 70, 30)];
        [self addSubview:self.wineBtn];
        [self.wineBtn setTitle:wineArr[i] forState:UIControlStateNormal];
        self.wineBtn.titleLabel.font  = [UIFont systemFontOfSize:14];
        [self.wineBtn setTitleColor:[UIColor btnText666Color] forState:UIControlStateNormal];
        [self.wineBtn setTitleColor:[UIColor textWiterColor] forState:UIControlStateSelected];
        self.wineBtn.layer.borderWidth = 1;
        self.wineBtn.layer.borderColor = [UIColor btnLayer999Color].CGColor;
        self.wineBtn.layer.cornerRadius = 15;
        self.wineBtn.layer.masksToBounds = YES;
        self.wineBtn.tag = 200+i;
        [self.wineBtn addTarget:self action:@selector(onWineBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }


    
}

//抽烟情况按钮
-(void)onSomkeBtnAction:(UIButton *)sender{
    if (sender.tag == self.somkeTag) {
        return ;
    }
    //取消上次选中
    UIButton *btn = [self viewWithTag:self.somkeTag];
    btn.selected =NO;
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = [UIColor btnLayer999Color].CGColor;
    
    //设置为选中
    sender.selected = YES;
    sender.backgroundColor = [UIColor btnBroungColor];
    self.somkeTag = sender.tag;
    sender.layer.borderColor = [UIColor btnBroungColor].CGColor;
    
    self.param[@"smoking"] = [NSString stringWithFormat:@"%ld",sender.tag-100+1];
    
    if ([self.delegate respondsToSelector:@selector(selectdSomkeAndWineBtn:)]) {
        [self.delegate selectdSomkeAndWineBtn:self.param.copy];
    }
    
}
//喝酒情况按钮
-(void)onWineBtnAction:(UIButton *)sender{
    if (sender.tag == self.wineTag) {
        return ;
    }
    //取消上次选中
    UIButton *btn = [self viewWithTag:self.wineTag];
    btn.selected =NO;
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = [UIColor btnLayer999Color].CGColor;
    
    //设置为选中
    sender.selected = YES;
    sender.backgroundColor = [UIColor btnBroungColor];
    self.wineTag = sender.tag;
    sender.layer.borderColor = [UIColor btnBroungColor].CGColor;
    
    self.param[@"drink"] = [NSString stringWithFormat:@"%ld",sender.tag-200+1];
    
    if ([self.delegate respondsToSelector:@selector(selectdSomkeAndWineBtn:)]) {
        [self.delegate selectdSomkeAndWineBtn:self.param.copy];
    }
}

//抽烟
-(void)setSmoking:(NSString *)smoking{
    _smoking = smoking;
    NSInteger btnTag = [smoking integerValue]-1+100;
    UIButton *btn = [self viewWithTag:btnTag];
    btn.selected =YES;
    btn.backgroundColor = [UIColor btnBroungColor];
    self.somkeTag = btn.tag;
    btn.layer.borderColor = [UIColor btnBroungColor].CGColor;
    self.param[@"smoking"] = smoking;
}

//喝酒
-(void)setDrink:(NSString *)drink{
    _drink = drink;
    NSInteger wineTag = [drink integerValue]-1+200;
    UIButton *wBtn = [self viewWithTag:wineTag];
    wBtn.selected = YES;
    wBtn.backgroundColor =[UIColor btnBroungColor];
    self.wineTag = wBtn.tag;
    wBtn.layer.borderColor = [UIColor btnBroungColor].CGColor;
    self.param[@"drink"] = drink;
}

-(NSMutableDictionary *)param{

    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
