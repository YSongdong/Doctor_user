//
//  YMTopicImageCollectionViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMTopicImageCollectionViewCell.h"


@interface YMTopicImageCollectionViewCell ()

@property(nonatomic,strong)UIImageView *showImageView;

@end

@implementation YMTopicImageCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)awakeFromNib{
    [super  awakeFromNib];
    
}

-(void)createView{
    _showImageView =[[UIImageView alloc]init];
    [self addSubview:_showImageView];
    [_showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_showImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    
}

#pragma mark - setter

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
}

@end
