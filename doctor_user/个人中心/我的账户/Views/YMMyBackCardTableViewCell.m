//
//  YMMyBackCardTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyBackCardTableViewCell.h"

@interface YMMyBackCardTableViewCell ()
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *carIdName;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property(nonatomic,assign)BOOL clickRightButton;

@end

@implementation YMMyBackCardTableViewCell

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
        make.edges.equalTo(@0);
    }];

    _selectImageView.hidden = YES;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}

-(void)setShowSelectButton:(BOOL)showSelectButton{
    if (showSelectButton) {
        [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(16);
        }];
        _selectImageView.hidden = NO;
        _rightButton.hidden = NO;
        _selectImageView.image = [UIImage imageNamed:@"bank_defaule_icon"];
        [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-36);
        }];
        
    }else{
        [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        _rightButton.hidden = YES;
        _selectImageView.hidden = YES;
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
        }];
    }
}

-(void)setFirstCell:(BOOL)firstCell{
    _headerView.hidden = YES;
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];

}

-(void)setBankInfoModel:(YMMyBankInfoModel *)bankInfoModel{
    _bankInfoModel = bankInfoModel;
    _bankNameLabel.text = bankInfoModel.name;
    _carIdName.text = bankInfoModel.card_num;
    _nameLabel.text = bankInfoModel.mem_name;
}

-(void)setAlipayInfoModel:(YMAlipayInfoModel *)alipayInfoModel{
    _alipayInfoModel = alipayInfoModel;
    _bankNameLabel.text = @"支付宝帐户";
    _carIdName.text = alipayInfoModel.card_num;
    _nameLabel.text = alipayInfoModel.mem_name;
}

-(void)setType:(CellType)type{
    _type = type;
}

#pragma mark - buttonClick

- (IBAction)rightClick:(id)sender {
    _clickRightButton= !_clickRightButton;
    if (_clickRightButton) {
         _selectImageView.image = [UIImage imageNamed:@"bank_select_icon"];
    }else{
         _selectImageView.image = [UIImage imageNamed:@"bank_defaule_icon"];
    }
    
    switch (_type) {
        case bankType:{
            if ([self.delegate respondsToSelector:@selector(MyBackCardViewCell:bankModel:add:)]) {
                [self.delegate MyBackCardViewCell:self bankModel:_bankInfoModel add:_clickRightButton];
            }
        }
            break;
        case alipayType:{
            if ([self.delegate respondsToSelector:@selector(MyBackCardViewCell:alipayModel:add:)]) {
                [self.delegate MyBackCardViewCell:self alipayModel:_alipayInfoModel add:_clickRightButton];
            }
        }
            break;
        default:
            break;
    }
}

@end
