//
//  ContractViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ContractViewController.h"
#import "AddressPickerView.h"

@interface ContractViewController ()<AddressPickerViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *beginTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (weak, nonatomic) IBOutlet UITextView *descriptTextView;
@property (weak, nonatomic) IBOutlet UILabel *protocalBtn;
@property (weak, nonatomic) IBOutlet UILabel *employerLabel; //雇主
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel; //服务商
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (nonatomic,strong)UIImageView *imageView1; //印章1
@property (nonatomic,strong)UIImageView *imageView2 ;//印章2
@property (nonatomic,assign)NSInteger sureBtnStatus ;
@property (nonatomic,assign)NSInteger operatorType ;

@property (nonatomic,assign)BOOL loadEnd ;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;
@property (nonatomic,strong)NSMutableDictionary *dicParams ;
@property (nonatomic,strong)NSDictionary *model ;

@end
@implementation ContractViewController

{
    NSInteger urlType ;
    
}
- (NSMutableDictionary *)dicParams {
    if (!_dicParams) {
        _dicParams = [NSMutableDictionary dictionary];
    }return _dicParams ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起合同";
    self.loadEnd = NO ;
    self.sureBtn.layer.cornerRadius = 5 ;
    self.sureBtn.layer.masksToBounds = YES ;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    _descriptTextView.delegate = self ;
    self.sureBtn.hidden = YES ;
    self.sureBtnStatus = 0 ;
    self.imageView1 = [self addImageViewOnPoint:CGPointZero];
    self.imageView2 = [self addImageViewOnPoint:CGPointZero];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy月MM日dd"];
    self.beginTimeLabel.text = [formatter stringFromDate:[NSDate date]];
    self.endTimeLabel.text = [formatter stringFromDate:[NSDate date]];
    self.employerLabel.text = @"";
    self.serviceLabel.text = @"";
    urlType = 1;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.beginTimeBtn setTitle:@"0000年00月00日" forState:UIControlStateNormal];
    [self.endTimeBtn setTitle:@"0000年00月00日" forState:UIControlStateNormal];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self requestContract];

    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.placeHolder.hidden = YES ;
    return YES ;
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    if (textView.text.length ==0 ) {
        self.placeHolder.hidden = NO ;
    }
    return YES ;
}
- (void)requestContract {
    
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.demand_id) {
            [dic setObject:self.demand_id forKey:@"demand_id"];
        }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=issue&op=step3" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {

            
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[showdata[@"doc_list"][@"doc_content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            self.protocalBtn.attributedText = attrStr ;
            self.loadEnd = YES ;
            
            urlType = [showdata[@"_demand"][@"demand_qb"] integerValue];
            if ([showdata[@"_contract"]isKindOfClass:[NSArray class]]) {
                self.model = [showdata[@"_contract"] firstObject];
            }else {
                self.model = showdata[@"_contract"];
            }
            [self viewDidLayoutSubviews];
        }
    }];
}


- (void)setModel:(NSDictionary *)model{

    
    _model = model;
    self.employerLabel.text = @"鸣医通平台" ;
    self.serviceLabel.text = self.model[@"member_truename"];
    if (self.model[@"contract_id"]) {
        if (self.model[@"contract_time"]) {
            [self.beginTimeBtn setTitle:[self stringFromTimeInterval:self.model[@"contract_time"]] forState:UIControlStateNormal];
        }
        if (self.model[@"contract_time1"]) {
            [self.endTimeBtn setTitle:[self stringFromTimeInterval:self.model[@"contract_time1"]]
                             forState:UIControlStateNormal];
        }
        self.beginTimeLabel.text = [self stringFromTimeInterval:self.model[@"ascertain_agree1"]];
        self.endTimeLabel.text = [self stringFromTimeInterval:self.model[@"ascertain_agree2"]];
        self.descriptTextView.text = self.model[@"contract_content"] ;
        self.placeHolder.hidden = YES ;
    }
    else {
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
        [dateformatter setDateStyle:NSDateFormatterMediumStyle];
        [dateformatter setDateFormat:@"yyyy-MM-dd "];
        NSString *dateString = [dateformatter stringFromDate:[NSDate date]];
        self.beginTimeLabel.text = dateString ;
        self.endTimeLabel.text = dateString ;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.model[@"ascertain_agree1"]){
        //表示商家已经签订了合同
        self.beginTimeBtn.enabled = NO ;
        self.endTimeBtn.enabled = NO ;
        self.descriptTextView.editable = NO ;
    }
}

- (NSString *)stringFromTimeInterval:(NSString *)timeIntervalString {

    
    NSInteger timeInterval = 0;
    
    NSDate *date ;
    if (timeIntervalString == nil
        || [timeIntervalString isEqual:[NSNull null]]|| [timeIntervalString isEqualToString:@""]) {
        date = [NSDate date];
    }else {
        timeInterval  = [timeIntervalString integerValue];
        date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd"];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ;
}

- (void)viewDidLayoutSubviews {

    CGFloat max_height = CGRectGetMaxY(self.sureBtn.frame);
    CGFloat height ;
    if (max_height <= HEIGHT - 64) {
        height = HEIGHT ;
    }
    else {
        height = CGRectGetMaxY(self.sureBtn.frame);
    }
    
    if (self.loadEnd) {
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.imageView1.center = self.employerLabel.center ;
            self.imageView2.center = self.serviceLabel.center ;
            if (self.model[@"ascertain_agree1"]){
                //表示已经加方已经签订合同
                    self.imageView1.alpha = 1;
            }
            if (![self.model[@"ascertain_state"]isEqual:[NSNull null]]) {
                if ([self.model[@"ascertain_state"] integerValue] == 0) {
                    self.sureBtn.hidden = NO;
                    self.imageView2.alpha = 0;
                }
                else {
                    self.imageView2.alpha = 1;
                    self.sureBtn.hidden = YES ;
                }
            }
    });
    }
       self.scrollView.contentSize = CGSizeMake(self.scrollView.width,height);
    
}
- (IBAction)sureBtnClick_Btn:(id)sender {
    //确定合同
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"demand_id"] = self.demand_id ;
    if ([YMUserInfo sharedYMUserInfo].member_id) {
        dic[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id ;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:[NSDate date]];
    dic[@"ascertain_agree2"] = str ;
    dic[@"ascertain2"] = self.model[@"member_truename"];
    
    NSString *url ;
    if (urlType == 3) {
        url = @"act=release_diseases&op=real_diseases4";
    }else {
        url = @"act=issue&op=agree3";
    }
    
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:url params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            [self.view showRightWithTitle:@"合同签订成功" autoCloseTime:2];
            [self.navigationController popViewControllerAnimated:YES];
            [self addImageViewe];
        }
    }];
}

- (void)addImageViewe {
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"contract"];
    imageView.bounds = CGRectMake(0, 0, self.view.width * 0.8, self.view.width * 0.8);
    imageView.center =  CGPointMake(self.view.width / 2,self.view.height /2);
    imageView.alpha = 0 ;
    [self.view addSubview:imageView];
    CGPoint endPoint = [self.backView convertPoint:_serviceLabel.center toView:self.view];
    [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:0.9 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        imageView.alpha = 1;
        imageView.bounds = CGRectMake(0, 0, imageView.image.size.width * 1.5,  imageView.image.size.height * 1.5);
            imageView.center = endPoint ;
        } completion:^(BOOL finished) {
            imageView.alpha =0 ;
            [imageView removeFromSuperview];
            self.imageView2.alpha = 1 ;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }];
}
- (UIImageView *)addImageViewOnPoint:(CGPoint)point {
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"contract"];
    imageView.bounds = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    imageView.center = point;
    imageView.alpha = 0 ;
    [self.backView addSubview:imageView];
    return imageView ;
}

@end
