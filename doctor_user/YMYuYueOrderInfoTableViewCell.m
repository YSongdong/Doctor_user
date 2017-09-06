//
//  YMYuYueOrderInfoTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMYuYueOrderInfoTableViewCell.h"

@interface YMYuYueOrderInfoTableViewCell()
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
@property (weak, nonatomic) IBOutlet UIButton *lookHeTongButton;//查看合同
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *tip2Label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TipCenter;
@property (weak, nonatomic) IBOutlet UIView *tipView;

@property (weak, nonatomic) IBOutlet UILabel *showServeLabel;



@end

@implementation YMYuYueOrderInfoTableViewCell

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
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    _lookHeTongButton.layer.masksToBounds = YES;
    _lookHeTongButton.layer.cornerRadius = 3;
    _lookHeTongButton.layer.borderWidth = 1;
    _lookHeTongButton.layer.borderColor = RGBCOLOR(252, 153, 15).CGColor;
    
    [_tipView drawTopLine:10 right:0];
    
    _tipLabel.adjustsFontSizeToFitWidth = YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YMDoctorOrderProcessModel *)model{
    _model = model;
    [_doctorHeaderImageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    
    _doctorName.text = model.member_names;//医生名字
    _VolumeLabel.text = [NSString stringWithFormat:@"%@笔/成交量",model.store_sales];//成交量
    _hospitalLabel.text = model.member_occupation;//医院
    _gradeLabel.text = [NSString stringWithFormat:@"LV%@",model.grade_id];//等级
    _scoreLabel.text = model.user_score;//评分
    _DepartmentLabel.text = model.member_ks;//科室
    
    _CollectionLabel.text =[NSString stringWithFormat:@"%@人/关注",model.follow_num];//收藏
    _AttendingDoctorLabe.text = model.member_aptitude;//主治医生
    
    _BrowseLabel.text = [NSString stringWithFormat:@"%@人/浏览",model.stoer_browse];

    _TipCenter.constant = 0;
    _tip2Label.hidden = YES;
    
    //是否显示服务为
    if ([model.yuyue_status integerValue] < 4) {
        self.showServeLabel.hidden = YES;
    }
    

    switch ([_model.yuyue_status integerValue]) {
        case 0:{
            _tipLabel.text = @"该订单尚支付酬金";
            [_lookHeTongButton setTitle:@"去支付" forState:UIControlStateNormal];
        }
            
            break;
        case 1:{
            _tipLabel.text = @"已付款，等待医生接受";
            _lookHeTongButton.hidden = YES;
            
        }
            break;
        case 2:{
            _tipLabel.text = @"医生已接受了您的预约，请签订合同";
            [_lookHeTongButton setTitle:@"签订合同" forState:UIControlStateNormal];
        }
            break;
        case 3:{
            _TipCenter.constant = -10;
            _tipLabel.text = @"医生拒绝了您的订单";
            _tipLabel.textColor = RGBCOLOR(51, 51, 51);
            _tip2Label.text = [NSString stringWithFormat:@"拒绝原因:%@",model.note];
            _tip2Label.hidden = NO;
            _lookHeTongButton.hidden = YES;
        }
            break;
        case 4:
        case 5:
        case 6:{
            _tipLabel.text = @"订单已完成";
            [_lookHeTongButton setTitle:@"查看合同" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

+(CGFloat)heightForNote:(NSString *)note{

    return [note boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height+160;
}

- (IBAction)TipButtonClick:(id)sender {
    
    switch ([_model.yuyue_status integerValue]) {
        case 0:{
            if ([self.delegate respondsToSelector:@selector(yuYueOrderView:payServerCharge:)]) {
                [self.delegate yuYueOrderView:self payServerCharge:sender];
            }
        }
            break;
        case 2:{
            if ([self.delegate respondsToSelector:@selector(yuYueOrderView:qianHeTongClick:)]) {
                [self.delegate yuYueOrderView:self qianHeTongClick:sender];
            }
        }
            break;
        case 4:
        case 5:
        case 6:{
            _tipLabel.text = @"订单已完成";
            [_lookHeTongButton setTitle:@"查看合同" forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(yuYueOrderView:lookHeTongClick:)]) {
                [self.delegate yuYueOrderView:self lookHeTongClick:sender];
            }
        }
            break;
            
        default:
            break;
    }
}



@end
