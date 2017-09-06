//
//  YMAppointmentTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAppointmentTableViewCell.h"

@interface YMAppointmentTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *startTimeLabel;
@property(nonatomic,strong)UILabel *endTimeLabel;
@property(nonatomic,strong)UILabel *tipLabel;

@end

@implementation YMAppointmentTableViewCell

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
    _titleLabel.text = @"时间约定:";
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
    }];
    _startTimeLabel = [[UILabel alloc]init];
    _startTimeLabel.text = @"2016年 10月 21日 16:30";
    _startTimeLabel.font = [UIFont systemFontOfSize:17];
    _startTimeLabel.textColor = RGBCOLOR(51, 51, 51);
    _startTimeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_startTimeLabel];
    [_startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(_titleLabel.mas_top);
        make.left.equalTo(_titleLabel.mas_right);
    }];
    
    _endTimeLabel = [[UILabel alloc]init];
    _endTimeLabel = [[UILabel alloc]init];
    _endTimeLabel.text = @"2016年 10月 21日 16:30";
    _endTimeLabel.font = [UIFont systemFontOfSize:17];
    _endTimeLabel.textColor = RGBCOLOR(51, 51, 51);
    _endTimeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_endTimeLabel];
    [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_startTimeLabel.mas_right);
        make.top.equalTo(_startTimeLabel.mas_bottom).offset(5);
        make.left.equalTo(_titleLabel.mas_right);
    }];
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.text = @"请在该时段到医院就诊";
    _tipLabel.font = [UIFont systemFontOfSize:13];
    _tipLabel.textColor = RGBCOLOR(130, 130, 130);
    _tipLabel.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endTimeLabel.mas_bottom).offset(5);
        make.left.equalTo(_titleLabel.mas_right);
        make.right.equalTo(_endTimeLabel.mas_right);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YMUserContractPageModel *)model{
    _model = model;
    if ([NSString isEmpty:_model.service_start_time ]) {
        _startTimeLabel.hidden = YES;
        [_endTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_top);
        }];
    }else{
        _startTimeLabel.hidden = NO;
        [_endTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_startTimeLabel.mas_bottom).offset(5);
        }];
    }
    _startTimeLabel.text = _model.service_start_time;
    _endTimeLabel.text = _model.service_end_time;
}

//-(void)setTimeStr:(NSString *)timeStr{
//    _timeLabel.text = timeStr;
//}

@end
