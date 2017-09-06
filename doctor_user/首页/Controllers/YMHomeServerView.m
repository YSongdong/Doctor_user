//
//  YMHomeServerView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/13.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHomeServerView.h"

@interface YMHomeServerView ()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIImageView *subLeftImage;
@property (weak, nonatomic) IBOutlet UILabel *subLeftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subRightImage;
@property (weak, nonatomic) IBOutlet UILabel *subRightLabel;


@end

@implementation YMHomeServerView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    if (_data) {
        [_leftButton setImage:[UIImage imageNamed:_data[@"leftButtonNorm"]] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:_data[@"leftButtonHig"]] forState:UIControlStateHighlighted];
        
        
        [_subLeftImage setImage:[UIImage imageNamed:_data[@"subLeftImage"]]
             ];
        [_subLeftLabel setText:_data[@"subLeftName"]];
        
            [_subRightImage setImage:[UIImage imageNamed: _data[@"subRightImage"]]];
        [_subRightLabel setText:_data[@"subRightName"]];
    }
   
}

-(void)setData:(NSDictionary *)data{
    _data = data;
}


- (IBAction)leftClickButton:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(serverView:serverType:button:)]) {
        [self.delegate serverView:self serverType:ServerLeftButton button:sender];
    }
}

- (IBAction)subLeftclickButton:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(serverView:serverType:button:)]) {
        [self.delegate serverView:self serverType:ServerSubLeftButton button:sender];
    }
}
- (IBAction)subRightClickButton:(id)sender {

    if ([self.delegate respondsToSelector:@selector(serverView:serverType:button:)]) {
        [self.delegate serverView:self serverType:ServerSubRightButton button:sender];
    }
}


@end
