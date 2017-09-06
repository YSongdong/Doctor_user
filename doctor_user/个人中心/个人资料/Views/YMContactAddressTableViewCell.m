//
//  YMContactAddressTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMContactAddressTableViewCell.h"

@interface YMContactAddressTableViewCell ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView *addressTextView;

@property(nonatomic,strong)UILabel *placeholderLabel;

@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation YMContactAddressTableViewCell

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
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"联系地址:";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo([_titleLabel intrinsicContentSize].width+10);
    }];
    
    _addressTextView = [[UITextView alloc]init];
    _addressTextView.textAlignment = NSTextAlignmentRight;
    _addressTextView.font = _titleLabel.font;
    _addressTextView.delegate = self;
    [self addSubview:_addressTextView];
    
    _addressTextView.returnKeyType = UIReturnKeyDone;
    
    [_addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
        make.left.equalTo(_titleLabel.mas_right).offset(10);
    }];
    
    _placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.font = _addressTextView.font;
    _placeholderLabel.numberOfLines = 0;
    _placeholderLabel.text = @"请填写您的联系地址方便联系";
    _placeholderLabel.textColor = RGBCOLOR(180, 180, 180);
    _placeholderLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_placeholderLabel];
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_addressTextView);
        make.top.equalTo(_titleLabel.mas_top);
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (textView.text.length >0) {
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length >0) {
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
    if ([self.delegate respondsToSelector:@selector(contactaddress:editContent:)]) {
        [self.delegate contactaddress:textView editContent:textView.text];
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *textStr = @"";
    if (textView.text.length== 1 && text.length ==0) {
        _placeholderLabel.hidden = NO;
    }else if(text.length == 0 &&textView.text.length>1){
        textStr = [textView.text substringWithRange:NSMakeRange(0, textView.text.length-1)];
    }else{
        textStr = [NSString stringWithFormat:@"%@%@",textView.text,text];
        _placeholderLabel.hidden = YES;
    }
  
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [_addressTextView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
       
    }
    return YES;
}
-(void)setAddressStr:(NSString *)addressStr{
    
    if (addressStr.length >0) {
        _placeholderLabel.hidden = YES;
        _addressTextView.text = addressStr;
    }else{
        _placeholderLabel.hidden = NO;
        
    }
}

-(void)setLeftAlignment:(BOOL)leftAlignment{
    if (leftAlignment) {
        _addressTextView.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    }
}

-(void)setTitleName:(NSString *)titleName{
    _titleLabel.text = titleName;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_titleLabel.intrinsicContentSize.width);
    }];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholderLabel.text = placeholder;
}

//失去焦点
-(void)cancelTextViewKeyB
{
   
    [_addressTextView resignFirstResponder];
}

@end
