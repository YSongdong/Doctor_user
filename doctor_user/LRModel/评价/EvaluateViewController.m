//
//  EvaluateViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "EvaluateViewController.h"
#import "EvaluateTableViewCell.h"

@interface EvaluateViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *evaluateBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSDictionary *dic ;
@property (nonatomic,strong)NSMutableDictionary *params ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@end

@implementation EvaluateViewController


- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}


- (void)setUp {
    
    _tableView.estimatedRowHeight = 100 ;
    _tableView.sectionFooterHeight = 10 ;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.order_id) {
        dic[@"order_id"] = self.order_id ;
    }
    if (self.store_id) {
        dic[@"store_id"] = self.store_id;
    }
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=issue&op=step8" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        self.dic = showdata[@"_order"];
        
        
        [self.tableView reloadData];
    }];
}

- (IBAction)submitEvaluate:(id)sender {
    
    EvaluateTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (self.order_id) {
        self.params[@"order_id"] = self.order_id ;
    }
    self.params[@"member_name"] = self.dic[@"member_name"];
    [self.params setObject:@(cell.selectedIndex + 1) forKey:@"geval_scores"];
    if ([YMUserInfo sharedYMUserInfo].member_id) {
        self.params[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id ;
    }
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool sendRequstWith:@"act=issue&op=step9" params:self.params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            [self.view showRightWithTitle:@"提交评价成功" autoCloseTime:2];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [self.tableView tableViewDisplayWitMsg:@"请求数据失败" ifNecessaryForRowCount:[self.dic count]];
    if (self.dic && [self.dic count] > 0 ) {
        return 2 ;
    }
    return 0 ;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EvaluateTableViewCell *cell ;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"orderSnTableCellIdentifier"];
        cell.type = cellTypeOrder ;
        cell.model = self.dic ;
    }
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EvalauateContentIdentifier"];
        cell.finishBlock = ^(NSString *content) {
            self.params[@"comment"] = content;
            
        };
        cell.type = cellTypeComment;
    }
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 0.0001f ;
}
- (void)keyBoardWillShow:(NSNotification *)notification {
    
    
    
//  CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    
//      NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    [UIView animateWithDuration:durations animations:^{
//        
//        self.tableView scrollRectToVisible:<#(CGRect)#> animated:<#(BOOL)#>
//    }];
    
  
 
}
- (void)keyBoardWillHidden:(NSNotification *)notification {
    
//    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
//    self.tableViewBottom.constant = 50;
//    [UIView animateWithDuration:durations delay:0 options:options animations:^{
//        [self.view layoutIfNeeded];
//    } completion:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}


@end
