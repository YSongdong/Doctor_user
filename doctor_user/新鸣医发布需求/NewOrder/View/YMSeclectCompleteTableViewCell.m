//
//  YMSeclectCompleteTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSeclectCompleteTableViewCell.h"

@interface YMSeclectCompleteTableViewCell ()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;//等级
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel; //金额

@property (weak, nonatomic) IBOutlet UILabel *attributeLabel;//属性
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookContractButton;//合同

@end

@implementation YMSeclectCompleteTableViewCell

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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initView{
    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _lookContractButton.layer.masksToBounds = YES;
    _lookContractButton.layer.borderWidth = 1.f;
    _lookContractButton.layer.borderColor = RGBCOLOR(251, 172, 109).CGColor;
    _lookContractButton.layer.cornerRadius = 5.f;
    [_lookContractButton setTitleColor:RGBCOLOR(252, 169, 70) forState:UIControlStateNormal];
}

- (IBAction)lookContractClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(seclectCompleteCell:lookContract:)]) {
        [self.delegate seclectCompleteCell:self lookContract:sender];
    }
}


@end
