//
//  YMDoctorCommentTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorCommentTableViewCell.h"
#import "YMCommentHeaderView.h"

@interface YMDoctorCommentTableViewCell()

@property(nonatomic,strong)YMCommentHeaderView *commentHeaderView;

@property(nonatomic,strong)UILabel *commentLabel;

@end

@implementation YMDoctorCommentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    _commentHeaderView = [[YMCommentHeaderView alloc]init];
    _commentHeaderView.titleName = @"TA的回复";
    [self addSubview:_commentHeaderView];
    [_commentHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@44);
    }];
    _commentLabel = [[UILabel alloc]init];
    _commentLabel.font = [UIFont systemFontOfSize:15];
    _commentLabel.numberOfLines = 0;
    _commentLabel.textColor = RGBCOLOR(80, 80, 80);
    _commentLabel.text = @"暂无回复...";
    [self addSubview:_commentLabel];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentHeaderView.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YMCheckPingModel *)model{
    _model = model;
    if (![NSString isEmpty:model.doctor_hui]) {
        _commentLabel.text = model.doctor_hui;
    }
}

+(CGFloat)heightDoctorComment:(NSString *)doctorComment{
   CGFloat commentheigh = [doctorComment boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    
    return commentheigh + 54;
}

@end
