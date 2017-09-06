//
//  YMSeekingConsultationDoctorInofTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSeekingConsultationDoctorInofTableViewCell.h"

#import "KTRLabelView.h"

@interface YMSeekingConsultationDoctorInofTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *userInfoView;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *doctorHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *doctorGradeLabel;//等级
@property (weak, nonatomic) IBOutlet UILabel *doctorServiceChargeLabel;//服务费
@property (weak, nonatomic) IBOutlet UILabel *doctorInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;//服务时间
@property (weak, nonatomic) IBOutlet UIButton *selctButton;
@property (weak, nonatomic) IBOutlet KTRLabelView *TipView;

@property(nonatomic,strong)NSMutableDictionary *importantDic;
@property(nonatomic,strong)NSMutableArray *data;

@property (weak, nonatomic) IBOutlet UILabel *showRemindLabel; //显示注意提醒




@end

@implementation YMSeekingConsultationDoctorInofTableViewCell



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

-(void)initView{
    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _doctorInfoLabel.adjustsFontSizeToFitWidth = YES;
    _serviceTimeLabel.adjustsFontSizeToFitWidth = YES;
    _selctButton.layer.masksToBounds = YES;
    _selctButton.layer.cornerRadius = 3;
    _selctButton.layer.borderWidth = 1;
    _selctButton.layer.borderColor = RGBCOLOR(252, 153, 15).CGColor;
    [_selctButton setTitleColor:RGBCOLOR(252, 152, 15) forState:UIControlStateNormal];
    [_userInfoView drawBottomLine:10 right:10];
    _doctorHeaderImageView.layer.masksToBounds = YES;
    _doctorHeaderImageView.layer.cornerRadius = 30;
    [self initTipView];
}

-(void)initTipView{
    _importantDic = [NSMutableDictionary dictionary];
    [_importantDic setObject:@15 forKey:@"labelFontSize"];
    [_importantDic setObject:[NSString stringWithFormat:@"%f",SCREEN_WIDTH - 80] forKey:@"labelViewWidth"];
    [_importantDic setObject:@"29" forKey:@"labelHeight"];
    [_importantDic setObject:@0 forKey:@"buttonEnable"];
    [_importantDic setObject:@0 forKey:@"borderWidth"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YMDoctorOrderProcessModel *)model{
    _model = model;
    UIImage *image = [UIImage imageNamed:@"dingdan_Tip_icon"];
   NSMutableArray * tipShowArry = [NSMutableArray array];
    for (NSString *str in model.tips) {
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionary];
        [imageDic setObject:image forKey:@"image_n"];
        [imageDic setObject:str forKey:@"text"];
        [tipShowArry addObject:imageDic];
    }
    _TipView.labelProperty = _importantDic;
    _TipView.labelData = tipShowArry;
    
    
    [_doctorHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    _doctorNameLabel.text = _model.member_names;
    
    _doctorGradeLabel.text = model.grade_id;//等级
    _doctorServiceChargeLabel.text = model.money;//服务费
    _doctorInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.member_occupation,model.member_ks,model.member_aptitude];
    _serviceTimeLabel.text =[NSString stringWithFormat:@"服务时间:%@", model.service_end_time.length>0?model.service_end_time:model.service_start_time];//服务时
    
    //是否显示扣除30%提醒
    if ([model.demand_type integerValue] != 1) {
        self.showRemindLabel.hidden = YES;
    }
    
    
}

+(CGFloat)heightForTips:(NSArray *)tips{
    if (tips.count == 0) {
        return 170;
    }
    UIImage *image = [UIImage imageNamed:@"dingdan_Tip_icon"];
    NSMutableArray * tipShowArry = [NSMutableArray array];
    for (NSString *str in tips) {
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionary];
        [imageDic setObject:image forKey:@"image_n"];
        [imageDic setObject:str forKey:@"text"];
        [tipShowArry addObject:imageDic];
    }
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    [dic setObject:@15 forKey:@"labelFontSize"];
    [dic setObject:[NSString stringWithFormat:@"%f",SCREEN_WIDTH - 80] forKey:@"labelViewWidth"];
    [dic setObject:@"29" forKey:@"labelHeight"];
    [dic setObject:@0 forKey:@"buttonEnable"];
    [dic setObject:@0 forKey:@"borderWidth"];
    
  
    CGFloat labelHeigh = [KTRLabelView labelViewHeight:dic labelData:tipShowArry];

    return labelHeigh + 100+30;
}

-(float)getContactLabelHeight:(NSString*)contact
{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0]};
   
    // 计算文字占据的高度
    CGSize size = [contact boundingRectWithSize:self.showRemindLabel.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    return size.height;

}


- (IBAction)lookHeTongClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SeekingConsultationDoctorView:lookHetong:)]) {
        [self.delegate SeekingConsultationDoctorView:self lookHetong:sender];
    }
}

@end
