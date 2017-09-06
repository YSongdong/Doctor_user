//
//  YMUserInfoMemberTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMUserInfoMemberTableViewCell.h"

@interface YMUserInfoMemberTableViewCell()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *IDCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@property (weak, nonatomic) IBOutlet UILabel *householdLabel;//户主

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageWidht;//箭头图标的宽度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *householdLabelWidht;//户主的宽度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageRihgtLayout;//年龄右边的距离

@property(nonatomic,assign)BOOL clickRightButton;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation YMUserInfoMemberTableViewCell

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

-(void)initView{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter

-(void)setEditStatus:(BOOL)editStatus{
    _editStatus = editStatus;
    _rightButton.hidden = !_editStatus;
}

- (IBAction)rightClick:(id)sender {
    
    if ([_model.is_default integerValue] == 1) {
        return;
    }
    
    _clickRightButton= !_clickRightButton;
    
    if (_clickRightButton) {
        _rightImageView.image = [UIImage imageNamed:@"bank_select_icon"];
    }else{
        _rightImageView.image = [UIImage imageNamed:@"bank_defaule_icon"];
    }
    
    if ([self.delegate respondsToSelector:@selector(userInfoMemberCell:model:add:)]) {
        [self.delegate userInfoMemberCell:self model:_model add:_clickRightButton];
    }
    
}

-(void)setSelectedStatus:(BOOL)selectedStatus{
    if (_editStatus) {
        
        _rightImageWidht.constant = 16;
        
        if (selectedStatus) {
            _rightImageView.image = [UIImage imageNamed:@"bank_select_icon"];
        }else{
            _rightImageView.image = [UIImage imageNamed:@"bank_defaule_icon"];
        }
    }else{
        _rightImageWidht.constant = 9;
        _rightImageView.image = [UIImage imageNamed:@"self_right_icon"];
    }
    
    _clickRightButton = selectedStatus;
    
}

-(void)setModel:(YMUserInfoMemberModel *)model{
    _model = model;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.leaguer_img] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    _IDCardLabel.text = model.leagure_idcard;
    _userNameLabel.text = model.leagure_name;
    _sexLabel.text = model.leagure_sex;
    _ageLabel.text = [NSString stringWithFormat:@"%@岁",model.leagure_age];
    _telLabel.text = model.leagure_mobile;
    if ([_model.is_default integerValue] == 1) {
        _householdLabel.hidden = NO;
    }else{
        _householdLabel.hidden = YES;
        _householdLabelWidht.constant = 0;
    }
    
    if ([_model.is_default integerValue] == 1) {
        
        _rightImageView.hidden = YES;
        return;
    }

}


@end
