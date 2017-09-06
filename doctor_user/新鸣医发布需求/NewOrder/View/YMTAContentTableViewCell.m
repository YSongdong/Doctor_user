//
//  YMTAContentView.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMTAContentTableViewCell.h"

@interface YMTAContentTableViewCell ()

@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)UILabel *timeLabel;

@end

@implementation YMTAContentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

-(void)initView{
    
    _timeLabel = [[UILabel alloc]init];
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.textColor = RGBCOLOR(130, 130, 130);
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    _textView = [[UITextView alloc]init];
    _textView.textColor = RGBCOLOR(130, 130, 130);
    _textView.font = [UIFont systemFontOfSize:15];
    [_textView setEditable:NO];
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(_timeLabel.mas_top).offset(-5);
    }];
}


-(void)setModel:(YMCheckPingModel *)model{
    _model = model;
    _textView.text = model.doctor_ping;
    
}

@end
