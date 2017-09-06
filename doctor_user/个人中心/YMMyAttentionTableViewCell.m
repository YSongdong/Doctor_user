//
//  YMMyAttentionTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/19.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyAttentionTableViewCell.h"

@interface YMMyAttentionTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *doctorHeaderImageView;//头像

@property (weak, nonatomic) IBOutlet UILabel *doctorName;//医生名字
@property (weak, nonatomic) IBOutlet UILabel *VolumeLabel;//成交量
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;//医院
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;//等级
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;//评分
@property (weak, nonatomic) IBOutlet UILabel *DepartmentLabel;//科室

@property (weak, nonatomic) IBOutlet UILabel *CollectionLabel;//关注
@property (weak, nonatomic) IBOutlet UILabel *AttendingDoctorLabe;//主治医生

@property (weak, nonatomic) IBOutlet UILabel *BrowseLabel;//浏览量
@property (weak, nonatomic) IBOutlet UIButton *medicalCareBtn; //免费问诊

- (IBAction)medicalCareBtnClick:(UIButton *)sender;



@end

@implementation YMMyAttentionTableViewCell

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
}
-(void)setIsStar:(BOOL)isStar
{
    _isStar = isStar;
    if (self.isStar) {
        [self.medicalCareBtn setTitle:@"联系医生" forState:UIControlStateNormal];
    }
}

-(void)initView{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    self.medicalCareBtn.layer.cornerRadius = CGRectGetHeight(self.medicalCareBtn.frame)/2;
    self.medicalCareBtn.layer.masksToBounds = YES;
    self.medicalCareBtn.backgroundColor = [UIColor btnBlueColor];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YMMyAttentionModel *)model{
    _model = model;
    [_doctorHeaderImageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    
    _doctorName.text = model.member_names;//医生名字
    _VolumeLabel.text = [NSString stringWithFormat:@"%@笔/成交量",model.store_sales];//成交量
    _hospitalLabel.text = model.member_occupation;//医院
    _gradeLabel.text = [NSString stringWithFormat:@"LV%@",model.grade_id];//等级
    _scoreLabel.text = model.avg_score;//评分
    _DepartmentLabel.text = model.member_ks;//科室
    
    _CollectionLabel.text =[NSString stringWithFormat:@"%@人/关注",model.follow_num];//收藏
    _AttendingDoctorLabe.text = model.member_aptitude;//主治医生
    
    _BrowseLabel.text = [NSString stringWithFormat:@"%@人/浏览",model.stoer_browse];
}

-(void)setDoctorModel:(YMDoctorLibaryModel *)doctorModel{
    _doctorModel = doctorModel;
    [_doctorHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_doctorModel.store_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    
    _doctorName.text = doctorModel.member_names;//医生名字
    _VolumeLabel.text = [NSString stringWithFormat:@"%@笔/成交量",doctorModel.goods_volume];//成交量
    _hospitalLabel.text = doctorModel.member_occupation;//医院
    _gradeLabel.text = [NSString stringWithFormat:@"LV%@",doctorModel.grade_id];//等级
    _scoreLabel.text = doctorModel.avg_score;//评分
    _DepartmentLabel.text = doctorModel.member_ks;//科室
    
    _CollectionLabel.text =[NSString stringWithFormat:@"%@人/收藏",doctorModel.store_collect];//收藏
    _AttendingDoctorLabe.text = doctorModel.member_aptitude;//主治医生
    
    _BrowseLabel.text = [NSString stringWithFormat:@"%@人/浏览",doctorModel.stoer_browse];
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{

    _indexPath = indexPath;
}

- (IBAction)medicalCareBtnClick:(UIButton *)sender {
    
    if ([self.delegate  respondsToSelector:@selector(doctorLibaryMedicalCareBtn:)]) {
        [self.delegate doctorLibaryMedicalCareBtn:self.indexPath];
    }
    
}
@end
