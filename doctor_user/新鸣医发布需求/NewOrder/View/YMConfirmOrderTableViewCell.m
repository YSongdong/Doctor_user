//
//  YMConfirmOrderTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/6/6.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMConfirmOrderTableViewCell.h"
#import "YMMyAttentionTableViewCell.h"

@interface YMConfirmOrderTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet YMMyAttentionTableViewCell *doctorInforView;
@property (weak, nonatomic) IBOutlet UILabel *tipInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *contractButton;

@end

@implementation YMConfirmOrderTableViewCell

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
    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _contractButton.layer.masksToBounds = YES;
    _contractButton.layer.cornerRadius = 5;
    _contractButton.layer.borderWidth  =1.f;
    _contractButton.layer.borderColor = RGBCOLOR(239, 132, 0).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)contractClick:(id)sender {
    NSLog(@"合同按钮点击");
}

@end
