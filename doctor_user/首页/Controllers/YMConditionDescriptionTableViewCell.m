//
//  YMConditionDescriptionTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMConditionDescriptionTableViewCell.h"

@interface YMConditionDescriptionTableViewCell()<UITextViewDelegate>

@property(nonatomic,strong)UITextView *inputTextView;

@property(nonatomic,strong)UILabel *placeholderLabel;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UILabel *descriptionLabel;

@end

@implementation YMConditionDescriptionTableViewCell

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

-(void)initView{
    
    _topView = [[UIView alloc]init];
    [self addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@44);
    }];
    
    _descriptionLabel = [[UILabel alloc]init];
    _descriptionLabel.text = @"病情描述:";
    _descriptionLabel.font = [UIFont systemFontOfSize:15];
    _descriptionLabel.textColor = [UIColor blackColor];
    [_topView addSubview:_descriptionLabel];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(10);
        make.top.bottom.right.equalTo(_topView);
    }];
    [_topView drawBottomLine:0 right:0];
    
    _inputTextView = [[UITextView alloc]init];

    _inputTextView.font = _descriptionLabel.font;
    _inputTextView.delegate = self;
    [self addSubview:_inputTextView];
    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_topView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    
    _placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.font = _inputTextView.font ;
    _placeholderLabel.text = @"请在此描述你的状况，活动方回根据你提供的资料进行审核（必填）";
    _placeholderLabel.numberOfLines = 0;
    _placeholderLabel.textColor = RGBCOLOR(180, 180, 180);
    [self addSubview:_placeholderLabel];
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).offset(5);
        make.left.right.equalTo(_inputTextView).offset(5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (textView.text.length >0) {
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
    if ([self.delegate respondsToSelector:@selector(conditionDescriptionCell:beginEdit:)]) {
        [self.delegate conditionDescriptionCell:self beginEdit:YES];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length >0) {
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *textStr = @"";
    if (textView.text.length== 1 && text.length ==0) {
        _placeholderLabel.hidden = NO;
    }else if(text.length == 0 && textView.text.length>1){
        textStr = [textView.text substringWithRange:NSMakeRange(0, textView.text.length-1)];
    }else{
        textStr = [NSString stringWithFormat:@"%@%@",textView.text,text];
        _placeholderLabel.hidden = YES;
    }
    if ([self.delegate respondsToSelector:@selector(conditionDescriptionCell:editContent:)]) {
        [self.delegate conditionDescriptionCell:self editContent:textStr];
    }
    return YES;
}

-(void)setTextStr:(NSString *)textStr{
    
    if (textStr.length >0) {
        _placeholderLabel.hidden = YES;
        _inputTextView.text = textStr;
    }else{
        _placeholderLabel.hidden = NO;
        
    }
}

-(void)setTitleName:(NSString *)titleName{
    _descriptionLabel.text = titleName;
}
-(void)setTipName:(NSString *)tipName{
    _placeholderLabel.text = _tipName;
}


@end
