//
//  YMMiYiOrderView.m
//  doctor_user
//
//  Created by 黄军 on 17/6/2.
//  Copyright © 2017年 CoderxDX. All rights reserved.
//

#import "YMMiYiOrderViewCell.h"

@interface YMMiYiOrderViewCell()
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;//订单ID
@property (weak, nonatomic) IBOutlet UILabel *orderContentLabel;//订单内容

@property (weak, nonatomic) IBOutlet UILabel *demandTimeLabel;//需求时间
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;//订单金额
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;//状态

@end

@implementation YMMiYiOrderViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
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


-(void)setModel:(YMNewOrderModel *)model{
    _model = model;
    _orderIDLabel.text = model.demand_sn;//订单ID
    _orderContentLabel.text = model.title;//订单内容
    
    if (self.hideMonay) {
        //疑难杂症
        _demandTimeLabel.text =[NSString stringWithFormat:@"需求时间:%@",model.diseases_time];//需求时间
        _statusLabel.text = model.status_desc;//状态
        
        
    }else{
        
        //鸣医订单
       _demandTimeLabel.text = [NSString stringWithFormat:@"需求时间:%@",model.demand_time];//需求时间
        
        _orderMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.money] ;//订单金额
        switch ([_model.order_type integerValue]) {
            case 1:
                _statusLabel.text = model.status;//状态
                break;
            case 2:
                _statusLabel.text = model.yuyue_state_desc;//状态
                break;
            case 3:
                
                break;
            case 4:
                
                break;
            case 5:
                
                break;
            case 6:
                break;
            default:
                break;
        }

        
    }
   }

-(void)setHideMonay:(BOOL)hideMonay{

    _hideMonay = hideMonay;
    if (hideMonay) {
        _orderMoneyLabel.hidden = YES;
    }

}


@end
