//
//  YMOrderInforView.m
//  doctor_user
//
//  Created by 黄军 on 17/6/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderInforView.h"

@interface YMOrderInforView()
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;//订单ID
@property (weak, nonatomic) IBOutlet UILabel *orderContentLabel;//订单内容

@property (weak, nonatomic) IBOutlet UILabel *demandTimeLabel;//需求时间
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;//订单金额
@property (weak, nonatomic) IBOutlet UIButton *orderDetailsButton;//订单详情

@end

@implementation YMOrderInforView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [_orderDetailsButton LZSetbuttonType:LZCategoryTypeLeft];    
    });
    

}
- (IBAction)orderDetailsClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(orderInfoView:orderDetails:)]) {
        [self.delegate orderInfoView:self orderDetails:sender];
    }
}

-(void)setModel:(YMDemandBidSelectionModel *)model{
    _orderIDLabel.text = model.demand_sn;//订单ID
    _orderContentLabel.text = model.title;//订单内容
    
    _demandTimeLabel.text = model.demand_time;//需求时间
    _orderMoneyLabel.text = model.money;//订单金额
}

-(void)setDoctorOrdermodel:(YMDoctorOrderProcessModel *)doctorOrdermodel{
    _doctorOrdermodel = doctorOrdermodel;
    _orderIDLabel.text = doctorOrdermodel.order_sn;//订单ID
    _orderContentLabel.text = doctorOrdermodel.title;//订单内容
    
    _demandTimeLabel.text = doctorOrdermodel.demand_time;//需求时间
    _orderMoneyLabel.text = doctorOrdermodel.money;//订单金额
}


@end
