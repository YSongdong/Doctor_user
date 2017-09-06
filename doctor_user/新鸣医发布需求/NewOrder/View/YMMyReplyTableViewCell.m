//
//  YMMyReplyTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyReplyTableViewCell.h"
#import "YMCommentHeaderView.h"


@interface YMMyReplyTableViewCell()<UITextViewDelegate>

@property(nonatomic,strong)YMCommentHeaderView *commentHeaderView;

@property(nonatomic,strong)UITextView *replyTextView;

@property(nonatomic,strong)UILabel *tipLabel;

@property(nonatomic,strong)UIButton *submintButton;

@property(nonatomic,copy)NSString *imputComment;

@end

@implementation YMMyReplyTableViewCell

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
    _submintButton = [[UIButton alloc]init];
    _submintButton.layer.masksToBounds = YES;
    _submintButton.layer.cornerRadius = 3;
    _submintButton.layer.borderWidth = 1;
    _submintButton.layer.borderColor = RGBCOLOR(229, 229,229).CGColor;
    [_submintButton setTitle:@"提交" forState:UIControlStateNormal];
    _submintButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_submintButton setTitleColor:RGBCOLOR(80, 80,80) forState:UIControlStateNormal];
    [_submintButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_submintButton];
    
    [_submintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.height.equalTo(@28);
        make.width.mas_equalTo(_submintButton.titleLabel.intrinsicContentSize.width + 20);
    }];
    
    _commentHeaderView = [[YMCommentHeaderView alloc]init];
    _commentHeaderView.titleName = @"我的回复";
    [self addSubview:_commentHeaderView];
    [_commentHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@44);
    }];
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.font = [UIFont systemFontOfSize:15] ;
    _tipLabel.textColor = RGBCOLOR(130, 130, 130);
    _tipLabel.numberOfLines = 0;
    _tipLabel.text = @"请在此输入您的回复内容，输入完成点击“提交”按钮进行回复。";
    [self addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_commentHeaderView.mas_bottom).offset(12);
    }];
    
    
    _replyTextView = [[UITextView alloc]init];
    _replyTextView.backgroundColor = [UIColor clearColor];
    _replyTextView.delegate = self;
    _replyTextView.textColor = RGBCOLOR(130, 130, 130);
    _replyTextView.font = [UIFont systemFontOfSize:15];
    [self addSubview:_replyTextView];
    [_replyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_commentHeaderView.mas_bottom).offset(5);
        make.bottom.equalTo(_submintButton.mas_top).offset(-5);
    }];
    
    
}

-(void)submitClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(MyReplyView:commentStr:submitButton:)] ) {
        [self.delegate MyReplyView:self commentStr:_imputComment submitButton:sender];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if (textView.text.length== 1 && text.length ==0) {
        _tipLabel.hidden = NO;
    }else if(text.length == 0 && textView.text.length >1){
        _imputComment = [textView.text substringWithRange:NSMakeRange(0, textView.text.length-1)];
    }else{
        _imputComment = [NSString stringWithFormat:@"%@%@",textView.text,text];
        _tipLabel.hidden = YES;
    }

    return YES;
}

-(void)setUser_hui:(NSString *)user_hui
{
    if (![user_hui isEqualToString:@""]) {
        _tipLabel.hidden = YES;
        _replyTextView.text = user_hui;
        _submintButton.hidden = YES ; 
    }
   
}

@end
