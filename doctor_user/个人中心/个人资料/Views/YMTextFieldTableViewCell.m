//
//  YMTextFieldTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMTextFieldTableViewCell.h"

@interface YMTextFieldTableViewCell()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITextField *inputTextField;

@property(nonatomic,strong)UILabel *subTitlel;
@property(nonatomic,strong)UIImageView *rightArrowImageView;

@end

@implementation YMTextFieldTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
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
    _titleLabel = [[UILabel alloc]init];
//    _titleLabel.text = @"真实姓名:";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.equalTo(self);
//        make.width.mas_equalTo([_titleLabel intrinsicContentSize].width+10);
    }];
    
    _inputTextField = [[UITextField alloc]init];
    _inputTextField.delegate = self;
    _inputTextField.textAlignment = NSTextAlignmentRight;
    _inputTextField.font =_titleLabel.font;
    [_inputTextField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_inputTextField];
    [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
        make.left.equalTo(_titleLabel.mas_right).offset(10);
    }];
    
    
    _rightArrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"self_right_icon"]];
    [self addSubview:_rightArrowImageView];
    [_rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_offset(17);
    }];
    
    _subTitlel = [[UILabel alloc]init];
    _subTitlel.textAlignment = NSTextAlignmentRight;
    _subTitlel.font = _inputTextField.font;
    _subTitlel.text = @"请选择";
    [self addSubview:_subTitlel];
    [_subTitlel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightArrowImageView.mas_left).offset(-10);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo([_subTitlel intrinsicContentSize].width +10);
    }];
}

-(void)setShowTextfield:(BOOL)showTextfield{
    _showTextfield = showTextfield;
    if (_showTextfield) {
        _subTitlel.hidden = YES;
        _rightArrowImageView.hidden = YES;
        _inputTextField.hidden = NO;
    }else{
        _subTitlel.hidden = NO;
        _rightArrowImageView.hidden = NO;
        _inputTextField.hidden = YES;
    }
}

-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    _titleLabel.text = titleName;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo([_titleLabel intrinsicContentSize].width+10);
    }];
}

-(void)setSubTitleName:(NSString *)subTitleName{
    _subTitleName = subTitleName;
    _subTitlel.text = subTitleName;
    [_subTitlel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_subTitlel intrinsicContentSize].width+10);
    }];
}

-(void)setInputTextFieldName:(NSString *)inputTextFieldName{
    _inputTextFieldName = inputTextFieldName;
    _inputTextField.text = inputTextFieldName;
}

-(void)setTextFieldPlaceholder:(NSString *)textFieldPlaceholder{
    _inputTextField.placeholder = textFieldPlaceholder;
}

#pragma mark textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldCell:startEdit:)]) {
        [self.delegate textFieldCell:self startEdit:YES];
    }
    return YES;
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
//    if ([self.delegate respondsToSelector:@selector(textFieldCell:startEdit:)]) {
//        [self.delegate textFieldCell:self startEdit:NO];
//    }
    return YES;
}

-(void)setTextFieldTag:(NSInteger)textFieldTag{
    _inputTextField.tag = textFieldTag;
}

- (void)textFieldWithText:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldCell:inputChange:)]) {
        [self.delegate textFieldCell:_inputTextField inputChange:textField.text];
    }
}




@end
