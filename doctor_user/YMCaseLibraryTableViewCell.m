//
//  YMCaseLibraryTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseLibraryTableViewCell.h"

@interface YMCaseLibraryTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation YMCaseLibraryTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter
-(void)setModel:(YMCaseLibraryModel *)model{
    _model = model;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.case_thumb] placeholderImage:[UIImage imageNamed:@"case_Infor_header"]];
    _titleLabel.text = model.case_title;
    _summaryLabel.text = model.case_desc;
    _pageviewsLabel.text = [NSString stringWithFormat:@"浏览量:%@",model.page_view];
    _timeLabel.text = _model.case_time;
}

@end
