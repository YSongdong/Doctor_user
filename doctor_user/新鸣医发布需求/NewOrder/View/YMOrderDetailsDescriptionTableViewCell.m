//
//  YMOrderDetailsDescriptionTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderDetailsDescriptionTableViewCell.h"

@interface YMOrderDetailsDescriptionTableViewCell()

@property(nonatomic,strong)UILabel *descriptionContentLabel;

@end

@implementation YMOrderDetailsDescriptionTableViewCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initView{
    _descriptionContentLabel = [[UILabel alloc]init];
    //多行显示
    _descriptionContentLabel.numberOfLines = 0;
    
    _descriptionContentLabel.textColor = RGBCOLOR(130, 130, 130);
    _descriptionContentLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_descriptionContentLabel];
    [_descriptionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

-(void)setDescriptionComment:(NSString *)descriptionComment{
    _descriptionComment = [NSString stringWithFormat:@"需求描述:%@",descriptionComment];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_descriptionComment];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor blackColor]
                range:NSMakeRange(0,5)];
    _descriptionContentLabel.attributedText = str;
}

+(CGFloat)heightForDescriptionComment:(NSString *)descriptionComment{
    return [descriptionComment boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height+20;
}

@end
