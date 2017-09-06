//
//  YMImportantReminderTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMImportantReminderTableViewCell.h"
#import "KTRLabelView.h"

@interface YMImportantReminderTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)KTRLabelView *labelView;

@property(nonatomic,strong)NSMutableDictionary *importantDic;

@property(nonatomic,strong)NSMutableArray * TipShowArry;

@end

@implementation YMImportantReminderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initVar];
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
    // Initialization code
}

-(void)initVar{
    _importantDic = [NSMutableDictionary dictionary];
}

-(void)initView{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"重要提醒:";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.width.mas_equalTo(_titleLabel.intrinsicContentSize.width+10);
    }];
    
    _importantDic = [NSMutableDictionary dictionary];

    [_importantDic setObject:@15 forKey:@"labelFontSize"];
    [_importantDic setObject:[NSString stringWithFormat:@"%f",SCREEN_WIDTH - _titleLabel.intrinsicContentSize.width-30] forKey:@"labelViewWidth"];
    [_importantDic setObject:@"29" forKey:@"labelHeight"];
    [_importantDic setObject:@0 forKey:@"buttonEnable"];
    [_importantDic setObject:@0 forKey:@"borderWidth"];
//    UIImage *image = [UIImage imageNamed:@"dingdan_Tip_icon"];
//    _data = [NSMutableArray array];
//    NSMutableDictionary *imageDic = [NSMutableDictionary dictionary];
//    [imageDic setObject:image forKey:@"image_n"];
//    [imageDic setObject:@"带身份证" forKey:@"text"];
//    [_data addObject:imageDic];
    
    _labelView = [[KTRLabelView alloc]init];
    [self addSubview:_labelView];
    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
        
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTipsArry:(NSArray *)tipsArry{
    UIImage *image = [UIImage imageNamed:@"dingdan_Tip_icon"];
    _TipShowArry = [NSMutableArray array];
    for (NSString *str in tipsArry) {
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionary];
        [imageDic setObject:image forKey:@"image_n"];
        [imageDic setObject:str forKey:@"text"];
        [_TipShowArry addObject:imageDic];
    }
    _labelView.labelProperty = _importantDic;
    _labelView.labelData = _TipShowArry;
}
+(CGFloat)heightForTipsArry:(NSArray *)tipsArry{
    UIImage *image = [UIImage imageNamed:@"dingdan_Tip_icon"];
    NSMutableArray *TipShowArry = [NSMutableArray array];
    for (NSString *str in tipsArry) {
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionary];
        [imageDic setObject:image forKey:@"image_n"];
        [imageDic setObject:str forKey:@"text"];
        [TipShowArry addObject:imageDic];
    }
    
    UILabel  *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"重要提醒:";
    NSMutableDictionary *importantDic = [NSMutableDictionary dictionary];
    [importantDic setObject:@15 forKey:@"labelFontSize"];
    [importantDic setObject:[NSString stringWithFormat:@"%f",SCREEN_WIDTH - titleLabel.intrinsicContentSize.width-30] forKey:@"labelViewWidth"];
    [importantDic setObject:@"29" forKey:@"labelHeight"];
    [importantDic setObject:@1 forKey:@"buttonEnable"];
    return  [KTRLabelView labelViewHeight:importantDic labelData:TipShowArry];
}

@end
