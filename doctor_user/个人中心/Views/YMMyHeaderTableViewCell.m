//
//  YMMyHeaderTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMMyHeaderTableViewCell.h"

@interface YMMyHeaderTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerBackGroundView;


@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *myHeaderImageView;

@property (weak, nonatomic) IBOutlet UILabel *myNickname;
@property (weak, nonatomic) IBOutlet UILabel *messageNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;//余额

@property (weak, nonatomic) IBOutlet UILabel *showBalanceLabel; //显示余额

@property (weak, nonatomic) IBOutlet UILabel *transactionAmountLabel;//成交金额
@property (weak, nonatomic) IBOutlet UILabel *showTransactionLabel;//显示成交金额

@property (weak, nonatomic) IBOutlet UIView *lineView; //线条

@property (weak, nonatomic) IBOutlet UIButton *setButton;

- (IBAction)homePageEditBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *lineGrounView; //线条背景View

- (IBAction)mineAccountBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *radMessageCountView; //消息红点


@end

@implementation YMMyHeaderTableViewCell

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
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_setButton LZSetbuttonType:LZCategoryTypeBottom];
    });
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [_myHeaderImageView addGestureRecognizer:tapGestureRecognizer];
    [_myHeaderImageView setUserInteractionEnabled:YES];
    
    _myHeaderImageView.layer.borderWidth = 2 ;
    _myHeaderImageView.layer.borderColor = [UIColor textWiterColor].CGColor;
    
    //消息红点
    self.radMessageCountView.backgroundColor = [UIColor redColor];
    self.radMessageCountView.layer.masksToBounds = YES;
    self.radMessageCountView.layer.cornerRadius = CGRectGetWidth(self.radMessageCountView.frame)/2;
    
    //背景view
    self.headerBackGroundView.backgroundColor = [UIColor colorWithHexString:@"#3d85cc"];
    
    //背景线条view
    self.lineGrounView.backgroundColor = [UIColor colorWithHexString:@"#b5d5f5"];
    
    //显示余额
    self.balanceLabel.textColor = [UIColor  textWiterColor];
    self.showBalanceLabel.textColor = [UIColor textWiterColor];
    
    //显示成交金额
    self.transactionAmountLabel.textColor  = [UIColor textWiterColor];
    self.showTransactionLabel.textColor = [UIColor textWiterColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark - setter

-(void)setModel:(YMUserInforModel *)model{
    _model = model;
    
    [_myHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    
    _myNickname.text = model.member_name;
    
   
    _balanceLabel.text = _model.available_predeposit;
    _transactionAmountLabel.text =_model.sum;
   
}

#pragma mark - butttonClick

- (IBAction)backgroupClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(headerCell:backGroup:)]) {
        [self.delegate headerCell:self backGroup:sender];
    }
    NSLog(@"进入个人信息");
}
- (IBAction)messageClick:(id)sender {
    NSLog(@"消息");
    if ([self.delegate respondsToSelector:@selector(headerCell:message:)]) {
        [self.delegate headerCell:self message:sender];
    }
}
- (IBAction)setUpClick:(id)sender {
    NSLog(@"设置");
    if ([self.delegate respondsToSelector:@selector(headerCell:setUp:)]) {
        [self.delegate headerCell:self setUp:sender];
    }
}
- (IBAction)updateHeaderImageClick:(id)sender {
//    NSLog(@"上传照片");
    if ([self.delegate respondsToSelector:@selector(headerCell:upDataHeaderImage:)]) {
        [self.delegate headerCell:self upDataHeaderImage:sender];
    }
}
- (IBAction)myMingYiClick:(id)sender {
    NSLog(@"我的鸣医");
    if ([self.delegate respondsToSelector:@selector(headerCell:myMingyYi:)]) {
        [self.delegate headerCell:self myMingyYi:sender];
    }
}
- (IBAction)myServerClick:(id)sender {
    NSLog(@"我的服务");
    if ([self.delegate respondsToSelector:@selector(headerCell:purchaseServer:)]) {
        [self.delegate headerCell:self purchaseServer:sender];
    }
}
- (IBAction)reportClick:(id)sender {
    NSLog(@"报告");
    if ([self.delegate respondsToSelector:@selector(headerCell:presentation:)]) {
        [self.delegate headerCell:self presentation:sender];
    }
}
- (IBAction)registeredClick:(id)sender {
    NSLog(@"挂号");
    if ([self.delegate respondsToSelector:@selector(headerCell:registerInfor:)]) {
        [self.delegate headerCell:self registerInfor:sender];
    }
}

-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(headerCell:upDataHeaderImage:)]) {
        [self.delegate headerCell:self upDataHeaderImage:nil];
    }
}
 //编辑按钮
- (IBAction)homePageEditBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(headerCell:upEdit:)]) {
        [self.delegate headerCell:self upEdit:sender];
    }
    
}
//进入我的账户
- (IBAction)mineAccountBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(headerCell:myAccount:)]) {
        [self.delegate headerCell:self myAccount:sender];
    }
}
@end
