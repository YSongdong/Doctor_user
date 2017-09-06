//
//  YMHomeServerTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/13.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHomeServerTableViewCell.h"
#import "YMHomeServerView.h"

@interface YMHomeServerTableViewCell ()<YMHomeServerViewDelegate>

@property (weak, nonatomic) IBOutlet YMHomeServerView *firstServerView;

@property (weak, nonatomic) IBOutlet YMHomeServerView *twoServerView;

@property (weak, nonatomic) IBOutlet YMHomeServerView *threeServerView;

@end

@implementation YMHomeServerTableViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self createView];
}

-(void)createView{
    _firstServerView.delegate = self;
    _twoServerView.delegate = self;
    _threeServerView.delegate = self;
    
    /**
     * @"leftButtonNormal" :@"图片名字"
     * @"leftButtonHig" :@"图片名字"
     * @"subLeftImage":@"图片名字"
     * @"subRightImage":@"图片名字"
     * @"subLeftName":@"label显示的文字"
     * @"subRightName":@"label显示的文字"
     */
    
    NSDictionary *firstData= @{@"leftButtonNorm":@"发布需求-轻松就医",
                               @"leftButtonHig":@"发布需求-轻松就医",
                               @"subLeftImage":@"Doctors",
                               @"subRightImage":@"nurse",
                               @"subLeftName":@"医生",
                               @"subRightName":@"护士",
                               };
    NSDictionary *twoData= @{@"leftButtonNorm":@"名医联合-专家会诊",
                               @"leftButtonHig":@"名医联合-专家会诊",
                               @"subLeftImage":@"report",
                               @"subRightImage":@"activity",
                               @"subLeftName":@"体检报告",
                               @"subRightName":@"官方活动",
                               };
    NSDictionary *threeData= @{@"leftButtonNorm":@"色相-饱和度-3",
                               @"leftButtonHig":@"色相-饱和度-3",
                               @"subLeftImage":@"Demand_Hall",
                               @"subRightImage":@"Archives",
                               @"subLeftName":@"需求大厅",
                               @"subRightName":@"案例库",
                               };
    _firstServerView.data = firstData;
    _twoServerView.data = twoData;
    _threeServerView.data = threeData;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)serverView:(YMHomeServerView *)serverView serverType:(serverButton )serverType button:(UIButton *)sender{
    switch (serverView.tag) {
        case 1:{
            switch (serverType) {
                case ServerLeftButton:{
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:firstLeftButton:)]) {
                        [self.delegate HomeServerTableViewCell:self firstLeftButton:sender];
                    }
                }
                    break;
                case ServerSubLeftButton:
                {
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:firstSubLeftButton:)]) {
                        [self.delegate HomeServerTableViewCell:self firstSubLeftButton:sender];
                    }
                }
                    break;
                case ServerSubRightButton:
                {
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:firstSubRightButton:)]) {
                        [self.delegate HomeServerTableViewCell:self firstSubRightButton:sender];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:{
            switch (serverType) {
                case ServerLeftButton:{
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:twoLeftButton:)]) {
                        [self.delegate HomeServerTableViewCell:self twoLeftButton:sender];
                    }
                }
                    break;
                case ServerSubLeftButton:
                {
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:twoSubLeftButton:)]) {
                        [self.delegate HomeServerTableViewCell:self twoSubLeftButton:sender];
                    }
                }
                    break;
                case ServerSubRightButton:
                {
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:twoSubRightButton:)]) {
                        [self.delegate HomeServerTableViewCell:self twoSubRightButton:sender];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:{
            switch (serverType) {
                case ServerLeftButton:{
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:threeLeftButton:)]) {
                        [self.delegate HomeServerTableViewCell:self threeLeftButton:sender];
                    }
                }
                    break;
                case ServerSubLeftButton:
                {
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:threeSubLeftButton:)]) {
                        [self.delegate HomeServerTableViewCell:self threeSubLeftButton:sender];
                    }
                }
                    break;
                case ServerSubRightButton:
                {
                    if ([self.delegate respondsToSelector:@selector(HomeServerTableViewCell:threeSubRightButton:)]) {
                        [self.delegate HomeServerTableViewCell:self threeSubRightButton:sender];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}


@end
