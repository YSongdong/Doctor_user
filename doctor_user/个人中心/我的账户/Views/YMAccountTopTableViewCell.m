//
//  YMAccountTopTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAccountTopTableViewCell.h"

@interface YMAccountTopTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *view;
@end

@implementation YMAccountTopTableViewCell

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
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_offset(-10);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
