//
//  WithDrawViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "WithDrawViewController.h"
#import "WithDrawCell.h"
//#import "PersonViewModel.h"
#import "AddAccountViewController.h"
//#import "WithDrawSureViewController.h"
#import "BindAlipayViewController.h"
@interface WithDrawViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic,strong)PersonViewModel *viewModel ;
@property (nonatomic,strong)NSArray *dataList ;

@end

@implementation WithDrawViewController
-(void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.sectionFooterHeight = 0.0001f ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}
- (void)setup {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([YMUserInfo sharedYMUserInfo].member_id) {
        [dic setObject:[YMUserInfo sharedYMUserInfo].member_id
                forKey:@"member_id"];
    }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=cards_list" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            self.dataList  = showdata ;
            
            [self.tableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return [self.dataList count]
        ;
    }
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2 ;
}


- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UILabel *view = [UILabel new];
        view.frame = CGRectMake(20, 0, self.view.width, 40);
        view.font = [UIFont systemFontOfSize:17];
       view.textColor = [UIColor hightBlackClor];
        view.text = @"  选择到账账户";
        
        return view ;
    }
    return nil ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"withDrawCellIdentifier"];
    if (indexPath.section == 0) {
        if ( self.dataList &&
            indexPath.row <= [self.dataList count] -1) {
            
        NSDictionary *dic = self.dataList[indexPath.row];
            NSString *subString = dic[@"card_num"];
            NSString *str = [subString substringFromIndex:subString.length - 4];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@...（尾号:%@)",dic[@"name"],str];
            cell.nameLabel.textColor = [UIColor colorWithRGBHex:0x4B4B4B];
            cell.nameLabel.font = [UIFont systemFontOfSize:15];
        }
//        }else {
//            cell.nameLabel.text = @"支付宝";
//            cell.nameLabel.textColor = [UIColor hightBlackClor];
//            cell.nameLabel.font = [UIFont systemFontOfSize:17 weight:1];
//        }
    }
    if (indexPath.section == 1) {
        cell.nameLabel.textColor = [UIColor hightBlackClor];
        cell.nameLabel.text = @"┼ 添加新银行卡";
    }
    return cell ;
}



- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 ;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 40 ;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //判断是否绑定支付宝
        //支付宝
//        if ( [self.dataList count] == 0 || (indexPath.row == [self.dataList count]
//            && [self.dataList count] > 0)) {
//            [self performSegueWithIdentifier:@"bindAlipayIdentifier" sender:nil];
//        }
        
            if (self.block){
                self.block(self.dataList[indexPath.row]);
            }
            [self.navigationController popViewControllerAnimated:YES];
        
    }
    if (indexPath.section == 1) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"addAccount"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    
//    if ([segue.identifier isEqualToString:@"bindAlipayIdentifier"]) {
//        
//        BindAlipayViewController *vc = segue.destinationViewController ;
//        if (self.ways == 1) {
//            vc.ways = 1;
//        }
//    }
}



- (void)choiceBankName:(returnBankNameBlock)block {
    _block = block ;
}


@end
