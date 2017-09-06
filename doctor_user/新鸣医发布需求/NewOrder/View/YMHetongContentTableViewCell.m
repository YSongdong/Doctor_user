//
//  YMHetongContentTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHetongContentTableViewCell.h"

@interface YMHetongContentTableViewCell()

@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UILabel *PartyALabel;//甲方
@property(nonatomic,strong)UILabel *SignatureADate;//甲方日期
@property(nonatomic,strong)UIImageView *agreeAImageView;

@property(nonatomic,strong)UILabel *PartyBLabel;//乙方
@property(nonatomic,strong)UILabel *SignatureBDate;//乙方日期
@property(nonatomic,strong)UIImageView *agreeBImageView;

@property(nonatomic,strong)UILabel *remarksLabel;

@end

@implementation YMHetongContentTableViewCell

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
    UILabel *tips = [[UILabel alloc]init];
    tips.font = [UIFont systemFontOfSize:13];
    tips.textColor = RGBCOLOR(130, 130, 130);
    tips.text = @"双方责任：";
    [self addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    _contentLabel  = [[UILabel alloc]init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textColor = RGBCOLOR(130, 130, 130);
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips.mas_bottom).offset(10);
        make.left.right.equalTo(tips);
    }];
    
    
    _PartyALabel = [[UILabel alloc]init];
    _PartyALabel.font = [UIFont systemFontOfSize:13];
    _PartyALabel.textColor = RGBCOLOR(130, 130, 130);
    _PartyALabel.text = @"甲方(雇主):";
    [self addSubview:_PartyALabel];
    [_PartyALabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel.mas_left);
        make.top.equalTo(_contentLabel.mas_bottom).offset(20);
        make.width.lessThanOrEqualTo(@((SCREEN_WIDTH-20)/2.f));
    }];
    _SignatureADate = [[UILabel alloc]init];
    _SignatureADate.font = [UIFont systemFontOfSize:13];
    _SignatureADate.textColor = RGBCOLOR(130, 130, 130);
    _SignatureADate.text = @"签署日期:";
    [self addSubview:_SignatureADate];
    [_SignatureADate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel.mas_left);
        make.top.equalTo(_PartyALabel.mas_bottom).offset(5);
        make.width.lessThanOrEqualTo(@((SCREEN_WIDTH-20)/2.f));
    }];
    
    _agreeAImageView = [[UIImageView alloc]init];
    
    _agreeAImageView.image = [UIImage imageNamed:@"ic_contract_sure"];
    _agreeAImageView.backgroundColor = [UIColor clearColor];
    _agreeAImageView.hidden = YES;
    [self addSubview:_agreeAImageView];
    [_agreeAImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(5);
        make.height.width.equalTo(@60);
        make.right.equalTo(_PartyALabel.mas_right).offset(30);
    }];
    
    _PartyBLabel = [[UILabel alloc]init];
    _PartyBLabel.textAlignment = NSTextAlignmentRight;
    _PartyBLabel.font = [UIFont systemFontOfSize:13];
    _PartyBLabel.textColor = RGBCOLOR(130, 130, 130);
    _PartyBLabel.text = @"乙方(服务商):";
    [self addSubview:_PartyBLabel];
    [_PartyBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentLabel.mas_right).offset(-10);
        make.top.equalTo(_contentLabel.mas_bottom).offset(20);
        make.width.lessThanOrEqualTo(@((SCREEN_WIDTH-20)/2.f));
    }];
    _SignatureBDate = [[UILabel alloc]init];
    _SignatureBDate.textAlignment = NSTextAlignmentRight;
    _SignatureBDate.font = [UIFont systemFontOfSize:13];
    _SignatureBDate.textColor = RGBCOLOR(130, 130, 130);
    _SignatureBDate.text = @"签署日期:";
    [self addSubview:_SignatureBDate];
    [_SignatureBDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_PartyBLabel.mas_left);
        make.top.equalTo(_PartyALabel.mas_bottom).offset(5);
        make.width.lessThanOrEqualTo(@((SCREEN_WIDTH-20)/2.f));
    }];
    _agreeBImageView = [[UIImageView alloc]init];
    
    _agreeBImageView.image = [UIImage imageNamed:@"ic_contract_sure"];
    _agreeBImageView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_agreeBImageView];
    [_agreeBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentLabel.mas_right);
        make.top.equalTo(_agreeAImageView);
        make.width.height.equalTo(@60);
    }];
    
//    _remarksLabel  = [[UILabel alloc]init];
//    _remarksLabel.font = [UIFont systemFontOfSize:13];
//    _remarksLabel.textColor = RGBCOLOR(130, 130, 130);
////    _remarksLabel.text = @"签署日期:";
//    _remarksLabel.numberOfLines = 0;
//    [self addSubview:_remarksLabel];
//    [_remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(_contentLabel);
//        make.top.equalTo(_SignatureBDate.mas_bottom).offset(20);
//    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(YMUserContractPageModel *)model{
    _contentLabel.text = [YMHetongContentTableViewCell flattenHTML: model.content];
    _PartyALabel.text = [NSString stringWithFormat:@"甲方(雇主):%@",model.partA_name];
    _SignatureADate.text = [NSString stringWithFormat:@"签署日期:%@",model.partA_time];
    _PartyBLabel.text =[NSString stringWithFormat:@"乙方(服务商):%@",model.partB_name];
    _SignatureBDate.text = [NSString stringWithFormat:@"签署日期:%@",model.partB_time];
    if ([model.user_is_sign integerValue] == 1) {
        _agreeAImageView.hidden = NO;
    }else{
        _agreeAImageView.hidden = YES;
    }
    _remarksLabel.text = model.note;
}

+(CGFloat)HegithForContent:(NSString *)content forNote:(NSString *)note{
    content = [YMHetongContentTableViewCell flattenHTML:content];
    CGFloat explainHeight = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    CGFloat tipsHeight = [note boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    
    return explainHeight + tipsHeight + 150;

}

+(NSString *)flattenHTML:(NSString *)html {
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html=[html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return html;
}

@end
