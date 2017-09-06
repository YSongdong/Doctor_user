//
//  YMMyContentTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyContentTableViewCell.h"
#import "YMLabelButtonView.h"

@interface YMMyContentTableViewCell ()

@property(nonatomic,strong)YMLabelButtonView *labeButtonView;

@property(nonatomic,strong)UIView *serverGevalView;//评分视图

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,assign)NSInteger praiseNumber;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *commentLabel;

@end

@implementation YMMyContentTableViewCell

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initView{
    [self initLabeButtonView];
    [self initBottomView];
    _commentLabel = [[UILabel alloc]init];
    _commentLabel.font = [UIFont systemFontOfSize:15];
    _commentLabel.textColor = RGBCOLOR(80, 80, 80);
    _commentLabel.numberOfLines = 0;
    [self addSubview:_commentLabel];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(_labeButtonView.mas_bottom).offset(5);
        make.bottom.equalTo(_bottomView.mas_top).offset(-5);
    }];
}

-(void)initLabeButtonView{
    _labeButtonView = [[YMLabelButtonView alloc]init];
    _labeButtonView.type = LabelShowViewType;
    _labeButtonView.width = SCREEN_WIDTH;
    [self addSubview:_labeButtonView];
    [_labeButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.right.equalTo(self);
    }];
}

-(void)initBottomView{
    _bottomView = [[UIView alloc]init];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = RGBCOLOR(130, 130, 130);
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.mas_right).offset(-10);
        make.top.bottom.equalTo(_bottomView);
    }];
}

-(void)setModel:(YMCheckPingModel *)model{
    _model = model ;
    
    NSMutableArray *selectTagArry = [NSMutableArray array];
    for (NSInteger i= 0; i<model.user_ping.count; i++) {
        [selectTagArry addObject:@(i)];
    }
    _labeButtonView.selectTagArry = selectTagArry;
    _labeButtonView.labelArry = model.user_ping;
    
    [_labeButtonView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([YMLabelButtonView labelButtonHeight:model.user_ping selfWidth:SCREEN_WIDTH labelViewType:LabelShowViewType]);
    }];
    self.praiseNumber = [model.user_score integerValue];
    self.timeLabel.text = model.user_ping_time;
    self.commentLabel.text = model.user_hui;
}


-(void)setPraiseNumber:(NSInteger)praiseNumber{
    UIImage *highlightImage = [UIImage imageNamed:@"ct_start"];
    for (NSInteger i = 0; i<5 ; i++) {
        UIImageView *starImageView = [[UIImageView alloc]init];
        if (praiseNumber > i) {
            starImageView.image = highlightImage;
        }else{
            starImageView.image = [UIImage imageNamed:@"start_gray"];
        }
        [_bottomView addSubview:starImageView];
        [starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            if (i==0) {
//                make.left.equalTo(_bottomView.mas_left).offset(10);
//            }else{
                make.left.mas_equalTo((highlightImage.size.width) *i+(i+1)*10);
//            }
            make.centerY.equalTo(_bottomView.mas_centerY);
            make.height.mas_equalTo(highlightImage.size.height);
            make.width.mas_equalTo(highlightImage.size.width);
        }];
    }
}


+(CGFloat)heightForContent:(NSString *)content forLabelAyy:(NSArray *)labelArry{
    CGFloat explainHeight = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    CGFloat labelBottonHeight= [YMLabelButtonView labelButtonHeight:labelArry  selfWidth:SCREEN_WIDTH labelViewType:LabelShowViewType];
    
    return explainHeight + labelBottonHeight +70;
}

@end
