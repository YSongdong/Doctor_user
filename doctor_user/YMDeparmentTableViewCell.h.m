//
//  YMDeparmentTableViewCell.h.m
//  ShuangHe
//
//  Created by ¥ on 2016/10/16.
//  Copyright © 2016年 CoderDX. All rights reserved.
//

#import "YMDeparmentTableViewCell.h"

@interface YMDeparmentTableViewCell()

@property (nonatomic,strong)UILabel *productNameLabel;

@property (nonatomic,strong)UIView *lineView;

@end

@implementation YMDeparmentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
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
    _productNameLabel = [[UILabel alloc]init];
    _productNameLabel.backgroundColor = [UIColor clearColor];
    _productNameLabel.textAlignment = NSTextAlignmentCenter;
    _productNameLabel.font = [UIFont systemFontOfSize:15];
    _productNameLabel.textColor = [UIColor blackColor];
    [self addSubview:_productNameLabel];
    [_productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = RGBCOLOR(229, 229, 229);
    _lineView.hidden = YES;
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-3);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.mas_bottom);
    }];
}


-(void)setRightCell:(BOOL)rightCell{
    _rightCell = rightCell;
    if (rightCell) {
        _lineView.hidden = NO;
    }
}

-(void)setProductName:(NSString *)productName{
    _productNameLabel.text = productName;
}

//-(void)setModel:(SHCommodityInformationModel *)model{
//    _model = model;
//    _productNameLabel.text = model.name;
//}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor =[UIColor whiteColor];
    }
}

@end
