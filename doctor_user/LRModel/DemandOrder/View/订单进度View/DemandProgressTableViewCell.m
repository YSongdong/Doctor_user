//
//  DemandProgressTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandProgressTableViewCell.h"


@interface DemandProgressTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *stepLabel; //eg 1 2 3 4 ...

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic,assign)NSInteger step ;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (nonatomic,assign)NSInteger order_schedule ;


@end
@implementation DemandProgressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self roundBtn:_firstBtn borderColor:[UIColor bluesColor]];
    [self roundBtn:_secondBtn borderColor:[UIColor orangesColor]];
    [self roundBtn:_thirdBtn borderColor:[UIColor bluesColor]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)drawRect:(CGRect)rect {
    
}


- (void)roundBtn:(UIButton *)btn
     borderColor:(UIColor *)color {
    btn.layer.cornerRadius = 5 ;
    btn.layer.masksToBounds = YES ;
    btn.layer.borderColor = color.CGColor ;
    btn.layer.borderWidth = 0.8f ;
    
}
- (void)setModel:(id)model {
    
    if ([model count] == 0) {
        
        return ;
    }
    self.order_schedule = [model[@"order_schedule"] integerValue];
    
    NSInteger status = self.order_schedule ;
    
    if (status >= 4) {
        status = self.order_schedule - 1 ;
    }
    if ([self.stepLabel.text integerValue] <= status) {
        self.lineView.backgroundColor = [UIColor bluesColor];
        self.layerView.backgroundColor = [UIColor bluesColor];
        self.icon.image = [UIImage imageNamed:@"sanjiaoxing"];
    }else {
    self.lineView.backgroundColor = [UIColor deliveryMoneyColor];
        self.layerView.backgroundColor = [UIColor deliveryMoneyColor];
        self.icon.image =[UIImage imageNamed:@"sanjiaoxing2"];
    }
  if (self.step == 1) {
        //投标成功时间
        self.timeLabel.text = [self getTimeWithTimeInterval:model[@"finnshed_time"]]  ;
    }
    if (self.step == 2) {
        //洽谈成功时间
        //,......
        self.timeLabel.text = [self getTimeWithTimeInterval:model[@"order_time2"]] ;
    }
    if (self.step == 3) {
        self.timeLabel.text = [self getTimeWithTimeInterval:model[@"ascertain_tj"]] ;
    }
    if (self.step == 4) {
        self.timeLabel.text =  [self getTimeWithTimeInterval:model[@"payment_time"] ];
    }if (self.step == 5) {
        self.timeLabel.text =[self getTimeWithTimeInterval:model[@"geval_addtime"]] ;
    }
}

- (void)setOrder_schedule:(NSInteger)order_schedule {

    _order_schedule = order_schedule ;
    NSInteger status = _order_schedule ;
    if (status >= 4) {
        status = _order_schedule -1  ;
    }
    switch (status) {
        case 0:{
            self.firstBtn.enabled = NO ;
            [self setViewlayerColor:[UIColor lightGrayColor] andView:self.firstBtn];
            self.secondBtn.enabled = NO ;
            [self setViewlayerColor:[UIColor lightGrayColor] andView:self.secondBtn];
            self.thirdBtn.enabled = NO ;
            [self setViewlayerColor:[UIColor lightGrayColor] andView:self.thirdBtn];
        }break;
        case 1:{
            //第一步
            self.firstBtn.enabled = YES ;
            [self setViewlayerColor:[UIColor bluesColor] andView:self.firstBtn];
            self.secondBtn.enabled = NO ;
            [self setViewlayerColor:[UIColor lightGrayColor] andView:self.secondBtn];
            self.thirdBtn.enabled = NO ;
            [self setViewlayerColor:[UIColor lightGrayColor] andView:self.thirdBtn];
        }break;
        case 2:{
            
            self.firstBtn.enabled = YES ;
            [self setViewlayerColor:[UIColor bluesColor] andView:self.firstBtn];
            if (self.step  == _order_schedule) {
                self.secondBtn.enabled = YES;
                //判断是否选他签单
                [self setViewlayerColor:[UIColor orangesColor] andView:self.secondBtn];
                self.thirdBtn.enabled = NO ;
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.thirdBtn];
            }else {
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.secondBtn];
                self.secondBtn.enabled = NO ;
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.thirdBtn];
                self.thirdBtn.enabled = NO ;
            }
        }break;
        case 3:{
            
            self.firstBtn.enabled = YES ;
            [self setViewlayerColor:[UIColor bluesColor] andView:self.firstBtn];
            if (self.step == _order_schedule) {
                self.secondBtn.enabled = NO;
                [self.secondBtn setTitle:@"签订合同" forState:UIControlStateNormal];
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.secondBtn];
                //判断合同是否签订完成
                if (_order_schedule == 4) {
                    if (self.step == status) {
                        self.secondBtn.enabled = YES ;
                        [self.secondBtn setTitle:@"签订合同" forState:UIControlStateNormal];
                    }else if(self.step == 4){
                        self.secondBtn.enabled = NO ;
                        [self.secondBtn setTitle:@"确认付款" forState:UIControlStateNormal];
                    }
                  
                }
                    self.thirdBtn.enabled = NO ;
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.thirdBtn];
            }
            else {
                self.secondBtn.enabled = NO ;
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.secondBtn];
                self.thirdBtn.enabled = NO ;
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.thirdBtn];
                if (self.step == 2) {
                    [self.secondBtn setTitle:@"已投标" forState:UIControlStateNormal];
                }
            }
        }break;
        case 4:{
            
              self.firstBtn.enabled = YES ;
              [self setViewlayerColor:[UIColor bluesColor] andView:self.firstBtn];
            if (self.step == 4) {
                
                self.secondBtn.enabled = YES ;
                [self setViewlayerColor:[UIColor orangeColor] andView:self.secondBtn];
                [self.secondBtn setTitle:@"确认付款" forState:UIControlStateNormal];
                [self.thirdBtn setTitle:@"申请医盟仲裁" forState:UIControlStateNormal];
                self.thirdBtn.enabled = YES ;
                [self setViewlayerColor:[UIColor bluesColor] andView:self.thirdBtn];
            }
            else {
                if (self.step == 2) {
                    [self.secondBtn setTitle:@"已投标" forState:UIControlStateNormal];
                }
                if (self.step == 3) {
                    [self.secondBtn setTitle:@"签订合同" forState:UIControlStateNormal];
                }
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.secondBtn];
                self.secondBtn.enabled = NO ;
                self.thirdBtn.enabled = NO ;
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.thirdBtn];
            }
        
        }break;
        case 5:{
            self.firstBtn.enabled = YES ;
            [self setViewlayerColor:[UIColor bluesColor] andView:self.firstBtn];
            if (self.step == 5) {
                [self setViewlayerColor:[UIColor orangesColor] andView:self.secondBtn];
                self.secondBtn.enabled = YES ;
            }else {
                if (self.step == 2) {
                    [self.secondBtn setTitle:@"已投标" forState:UIControlStateNormal];
                }
                if (self.step == 3) {
                    [self.secondBtn setTitle:@"签订合同" forState:UIControlStateNormal];
                }
                
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.secondBtn];
                self.secondBtn.enabled = NO ;
                
                self.thirdBtn.enabled = NO ;
                [self setViewlayerColor:[UIColor lightGrayColor] andView:self.thirdBtn];
            }
            
        }break;
        default:
            break;
    }
}

- (void)setViewlayerColor:(UIColor *)color

                  andView:(UIButton *)view{
    
    view.layer.borderColor = color.CGColor ;
    [view setTitleColor:color forState:UIControlStateNormal];
}
- (NSString *)getTimeWithTimeInterval:(NSString *)timeInterval {
    if ([timeInterval integerValue]<= 0) {
        return nil ;
    }
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:[timeInterval integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [formatter stringFromDate:data];
}


- (void)setDataList:(NSDictionary *)dataList {
    
    _dataList = dataList ;
    self.contentLabel.text = dataList[@"content"];
    self.typeLabel.text = dataList[@"title"];
    self.stepLabel.text = dataList[@"step"];
    self.step = [dataList[@"step"] integerValue];
    switch (self.step) {
        case 2:{
            [self.secondBtn setTitle:@"选TA签单" forState:UIControlStateNormal];
            [self.thirdBtn setTitle:@"增加酬金" forState:UIControlStateNormal];
        }
            break;
        case 3:{
            [self.secondBtn setTitle:@"签订合同" forState:UIControlStateNormal];
            [self.thirdBtn setTitle:@"通知医生开始工作" forState:UIControlStateNormal];
        }break ;
        case 4:{
            [self.secondBtn setTitle:@"确认付款" forState:UIControlStateNormal];
            [self.thirdBtn setTitle:@"申请医盟仲裁" forState:UIControlStateNormal];
        }break ;
        case 5:{
            [self.secondBtn setTitle:@"评价" forState:UIControlStateNormal];
            [self.thirdBtn setTitle:@"查看评价" forState:UIControlStateNormal];
        }
        default:
            break;
    }
}
- (IBAction)firstBtn_Clicked:(id)sender {
    
    if (self.delegate) {
        [self.delegate didClickWithDifferentType:operateContact];
    }
}
- (IBAction)secondBtnClick:(id)sender {
    
    OperateType type ;
    switch (self.step) {
        case 2:{type = operateChoice ;}break;
        case 3:{type = operateContract;}break;
        case 4:{type = operateSurePay;}break ;
        case 5:{type = operateEvaluate;}break ;
        default:
            break;
    }
    [self.delegate didClickWithDifferentType:type];
}
- (IBAction)thirdBtnClicked:(id)sender {
    OperateType type ;
    switch (self.step) {
        case 2:{type = operateAddMoney ;}break;
        case 3:{type = operateNotifyWork;}break;
        case 4:{type = operateArbitration;}break ;
        case 5:{type = operateShowEvaluate;}break ;
        default:
            break;
    }
    [self.delegate didClickWithDifferentType:type];

    
}


@end
