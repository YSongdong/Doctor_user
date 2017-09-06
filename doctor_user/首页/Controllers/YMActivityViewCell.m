//
//  YMActivityViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMActivityViewCell.h"

@interface YMActivityViewCell ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;//图片
@property (weak, nonatomic) IBOutlet UILabel *activityTitle;//标题
@property (weak, nonatomic) IBOutlet UILabel *activityTime;//时间
@property (weak, nonatomic) IBOutlet UILabel *activityCondition;//条件
@property (weak, nonatomic) IBOutlet UILabel *activityIntroduction;//简介
@property (weak, nonatomic) IBOutlet UIView *activityInformationView;//活动信息

@end

@implementation YMActivityViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    __weak typeof(self) weakSlef = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.height-1, SCREEN_WIDTH - 20, 5)];
        
        lineImg.image = [weakSlef drawLineByImageView:lineImg];
        // 添加到控制器的view上
        [weakSlef addSubview:lineImg];
    });
    

}


// 返回虚线image的方法
- (UIImage *)drawLineByImageView:(UIImageView *)imageView{
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 0.5是高度
    CGFloat lengths[] = {1,0.5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line,RGBCOLOR(229, 229, 229).CGColor );
    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0); //开始画线
    CGContextAddLineToPoint(line, SCREEN_WIDTH - 10, 2.0);
    
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

-(void)setModel:(YMOfficialActivityModel *)model{
    _model = model;
    [_activityImageView sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:[UIImage imageNamed:@"activityImage_icon"]];
    _activityTitle.text = _model.title;
   _activityTime.text = [NSString stringWithFormat:@"活动时间:%@-%@",_model.start_time,_model.end_time];
    _activityCondition.text = [NSString stringWithFormat:@"活动条件:%@",_model.conditions];
    _activityIntroduction.text = _model.intro;
    
}

@end
