//
//  AccountViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BankListViewController.h"
#import "AccountCollectionViewCell.h"
#import "NSString+LK.h"
//#import "PersonViewModel.h"
@interface BankListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *dataList ;

//@property (nonnull,strong,nonatomic)PersonViewModel *viewModel ;

@end

@implementation BankListViewController


- (void)dealloc {
    
    //[self.viewModel removeObserver:self forKeyPath:@"billLists"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  [self setUP];
//    [self.viewModel addObserver:self forKeyPath:@"billLists"
//options:NSKeyValueObservingOptionNew context:nil];
    
}



- (void)viewWillAppear:(BOOL)animated {
    
//    [super viewWillAppear:animated];
//    if (![self getMember_id]) {
//        [self alertViewShow:@"获取账户信息失败"];
//        return ;
//    }

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
        [dic setObject:[YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=users_account&op=cards_list" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        self.dataList = showdata ;
        [self.collectionView reloadData];
    }];
}
- (void)setUP {
    
     UIBarButtonItem *myButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = myButton;
    UICollectionViewFlowLayout *layout =  (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout ;
    layout.itemSize = CGSizeMake(self.view.frame.size.width - 40, 130);
    layout.minimumLineSpacing = 20 ;
    
    
  //  layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 20);
}


- (void)clickEvent {
    
    [self performSegueWithIdentifier:@"addbankCard" sender:nil];
    
}

- (void)rightButtonClickOperation {
    
    [self performSegueWithIdentifier:@"addBankCarIdentifier" sender:nil];
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1 ;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataList count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    AccountCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"accountCollectionViewCellIdentifier" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.item];
    __weak typeof(self)weakSelf = self ;
    [cell deleteCellBlock:^(AccountCollectionViewCell *selectedCell) {
    NSIndexPath *indexpaths = [collectionView indexPathForCell:selectedCell];
    [self.dataList mutableCopy];
        
        [self alertViewControllerShowWithTitle:@"是否确定删除银行卡"
                                       message:nil
                                     sureTitle:@"确定"
                                   cancelTitle:@"取消"
                                andHandleBlock:^(id value, NSString *error) {
            
                                    if (value ) {
                                        
                                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                                        [dic setObject:[YMUserInfo sharedYMUserInfo].member_id forKey:@"member_id"];
                                        
                                        NSDictionary *data =  weakSelf.dataList[indexpaths.item];
                                        if (data[@"id"]) {
                                            [dic setObject:data[@"id"] forKey:@"card_id"];
                                        }
                                        dispatch_async(dispatch_queue_create("delete.banklist", DISPATCH_QUEUE_CONCURRENT), ^{
                                            [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_account&op=card" params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                                                if (!error) {
                                                    NSMutableArray *array = [weakSelf.dataList mutableCopy];
                                                    [array removeObjectAtIndex:indexpaths.item];
                                                    weakSelf.dataList = array ;
                                                    [collectionView deleteItemsAtIndexPaths:@[indexpaths]];
                                                }
                                                //失败
                                                else {
                                                }
                                            }];
                                        });
                                    }
            
        }];
        //删除银行卡
        
    }];
    return  cell ;
}

- (void)alertViewControllerShowWithTitle:(NSString *)title message:(NSString *)message sureTitle:(NSString *)sureTitle cancelTitle:(NSString *) cancelTitle andHandleBlock:(void(^)(id  value,NSString  *error))commplete {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        commplete(@(1),nil);
        
    }];
    [alertVC addAction:action];
    
    if (cancelTitle != nil) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            commplete(nil,@"0");
        }];
        [alertVC addAction:action1];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


@end
