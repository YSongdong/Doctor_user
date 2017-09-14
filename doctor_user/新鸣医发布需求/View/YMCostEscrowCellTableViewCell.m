//
//  YMCostEscrowCellTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCostEscrowCellTableViewCell.h"

@interface YMCostEscrowCellTableViewCell()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *tipLabel;

@end

@implementation YMCostEscrowCellTableViewCell

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
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = RGBCOLOR(80, 80, 80);
    _titleLabel.text = @"服务费";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        
        make.width.mas_equalTo(_titleLabel.intrinsicContentSize.width+10);
    }];
    UILabel *symbolTip = [[UILabel alloc]init];
    symbolTip.font = [UIFont systemFontOfSize:17];
    symbolTip.textColor = RGBCOLOR(80, 80, 80);
    symbolTip.text = @"¥";
    [self addSubview:symbolTip];
    [symbolTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(_titleLabel);
        make.width.mas_equalTo(symbolTip.intrinsicContentSize.width);
    }];
    
    _subTextField = [[UITextField alloc]init];
    _subTextField.delegate = self;
    _subTextField.font = [UIFont systemFontOfSize:13];
    _subTextField.textColor = RGBCOLOR(80, 80, 80);
  //  _subTextField.placeholder = @"请输入服务费用";
    _subTextField.enabled = NO;
    [self addSubview:_subTextField];
    _subTextField.textAlignment = NSTextAlignmentRight;
    [_subTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(10);
        make.right.equalTo(symbolTip.mas_left).offset(-10);
        make.top.equalTo(self.mas_top).offset(3);
        make.height.equalTo(@25);
    }];
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.font = [UIFont systemFontOfSize:11];
    _tipLabel.textColor = RGBCOLOR(80, 80, 80);
    _tipLabel.text = @"预付服务费，购买失败将退回个人账户";
    [self addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_subTextField.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *textStr = @"";
    if (textField.text.length== 1 && string.length ==0) {
        
    }else if(string.length == 0 &&textField.text.length >0){
        textStr = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }else{
        textStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
    }
    if ([self.delegate respondsToSelector:@selector(constEscrowCell:textField:)]) {
        [self.delegate constEscrowCell:self textField:textStr];
    }
    return YES;
}


-(void)setSubText:(NSString *)subText{
    _subTextField.text = subText;
}

-(void)setMinimumAmount:(NSString *)minimumAmount{
    _subTextField.placeholder = [NSString stringWithFormat:@"不得少于%@",minimumAmount];
}

-(void)setTitleName:(NSString *)titleName{
    _titleLabel.text = titleName;
}

@end
