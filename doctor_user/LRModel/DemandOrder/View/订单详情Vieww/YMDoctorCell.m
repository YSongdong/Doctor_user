//
//  YMDoctorCell.m
//  doctor_user
//
//  Created by kupurui on 2017/2/10.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorCell.h"

@interface YMDoctorCell ()

@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospital;
@property (weak, nonatomic) IBOutlet UILabel *deal;//成交量
@property (weak, nonatomic) IBOutlet UILabel *authen; //证
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *zhicheng;//职称
@property (weak, nonatomic) IBOutlet UILabel *evaluate;//评价
@property (weak, nonatomic) IBOutlet UIImageView *contactImg;//联系他图标
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stepImg;//进度图标 如 选标 合同
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

//eg 开始工作
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (nonatomic,assign)NSInteger order_schedule ; //0

@end

@implementation YMDoctorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _authen.layer.cornerRadius = 2 ;
    _authen.layer.masksToBounds = YES ;
    _nameLabel.text = @"";
    _hospital.text = @"";
    _deal.text =[NSString stringWithFormat:@"成交量:  0"];;
    _level.text = @"";
    _zhicheng.text = @"";
    _evaluate.text = [NSString stringWithFormat:@"好评率:0"];
    _head.layer.cornerRadius = 32.5 ;
    _head.layer.masksToBounds = YES ;
    [self addgestureOnImageView];
}

- (void)addgestureOnImageView{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didclick)];
    [_head addGestureRecognizer:tap];
    _head.userInteractionEnabled = YES ;
}

- (void)didclick {
 
    if (self.headBtnBlock) {
        self.headBtnBlock(self.dic);
    }
}

- (void)setDic:(NSDictionary *)dic {
    
    _dic  = dic;
    [_head sd_setImageWithURL:[NSURL URLWithString:dic[@"store_avatar"]] placeholderImage:[UIImage imageNamed:@"暂无头像_03.png"]];
    _nameLabel.text = @"医生";
    
    if ([dic[@"member_names"]length] != 0) {
        
        _nameLabel.text = dic[@"member_names"];

    }
    _hospital.text = dic[@"member_occupation"];
    _deal.text = [NSString stringWithFormat:@"成交量:  %@",dic[@"goods_volume"]];
    _level.text = [NSString stringWithFormat:@"LV%@",dic[@"grade_id"]] ;
    _zhicheng.text = dic[@"member_aptitude"];
    _evaluate.text = [NSString stringWithFormat:@"好评率:  %@",dic[@"goodsP"]];
    _statusLabel.text = [NSString stringWithFormat:@"  状态 :%@",_dic[@"demand_status"]];
    _order_schedule = [dic[@"order_schedule"] integerValue];
    NSLog(@"------->%ld",_order_schedule);
    
    switch (_order_schedule ) {
        case 0:{
            self.contactImg.image = [UIImage imageNamed:@"消息灰色"];
            self.contactLabel.textColor = [UIColor lightGrayColor];
            self.stepImg.image = [UIImage imageNamed:@"选标灰色"];
            self.stepLabel.text = @"选标";
            self.stepLabel.textColor = [UIColor lightGrayColor];
            self.firstBtn.enabled = NO ;
            self.secondBtn.enabled = NO ;
        }break;
        case 1:{
            self.contactImg.image = [UIImage imageNamed:@"通讯消息"];
            self.contactLabel.textColor = [UIColor bluesColor];
            self.stepImg.image = [UIImage imageNamed:@"选标灰色"];
            self.stepLabel.text = @"选标";
            self.stepLabel.textColor = [UIColor lightGrayColor];
            self.firstBtn.enabled = YES ;
            self.secondBtn.enabled = NO ;
        }break;
        case 2:{
            self.contactImg.image = [UIImage imageNamed:@"通讯消息"];
            self.contactLabel.textColor = [UIColor bluesColor];
            self.stepImg.image = [UIImage imageNamed:@"选标"];
            self.stepLabel.text = @"选标";
            self.stepLabel.textColor = [UIColor orangesColor];
            self.firstBtn.enabled = YES ;
            self.secondBtn.enabled = YES ;
        }break;
        case 3:{
            self.contactImg.image = [UIImage imageNamed:@"通讯消息"];
            self.contactLabel.textColor = [UIColor bluesColor];
            self.stepImg.image = [UIImage imageNamed:@"合同"];
            self.stepLabel.text = @"催促合同";
            self.stepLabel.textColor = [UIColor orangesColor];
            self.firstBtn.enabled = YES ;
            self.secondBtn.enabled = YES ;
            if ([_dic[@"order_status"]isEqual:[NSNull null]]) {
                _statusLabel.text = [NSString stringWithFormat:@"  状态 :%@",@"等待签订合同"];
            }
        }break;
        case 4:{self.contactImg.image = [UIImage imageNamed:@"通讯消息"];
            self.contactLabel.textColor = [UIColor bluesColor];
            self.stepImg.image = [UIImage imageNamed:@"合同"];
            self.stepLabel.text = @"签订合同";
            self.stepLabel.textColor = [UIColor orangesColor];
            self.firstBtn.enabled = YES ;
            self.secondBtn.enabled = YES ;
        }break;
        case 5:{self.contactImg.image = [UIImage imageNamed:@"通讯消息"];
            self.contactLabel.textColor = [UIColor bluesColor];
            self.stepImg.image = [UIImage imageNamed:@"合同"];
            self.stepLabel.text = @"查看合同";
            self.stepLabel.textColor = [UIColor orangesColor];
            self.firstBtn.enabled = YES ;
            self.secondBtn.enabled = YES ;
        }break;
        case 6:{
            self.contactImg.image = [UIImage imageNamed:@"通讯消息"];
            self.contactLabel.textColor = [UIColor bluesColor];
            self.stepImg.image = [UIImage imageNamed:@"合同"];
            self.stepLabel.text = @"查看合同";
            self.stepLabel.textColor = [UIColor orangesColor];
            self.firstBtn.enabled = YES ;
            self.secondBtn.enabled = YES ;
        }
        default:
            break;
    }
}

//联系医生
- (IBAction)firstStep:(id)sender {
    
    if (self.contactBlock) {
        self.contactBlock(_dic);
    }
}
//第二步
- (IBAction)secondStep:(id)sender {
    
    if (self.secondBtnBlock) {
        //相同的按钮 不同的状态
        self.secondBtnBlock(_dic,_order_schedule);
    }
}
//状态
- (IBAction)thirdStep:(id)sender {
    if (self.thirdBtnClickBlock) {
        self.thirdBtnClickBlock(_dic);
    }
    
}

@end
