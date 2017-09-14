//
//  YMPlayerManager.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/24.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMPlayerManager.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "YMNewPayView.h"



@interface YMPlayerManager()

@property(nonatomic,strong)UIView *view;

@end

@implementation YMPlayerManager

-(instancetype)initManagerView:(UIView *)view {
    self = [super init];
    if (self) {
        _view = view;
    }
    return self;
}


-(void)startPay{
    if (!_dic) {
        return;
    }
    switch (_type) {
        case AplayPayType:{
            
            [self payForAlipay];
        }
            break;
        case WXPayType:{
            [self payForWx];
        }
            break;
        default:
            break;
    }
}

-(void)payForAlipay {
    NSLog(@"支付宝支付");
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
    order.tradeNO = _dic[@"sn"];//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"鸣医通"; //商品标题
    order.productDescription = @"雇佣订单支付宝支付";//@"加州物业捷支付"; //商品描述
    order.amount = _dic[@"should_pay"]; //商品价格
    
    order.notifyURL = [NSString stringWithFormat:@"%@%@",BASEURL,@"act=new_order&op=paySucceedByZfb"];//回调URL
    
//    order.notifyURL = [NSString stringWithFormat:@"http://ys9958.com/api/index.php?act=new_order&op=paySucceedByZfb"]; //回调URL
    
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
                [self checkPayed];
                
                
            }else{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                
            }
            
        }];
        
    }
    
}
-(void)payForWx{
    NSLog(@"微信支付");
    
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=wxpay&op=apppay2" params:@{@"sn":[NSString isEmpty:_dic[@"sn"]]?@"":_dic[@"sn"]} withModel:nil waitView:_view complateHandle:^(id showdata, NSString *error) {
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
            [_view hideBubble];
        }else{
            [_view showErrorWithTitle:@"请安装微信后才能快捷支付" autoCloseTime:1];
            //[MBProgressHUD showError:@"请安装微信后才能快捷支付"];
            
        }
    }];
    
}
//

//
//
-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}
//
-(void)checkPayed{
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=new_order&op=checkPayed" params:@{@"sn":!_dic[@"sn"]?@"":[NSString isEmpty:_dic[@"sn"]]?@"":_dic[@"sn"]} withModel:nil waitView:_view complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            if ([showdata[@"is_payed"] integerValue] ==1) {
                [_view showErrorWithTitle:@"已支付成功" autoCloseTime:2];
            }else{
                [_view showErrorWithTitle:@"未支付" autoCloseTime:2];
            }
            
            if ([self.delegate respondsToSelector:@selector(playSuccess:)]) {
                [self.delegate playSuccess:self];
            }
        }
    }];

}



@end
