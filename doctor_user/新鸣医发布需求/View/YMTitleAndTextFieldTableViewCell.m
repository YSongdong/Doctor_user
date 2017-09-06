//
//  YMTitleAndTextFieldTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMTitleAndTextFieldTableViewCell.h"

@interface YMTitleAndTextFieldTableViewCell ()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UITextField *subTextField;

@end

@implementation YMTitleAndTextFieldTableViewCell

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
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = RGBCOLOR(80, 80, 80);
    _titleLabel.text = @"真实姓名";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(_titleLabel.intrinsicContentSize.width+10);
    }];
    
    _subTextField = [[UITextField alloc]init];
    _subTextField.backgroundColor = [UIColor clearColor];
    _subTextField.font = [UIFont systemFontOfSize:13];
    _subTextField.textColor = RGBCOLOR(130, 130, 130);
    _subTextField.delegate = self;
    
    _subTextField.returnKeyType = UIReturnKeyDone;
    
//    [_subTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventValueChanged];
    _subTextField.textAlignment = NSTextAlignmentRight;
    [self addSubview:_subTextField];
    [_subTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *textStr = @"";
    
    if (textField.text.length== 1 && string.length ==0) {
        
    }else if(string.length == 0 && textField.text.length>0 ){
        textStr = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }else{
        textStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_subTextField resignFirstResponder];
    return YES;

}
//结束编辑状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(TitleAndTextFieldCell:textField:)]) {
        NSLog(@"textField ==%@",textField.text);
        [self.delegate TitleAndTextFieldCell:self textField:textField.text];
    }
    
    
}

-(void)setTitleName:(NSString *)titleName{
    _titleLabel.text = titleName;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _subTextField.placeholder = placeholder;
}

-(void)setSubTitleName:(NSString *)subTitleName{
    _subTextField.text = subTitleName;
}

//textfeild 失去焦点
-(void)cancelTextFieldKeyB
{

    [_subTextField resignFirstResponder];

}


@end
