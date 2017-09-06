//
//  TAEvaluateViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//


#import "TAEvaluateViewController.h"
#import "OrderHeadView.h"
#import "ContentView.h"
#import "NSString+Extention.h"

@interface TAEvaluateViewController ()<OrderHeadViewDelegate>
@property (weak, nonatomic) IBOutlet OrderHeadView *headView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet ContentView *contentView1;

@property (weak, nonatomic) IBOutlet UILabel *evaluateLabel;
@property (weak, nonatomic) IBOutlet UILabel *evalteTimeLabel;

@property (weak, nonatomic) IBOutlet ContentView *contentView2;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;

@property (weak, nonatomic) IBOutlet UILabel *feedBackTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *alertBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contrasctH;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,strong)NSDictionary *model ;

@end
@implementation TAEvaluateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headView setTitles:@[@"我的评价",@"TA对我的评价"]];
    self.headView.selectedIndex = 1;
    self.headView.delegate =self ;
    [self setup];
    
}

- (void)setup {
    [self request];
    self.contentView1.hidden = YES ;
    self.contentView2.hidden = YES ;
    self.scrollView.showsVerticalScrollIndicator = NO ;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self request];
 
}

- (void)viewDidLayoutSubviews {
    
       self.backgroundView.frame = CGRectMake(self.backgroundView.x, self.backgroundView.y, WIDTH, HEIGHT);
    self.scrollView.contentSize =CGSizeMake(WIDTH, self.backgroundView.height);
}
- (void)request {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.order_id) {
        dic[@"order_id"] = self.order_id ;
    }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=issue&op=step10" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        NSLog(@"%@",showdata);
        if (!error) {
            self.model = showdata [@"evaluate_goods"];
            if ([self.model count] > 0) {
                [self selectedIndexChangeRequest];
            }
            else {
                self.alertBtn.hidden  = NO ;
            }
        }
    }];
}

- (void)resetTextViewHeight:(NSString *)str {
    CGSize size = [str sizeWithBoundingSize:CGSizeMake(WIDTH - 20, 0) font:[UIFont systemFontOfSize:14]];
    self.contrasctH.constant = size.height + 20;
    [self.view layoutIfNeeded];
}

- (void)selectedIndexChangeRequest {
    if ([self.model count] < 1) {
        self.alertBtn.hidden  = NO ;
        return ;
    }
    //我的评价 他的回复
    if (_headView.selectedIndex == 0) {
        self.sureBtn.hidden = YES;
        if (!self.model[@"geval_frommembertime"] &&
            [self.model[@"geval_frommembertime"]isEqualToString:@""]) {
            //我还没有评价
            self.contentView1.hidden = YES ;
            self.contentView2.hidden = YES ;
            self.alertBtn.hidden  = NO ;
        }
        else{
            self.contentView1.hidden = NO ;
            self.evaluateLabel.text =  _model[@"geval_content"];
            self.evalteTimeLabel.text = [self stringFromTimeInterval:_model[@"geval_frommembertime"]];
            self.contentView1.selectedIndex = [_model[@"geval_scores"] integerValue];
            self.alertBtn.hidden = YES ;
            //表示商家已经回复了的
            if (self.model[@"sreply_time"] &&
                ![self.model[@"sreply_time"]isEqualToString:@""]) {
                [self resetTextViewHeight:self.model[@"geval_sreply"]];
                self.titleLabel.text = @"他的回复";
                self.feedbackTextView.text = self.model[@"geval_sreply"];
        self.feedBackTimeLabel.text =[self stringFromTimeInterval:self.model[@"sreply_time"]];
        self.feedbackTextView.userInteractionEnabled  = NO ;
        self.contentView2.hidden = NO ;
            }else{
                
                self.contentView2.hidden = YES ;
            }
        }
    }
    
    //geval_scores 我的评价
    //商家评价
    if (_headView.selectedIndex  == 1) {
        if (!self.model[@"geval_addtime"] &&
            [self.model[@"geval_addtime"]isEqualToString:@""]) {
            self.contentView1.hidden = YES ;
            self.contentView2.hidden  = YES ;
            self.alertBtn.hidden = NO ;
            self.sureBtn.hidden = YES ;
        }
        else{
            self.contentView1.hidden = NO ;
            self.contentView2.hidden = NO ;
             //表示商家已经评价
            self.alertBtn.hidden = YES ;
            self.contentView1.selectedIndex = [_model[@"geval_scores1"] integerValue];
            self.evaluateLabel.text = _model[@"geval_explain"];
            self.evalteTimeLabel.text = [self stringFromTimeInterval:_model[@"geval_addtime"]];
            //表示我已经回复
            if (self.model[@"mreply_time"] &&
                ![self.model[@"mreply_time"]isEqualToString:@""]) {
                [self resetTextViewHeight:self.model[@"geval_mreply"]];
                self.titleLabel.text = @"我的回复";
                self.feedbackTextView.text = self.model[@"geval_mreply"];
                self.feedBackTimeLabel.text =[self stringFromTimeInterval:_model[@"mreply_time"]];
                self.feedbackTextView.userInteractionEnabled = NO ;
            }
            else{
                self.sureBtn.hidden = NO ;
                self.feedBackTimeLabel.text = [self stringFromTimeInterval:nil];
            }
        }
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    [self.backgroundView endEditing:YES];
}
- (NSString *)stringFromTimeInterval:(NSString *)timeIntervalString {
  NSInteger timeInterval = [timeIntervalString integerValue];

    NSDate *date ;
    if (timeIntervalString == nil
        || [timeIntervalString isEqualToString:@""]) {
        date = [NSDate date];
    }
    else {
        date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ;
}
- (IBAction)didClickEvaluate:(id)sender {
    
}
- (IBAction)clickEvaluateUser:(id)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.feedbackTextView.text) {
        dic[@"geval_mreply"] = self.feedbackTextView.text ;
    }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
    dic[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id ;
    dic[@"order_id"] = self.order_id ;
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=issue&op=step11" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            [self.view showRightWithTitle:@"已成功回复至对方" autoCloseTime:2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
    
}

@end
