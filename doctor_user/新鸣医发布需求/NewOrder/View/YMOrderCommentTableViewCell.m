//
//  YMOrderCommentTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderCommentTableViewCell.h"
#import "KTRLabelView.h"


@interface YMOrderCommentTableViewCell()

@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)KTRLabelView *labelView;

@property(nonatomic,strong)UIView *fractionView;

@end

@implementation YMOrderCommentTableViewCell

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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
