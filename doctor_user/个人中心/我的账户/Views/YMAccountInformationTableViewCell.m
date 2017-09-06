//
//  YMAccountInformationTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAccountInformationTableViewCell.h"

@interface YMAccountInformationTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *yearAndMonthLabel;//年月日

@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;//时间
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;//医生名字
@property (weak, nonatomic) IBOutlet UILabel *sickNameLabel;//病名
@property (weak, nonatomic) IBOutlet UILabel *costLabel;//费用

@end

@implementation YMAccountInformationTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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

-(void)setModel:(YMBillRecordModel *)model{
    _model = model;
    _yearAndMonthLabel.text = model.yearAndMonthAndDay;
    _TimeLabel.text = model.time;
    _doctorNameLabel.text = _model.member_names;
    _sickNameLabel.text = model.yearAndMonthAndDay;
    _TimeLabel.text = model.time;
    _sickNameLabel.text = model.demand_sketch;
    
    _costLabel.text = model.order_amount;
    
    if([model.order_amount rangeOfString:@"-"].location !=NSNotFound){
        NSLog(@"yes");
        _costLabel.textColor = RGBCOLOR(54, 128, 223);
    }
    else{
        _costLabel.textColor = RGBCOLOR(255, 171, 58);
    }
}

@end

