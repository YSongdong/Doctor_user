//
//  YMActivityDetailsTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMActivityDetailsTableViewCell.h"

@interface YMActivityDetailsTableViewCell ()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *activityHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityTitleLabel;//标题

@property (weak, nonatomic) IBOutlet UILabel *activityPresentLabel;//介绍

@property (weak, nonatomic) IBOutlet UIImageView *activityImagePresentImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityConditionlabel;

@property (weak, nonatomic) IBOutlet UILabel *activityTime;

@end

@implementation YMActivityDetailsTableViewCell

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
}


-(void)initView{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

#pragma mark - setter
-(void)setPresent:(NSString *)present{
    _activityPresentLabel.text = present;
}

+(CGFloat)activityDetailHeight:(NSString *)activityPresent{
    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.text = activityPresent;
    detailLabel.font = [UIFont systemFontOfSize:13];
    
    return ([detailLabel intrinsicContentSize].width/(SCREEN_WIDTH - 20)*([detailLabel intrinsicContentSize].height+0.5)+1)+520;
}

@end
