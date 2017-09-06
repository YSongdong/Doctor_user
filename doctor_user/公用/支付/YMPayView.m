//
//  YMPayView.m
//  doctor_user
//
//  Created by kupurui on 17/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMPayView.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "PhoneView.h"
#import "PassView.h"
#import <objc/runtime.h>
#define  MEMBER_ID [YMUserInfo sharedYMUserInfo].member_id
static NSString *const payResultFinish = @"payResultFinish" ;

@interface YMPayView()
@property (weak, nonatomic) IBOutlet UIView *payView;

@property (weak, nonatomic) IBOutlet UIButton *banlanceBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHight;
@property (nonatomic, strong) NSDictionary *myData;
@property (nonatomic, strong) PhoneView *phoneView;
@end
@implementation YMPayView
{
    STATUS statu;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)hiddenBtnClick:(id)sender {
    self.bottomHight.constant = -355;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (IBAction)payStyleClick:(UIButton *)sender {
    [self.banlanceBtn setSelected:NO];
    [self.zhifubaoBtn setSelected:NO];
    [self.wechatBtn setSelected:NO];
    [sender setSelected:YES];
    
}
- (IBAction)surePayBtnClick:(id)sender {
    
    if (self.banlanceBtn.selected) {
        statu = YUE;
        [self payForBalance];
    }
    if (self.zhifubaoBtn.selected) {
        statu= ZHIFUBAO;
        [self payForAlipay];
    }
    if (self.wechatBtn.selected) {
        statu = WEIXIN;
        [self weChatPay];
    }
    
}
- (void)payForBalance {
    PhoneView *phoneView = [PhoneView phoneViewFromXIBWithTitle:@"请输入手机验证码"];
    self.phoneView = phoneView;
    phoneView.havePayPass = [self.myData[@"predeposit"][@"member_paypwd"] length] > 0 ? 1 : 0;
    [phoneView showView ];
    //yanzhengma
    __weak typeof(self) weakSelf = self ;
    phoneView.block = ^() {
        [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=release&op=regist" params:@{@"phone":self.myData[@"order_list"][@"member_mobile"]} withModel:nil complateHandle:^(id showdata, NSString *error) {
            if (showdata == nil) {
                return ;
            }
        }];
        
    };
    //短信提现
    phoneView.messgeBlock = ^(NSString * code){
        [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=release&op=pay_available" params:@{@"member_id":MEMBER_ID,@"pay_sn":self.myData[@"order_list"][@"pay_sn"],@"password":code,@"type":@"1"} withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
            if (showdata == nil) {
                return ;
            }
            //支付成功
            [self payEnd];
        }];

        
        
    };
    
    phoneView.setPaypassBlock = ^(id value){
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (MEMBER_ID) {
            [dic setObject:MEMBER_ID forKey:@"member_id"];
        }
        [dic setObject:value forKey:@"member_paypwd"];
        [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_account&op=account_zfmms" params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
            if (!error) {
                //直接支付
                [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=release&op=pay_available" params:@{@"member_id":MEMBER_ID,@"pay_sn":self.myData[@"order_list"][@"pay_sn"],@"password":value,@"type":@"2"} withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
                    if (showdata == nil) {
                        return ;
                    }
                    //支付成功
                    [self payEnd];
                }];
            }
        }];
    };
    
    phoneView.paypassBlock = ^(NSString *value) {
        
        [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=release&op=pay_available" params:@{@"member_id":MEMBER_ID,@"pay_sn":self.myData[@"order_list"][@"pay_sn"],@"password":value,@"type":@"2"} withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
            if (showdata == nil) {
                return ;
            }
            //支付成功
            [self payEnd];
        }];
        
        
        
    };
}
- (void)payForAlipay {
    //支付宝支付
    NSString *partner = @"2088121649148024";//
    NSString *seller = @"2088121649148024";
    NSString *privateKey =@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOOkT46j5VWwR5hJoW2YWg9v3k6JvySxpsMHLoUqAJe76JzR7d9B1KpoNeOu/WMt6WNNHF4SjvmKaxuNXLxy9E2gH8/MKbZw8Ggh5pTExcP5xxuj0CYw71IWXUC1pBzcc8GNA/ifk4NrE5PBLkVPADfFpxv5VWcXmGAtVxhy2sz1AgMBAAECgYEA4SXbNfYuVjDyrtFsYwwDTy9SzZT5w14d1NkejsB7M5e7upb7UQw4PY6ydg3WOajoI7nZq8VpObBIvUh0h0KfEuYEy5h4bhBNSD+wBKL9NGMN4Y2H0cOrkRaXPfEPImPAvfUHUJ+g/zFPmuD/c/4QFIVWmFkkdZWR6zNoamL8hCECQQD2Md/R6k5SuRrPsfxN3NbtK2i5xlMEfZ08Elb0zvImCX6v2l4/y7EBHKfbG/uzNqEJo6SCp1Mn0SjzxxCCzCPJAkEA7LVGqsfPn2C1vrQ1juM9wGDttEjmijHzh640UFwUH0HEvid7ySpclKGfz1xZC4FqAVF1NqPourwmdkl9kyF9zQJBAKtWZnhG4p97p4coTXk62nFQpp+zwI79hPILqWzSoX+LWBm2laU8c0Fc2g0JWpCM0mJM+u7a2Gp7jE6sGXeN7tECQDhXQXW+z3VhAIFexWy4O+eBarLBs1XrY8rEtSD3ebai4eBc54LPOXALNE2X7n3llMSxjdOumeNwizsWbPRLQXUCQDSn1HwuSt2kjGR83hmDTdvDMWzc9hFIeP1TsWeCUBV1LBuVrAsBnkX087tvbJKH5aDkXgviKnL/SvlGnlpnClI=";
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;//商户ID
    order.seller = seller;//支付宝账户ID
    order.tradeNO = self.myData[@"order_list"][@"pay_sn"];//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"鸣医通"; //商品标题
    order.productDescription = @"雇佣订单支付宝支付";//@"加州物业捷支付"; //商品描述
    order.amount = self.myData[@"order_list"][@"order_amount"]; //商品价格
    order.notifyURL = [NSString stringWithFormat:@"http://ys9958.com/api/index.php?act=release&op=return"]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"yimenguser";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            //支付宝支付钱包
            NSString *successStr=resultDic[@"success"];
            NSString*jsonString=
            [self URLDecodedString:successStr];
            
            
            NSLog(@"reslut = %@",resultDic);
            
            int Status =[[resultDic objectForKey:@"resultStatus"] intValue];
            if ([jsonString isEqualToString:@"\\\"true\\\""]||Status==9000) {
                NSLog(@"交易成功");
                //[self backBtnClick];
                [self payEnd];
                
                
            }else{
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                
            }
            
        }];
        
    }
}
- (void)payEnd {
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=release&op=pay_result" params:@{@"pay_sn":self.myData[@"order_list"][@"pay_sn"]} withModel:nil waitView:self.superview complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            // [MBProgressHUD showError:error];
            return ;
        }
        [self showRightWithTitle:@"支付成功" autoCloseTime:1];
        
        //[NSThread sleepForTimeInterval:1];
        if (self.block) {
            [self.phoneView disappearView];
            [self removeFromSuperview];
            self.block([self.myData[@"order_list"][@"demand_id"] longLongValue]);
        } else {
            [self.phoneView disappearView];
            [self removeFromSuperview];
            [self.superVC.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
        
        //[self performSelector:@selector(push:) withObject:showdata afterDelay:1];
        
    }];
}
-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}
- (void)setDetailMoneyWith:(NSString *)money andData:(NSDictionary *)dic {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WXpayResult:) name:payResultFinish object:nil];
    NSString *str = [NSString stringWithFormat:@"%@  元",money];
    self.myData = [dic copy];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:28],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, money.length)];
    [attr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]} range:[str rangeOfString:@"元"]];
    [self.moneyLable setAttributedText:attr];
}
-(void)WXpayResult:(NSNotification*)sender{
    NSDictionary *dic = sender.userInfo;
    if ([dic[@"pay"] isEqualToString:@"1"]) {
        
        [self payEnd];
    } else {
        [self showErrorWithTitle:@"支付失败" autoCloseTime:2];
    }
    
}
- (void)setAnimaltion {
    self.bottomHight.constant = 0;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.payView.frame, point)) {
        self.bottomHight.constant = -310;
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
}
#pragma mark - 微信支付
- (void)weChatPay {
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=wxpay&op=apppay" params:@{@"pay_sn":self.myData[@"order_list"][@"pay_sn"],@"member_id":[YMUserInfo sharedYMUserInfo].member_id} withModel:nil waitView:self.superview complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            //[MBProgressHUD showError:error];
            return ;
        }
        NSLog(@"返回数据 -- %@",showdata);
        BOOL isInstalled=[WXApi isWXAppInstalled];
        
        if (isInstalled) {
            NSMutableString *stamp  = [showdata objectForKey:@"timestamp"];
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [showdata objectForKey:@"appid"];
            req.partnerId           = [showdata objectForKey:@"partnerid"];
            req.prepayId            = [showdata objectForKey:@"prepayid"];
            req.nonceStr            = [showdata objectForKey:@"noncestr"];
            req.timeStamp           = [stamp intValue];
            req.package             = [showdata objectForKey:@"package"];
            req.sign                = [showdata objectForKey:@"sign"];
            //self.isReturn = YES;
            [WXApi sendReq:req];
        }else{
            [self showErrorWithTitle:@"请安装微信后才能快捷支付" autoCloseTime:1];
            //[MBProgressHUD showError:@"请安装微信后才能快捷支付"];
            
        }
    }];
}

@end
