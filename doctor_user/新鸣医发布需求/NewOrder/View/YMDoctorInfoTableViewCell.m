
//
//  YMDoctorInfoTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorInfoTableViewCell.h"

@interface YMDoctorInfoTableViewCell()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *doctorHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *doctorGradeLabel;//等级
@property (weak, nonatomic) IBOutlet UILabel *doctorServiceChargeLabel;//服务费
@property (weak, nonatomic) IBOutlet UILabel *doctorInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;//服务时间
@property (weak, nonatomic) IBOutlet UIButton *selctButton;

@end

@implementation YMDoctorInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initView{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _selctButton.layer.cornerRadius = 5;
    _selctButton.layer.borderWidth = 1;
    _selctButton.layer.borderColor = RGBCOLOR(68, 147, 244).CGColor;
    _selctButton.layer.masksToBounds = YES;
}
- (IBAction)selectClickButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(doctorInfoCell:bidModel:)]) {
        [self.delegate doctorInfoCell:self bidModel:_model];
    }
}

-(void)setModel:(YMBidListModel *)model{
    _model = model;
    [_doctorHeaderImageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    _doctorNameLabel.text = model.member_names;
    
    _doctorGradeLabel.text =model.grade_id;//等级
    _doctorServiceChargeLabel.text =model.doctor_price;//服务费
    _doctorInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.member_occupation,model.member_ks,model.member_aptitude];
    _serviceTimeLabel.text = model.service_end_time.length>0?model.service_end_time:model.service_start_time;//服务时间
    
    
}

@end
