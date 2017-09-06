//
//  YMYINanViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMYINanViewController.h"
#import "YMSwitchTableViewCell.h"
#import "YMMoneyTableViewCell.h"
#import "YMInputTableViewCell.h"
#import "YMInputTExtViewTableViewCell.h"
#import "YMYinanImageTableViewCell.h"
#import "YMSexTableViewCell.h"
#import "AddressPickerView.h"
#import "KRShengTableViewController.h"
#import "YMPayView.h"
#import "YMOrderDetailViewController.h"

#import "YMInfoBaseTableViewController.h"
#import "YMUserInfoTableViewController.h"
#import "YMNetWorkTool.h"

#import "YMOrderViewController.h"

@interface YMYINanViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,YMInfoBaseTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;
@property (weak, nonatomic) IBOutlet UIView *bottomView; //view



@property (nonatomic, assign) NSInteger dateTag;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, strong) NSMutableArray *dataParam;
@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, assign) NSInteger imageTag;
@property (nonatomic, strong) NSMutableArray *haveImageArray;
@property (nonatomic, strong) NSDictionary *myData;
@property (nonatomic, strong) NSDictionary *sortDic;
@property(nonatomic,strong) UIButton *subBtn; //提交按钮
@end

@implementation YMYINanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBottomVivew];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.navigationItem.title = @"疑难杂症";
    self.haveImageArray = [NSMutableArray array];
    self.dataParam = [NSMutableArray array];
    self.param = [NSMutableDictionary dictionary];
    self.param[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];

    [self.tableView registerNib:[UINib nibWithNibName:@"YMSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"switch"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YMMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"money"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YMInputTableViewCell" bundle:nil] forCellReuseIdentifier:@"input"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addreeeChoice:) name:@"selectedAddress" object:nil];
    [self setDateView];
    [self loadData];
    [self loadOtherData];
   
}
//创建bottomview
-(void)initBottomVivew{

    self.bottomView.backgroundColor = [UIColor btnBroungColor];
    
    __weak __typeof(self)weakSelf = self;
    //提交按
    self.subBtn = [[UIButton alloc]init];
    [self.bottomView addSubview:self.subBtn];
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bottomView).offset(5);
        make.left.equalTo(weakSelf.bottomView.mas_left).offset(40);
        make.bottom.equalTo(weakSelf.bottomView.mas_bottom).offset(-5);
        make.right.equalTo(weakSelf.bottomView.mas_right).offset(-40);
    }];
    [self.subBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.subBtn setTitleColor:[UIColor btnText666Color] forState:UIControlStateNormal];
    self.subBtn.backgroundColor = [UIColor whiteColor];
    self.subBtn.layer.masksToBounds = YES;
    self.subBtn.layer.cornerRadius = 20;
    
    [self.subBtn addTarget:self action:@selector(subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addreeeChoice:(NSNotification *)notify {
    NSLog(@"%@",notify.object);
    self.param[@"area_id"] = notify.object[@"area_id"];
    self.param[@"area_name"] = notify.object[@"area_name"];
    [self.tableView reloadData];
}

- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=release_diseases&op=hire" params:nil withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        [self.dataParam addObject:@{@"lefttop":@"设置服务费:",@"leftbottom":[NSString stringWithFormat:@"%@",showdata[@"_store"][@"diseases_name"]],@"status":@"1"}];
        self.myData = [showdata copy];
        [self.tableView reloadData];
    }];
}

- (void)loadOtherData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=doctor_personal&op=sys_enum" params:nil withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.sortDic = [showdata copy];
    }];
}

- (void)setDateView {
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 315)];
    _dateView.backgroundColor = [UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 270)];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.backgroundColor = [UIColor whiteColor];
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 45)];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    cancle.titleLabel.textColor = [UIColor whiteColor];
    cancle.titleLabel.font = [UIFont systemFontOfSize:15];
    //[cancle setTitleColor:[UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1] forState:UIControlStateNormal];
    cancle.backgroundColor = [UIColor clearColor];
    cancle.tag = 100;
    [cancle addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 50, 0, 50, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tag = 101;
    button.titleLabel.textColor = [UIColor whiteColor];
    //_dateView.backgroundColor = [UIColor whiteColor];
    UIView *linview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    linview.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview];
    UIView *linview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 1)];
    linview1.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview1];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    //[button setTitleColor:[UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:button];
    [self.dateView addSubview:cancle];
    [self.dateView addSubview:self.datePicker];
    [self.view addSubview:self.dateView];
    UILabel *titlesLabel = [[UILabel alloc]init];
    [self.dateView addSubview:titlesLabel];
    titlesLabel.font = [UIFont systemFontOfSize:15];
    titlesLabel.text = @"请选择时间";
    titlesLabel.textColor = [UIColor whiteColor];
    [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(self.dateView.mas_top);
        make.centerX.equalTo(self.dateView.mas_centerX);
        make.width.lessThanOrEqualTo(@250);
    }];
}

- (void)selected:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.dateView.frame;
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
        }
        else {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
            self.tableView.scrollEnabled = YES;
        }
        self.dateView.frame = rect;
    }];
    if (sender.tag == 101) {
        NSDate *date = self.datePicker.date;
        if (self.dateTag == 2 || self.dateTag == 3) {
            
        } else {
            if ([date timeIntervalSinceNow] < 0) {
                [self showErrorWithTitle:@"请选择正确时间" autoCloseTime:2];
                return;
            }
        }

        NSDateFormatter *dateformatter = [NSDateFormatter new];
        dateformatter.dateFormat = @"yyyy年MM月dd日";
        NSDateFormatter *dateformatter1 = [NSDateFormatter new];
        dateformatter1.dateFormat = @"yyyy-MM-dd";
        if (self.dateTag == 2) {
            self.param[@"diagnosis_tim"] = [dateformatter stringFromDate:date];
            self.param[@"diagnosis_time"] = [dateformatter1 stringFromDate:date];
        } else if (self.dateTag == 3) {
            self.param[@"diagnosis_t"] = [dateformatter stringFromDate:date];
            self.param[@"diagnosis_times"] = [dateformatter1 stringFromDate:date];
        } else if (self.dateTag == 4) {
            self.param[@"diseases_tim"] = [dateformatter stringFromDate:date];
            self.param[@"diseases_time"] = [dateformatter1 stringFromDate:date];
        } else if (self.dateTag == 5) {
            self.param[@"diseases_t"] = [dateformatter stringFromDate:date];
            self.param[@"diseases_time2"] = [dateformatter1 stringFromDate:date];
        }
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
        case 4:
        {
          return 2;
        }
            break;
        
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1f;
    }else{
        return 10.f;
    }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.canClick = @"1";
                cell.vcType = @"1";
                cell.textType = @"1";
                [cell setDetailWithDic:@{@"name":@"就诊人：",@"placeholder":@"请选择"} dataDic:self.param];
                return cell;
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.canClick = @"1";
                cell.vcType = @"1";
                cell.textType = @"2";
                [cell setDetailWithDic:@{@"name":@"最近两次诊断：",@"placeholder":@"年    月    日"} dataDic:self.param];
               
                return cell;
            } else {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.canClick = @"1";
                cell.vcType = @"1";
                cell.textType = @"3";
                [cell setDetailWithDic:@{@"name":@"最近两次诊断：",@"placeholder":@"年    月    日"} dataDic:self.param];
                return cell;
            }
        
        }
            break;
        case 2:
        {
            YMYinanImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yinanImage"];
            [cell setDetailDataWith:self.param];
            cell.inpuBlock = ^(NSString *str) {
                self.param[@"title"] = str;
            };
            cell.block = ^(NSInteger tag) {
                self.imageTag = tag;
                
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //打开相机
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                        pickerController.delegate = self;
                        pickerController.allowsEditing = YES;
                        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:pickerController animated:YES completion:nil];
                    }
                    
                    
                }];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //打开相册
                    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                    pickerController.delegate = self;
                    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    pickerController.allowsEditing = YES;
                    [self presentViewController:pickerController animated:YES completion:nil];
                    
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
                    //取消
                }];
                if ([self.haveImageArray containsObject:@(tag)]) {
                    UIAlertAction *delet = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        //删除
                        NSMutableArray *nowArray = [NSMutableArray array];
                        NSMutableArray *mutArray = [self.param[@"images"] mutableCopy];
                        for (NSDictionary *dic in mutArray) {
                            if ([dic[@"tag"] integerValue] == tag) {
                                continue;
                            }
                            [nowArray addObject:dic];
                        }
                        self.param[@"images"] = nowArray;
                        [self.haveImageArray removeObject:@(tag)];
                        [self.tableView reloadData];
                        
                    }];
                    [controller addAction:delet];
                } else {
                    [self.haveImageArray addObject:@(tag)];
                }
                [controller addAction:action];
                [controller addAction:action1];
                [controller addAction:action2];
                
                [self.navigationController presentViewController:controller animated:YES completion:nil];
            };
            return cell;
        }
            break;
        case 3:
        {
            YMInputTExtViewTableViewCell *inputView = [tableView dequeueReusableCellWithIdentifier:@"inputView"];
            
            [inputView setUpWithDic:self.param];
            inputView.block = ^(NSString *str){
                self.param[@"diseases_content"] = str;
            };
            return inputView;
        }
            break;
        case 4:
        {
            if (indexPath.row == 0) {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.canClick = @"1";
                cell.vcType = @"1";
                cell.textType = @"4";
                [cell setDetailWithDic:@{@"name":@"就诊时间：",@"placeholder":@"年    月    日"} dataDic:self.param];
                return cell;
            } else {
                YMInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
                cell.canClick = @"1";
                cell.vcType = @"1";
                cell.textType = @"5";
                [cell setDetailWithDic:@{@"name":@" 至",@"placeholder":@"年    月    日"} dataDic:self.param];
                
                return cell;
            }
            
        }
            break;
           
        default:
            
            break;
    }
    return [UITableViewCell new];
}
#pragma mark - 键盘事件

- (void)openKeyBoard:(NSNotification *)notification {
    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableViewBottom.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (void)closeKeyBoard:(NSNotification *)notification {
    
    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    self.tableViewBottom.constant = 50;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //UIImage *newImage = [self thumbnaiWithImage:image size:CGSizeMake(170, 110)];
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSMutableArray *array = [self.param[@"images"] mutableCopy];
    if (!array) {
        array = [NSMutableArray array];
    }
    NSMutableArray *nowArray = [NSMutableArray array];
    NSMutableArray *tagArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [tagArray addObject:dic[@"tag"]];
    }
    if ([tagArray containsObject:@(self.imageTag)]) {
        for (NSDictionary *dic in array) {
            if ([dic[@"tag"] integerValue] == self.imageTag) {
                [nowArray addObject:@{@"tag":@(self.imageTag),@"image":image}];
            } else {
                [nowArray addObject:dic];
            }
        }
        array = [nowArray mutableCopy];
    } else {
        [array addObject:@{@"tag":@(self.imageTag),@"image":image}];
    }
    self.param[@"images"] = array;
   
    //[self.imageArray addObject:@{self.upOrDown:data}];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //第一次时间
            self.dateTag = 2;
            [self.view endEditing:YES];
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.dateView.frame;
                if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                    self.tableView.scrollEnabled = NO;
                }
                else {
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                    self.tableView.scrollEnabled = YES;
                }
                self.dateView.frame = rect;
            }];
        } else if (indexPath.row == 1) {
            //第二次时间
            self.dateTag = 3;
            [self.view endEditing:YES];
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.dateView.frame;
                if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                    self.tableView.scrollEnabled = NO;
                }
                else {
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                    self.tableView.scrollEnabled = YES;
                }
                self.dateView.frame = rect;
            }];
        }
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            //第一次时间
            self.dateTag = 4;
            [self.view endEditing:YES];
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.dateView.frame;
                if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                    self.tableView.scrollEnabled = NO;
                }
                else {
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                    self.tableView.scrollEnabled = YES;
                }
                self.dateView.frame = rect;
            }];
        } else if (indexPath.row == 1) {
            //第二次时间
            self.dateTag = 5;
            [self.view endEditing:YES];
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.dateView.frame;
                if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
                    self.tableView.scrollEnabled = NO;
                }
                else {
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height;
                    self.tableView.scrollEnabled = YES;
                }
                self.dateView.frame = rect;
            }];
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
#pragma mark --- 选择成员-----
-(void)infoBaseController:(YMInfoBaseTableViewController *)infoBase userInfoModel:(YMUserInfoMemberModel *)informodel{
    NSLog(@"用户ID：%@",informodel.leaguer_id);
    self.param[@"member_id"] =informodel.member_id;
    self.param[@"leaguer_id"] = informodel.leaguer_id;
    self.param[@"leaguer_name"] =informodel.leagure_name;
    
    [self.tableView reloadData];

}
#pragma mark ---- 按钮点击事件----
-(void)subBtnAction:(UIButton *) sender{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"member_id"] =self.param[@"member_id"];
    parm[@"leaguer_id"] = self.param[@"leaguer_id"];
    parm[@"title"] = self.param[@"title"];
    parm[@"diseases_content"] = self.param[@"diseases_content"];
    parm[@"diseases_time"] = self.param[@"diseases_time"];
    parm[@"diseases_time2"] = self.param[@"diseases_time2"];
    parm[@"diagnosis_time"] = self.param[@"diagnosis_time"];
    parm[@"diagnosis_times"] = self.param[@"diagnosis_times"];
    
    NSArray *imageArr = self.param[@"images"];
    if (imageArr.count > 0) {
        NSMutableArray *filesArr = [NSMutableArray array];
        
        for (int i=0; i<imageArr.count; i++) {
            
            NSDictionary *imgDic = imageArr[i];
            UIImage *img = imgDic[@"image"];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:img];
            NSString *imageStr = [NSString stringWithFormat:@"diseases_img%d",i];
            
            if (imageView.image != nil) {
                NSData *data = UIImageJPEGRepresentation(imageView.image, 0.1);
                NSDictionary *imgDict = @{@"data":data,@"image":imageStr};
                [filesArr addObject:imgDict];
            }
            
        }
        __weak typeof(self) weakSelf =  self;
        [[KRMainNetTool sharedKRMainNetTool] upLoadNewData:Diseases_Url params:parm.copy andData:filesArr complateHandle:^(id showdata, NSString *error) {
            if (!error) {
                
                YMOrderViewController *vc = [[YMOrderViewController alloc]init];
                
                vc.returnRoot = NO;
                
                vc.isYiNan = YES;
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                
                [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
            }
            
            
        }];
    }else{
    
        [self.view showErrorWithTitle:@"至少传一张图片" autoCloseTime:2];
    }
  

}

//- (IBAction)finishInput:(id)sender {
//    
//    __weak __typeof(self)weakSelf = self;
//
//    NSLog(@"self.param===========%@",self.param);
//    
//    NSMutableArray *imageDataArray = [NSMutableArray array];
//    NSArray *imageaArray = self.param[@"images"];
//    for (NSDictionary *dic in imageaArray) {
//        NSString *str = [NSString                               stringWithFormat:@"sickness_img%ld",[imageaArray indexOfObject:dic] + 1];
//        [imageDataArray addObject:@{@"name":str,@"data":UIImageJPEGRepresentation(dic[@"image"], 1)}];
//    }
//    if ([self.param[@"member_sex"] isEqualToString:@"男"]) {
//        self.param[@"member_sex"] = @"1";
//    } else {
//        self.param[@"member_sex"] = @"2";
//    }
//    
//    [YMNetWorkTool sendRequstWith:@"act=release_diseases&op=demand" params:self.param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error)
//    {
//    
//        if (showdata == nil) {
//            return ;
//        }
//        NSLog(@"showdata ********%@",showdata);
//        
//        if ([showdata isKindOfClass:[NSString class]]) {
//            if ([showdata isEqualToString: @"1"]) {
//                
//                //隐私资料
//                YMUserInfoTableViewController *vc = [MAIN_STORBOARD instantiateViewControllerWithIdentifier:@"userInfoView"];
//                vc.vcType = @"2";
//                [weakSelf.navigationController pushViewController:vc animated:YES];
//                return;
//            }
//        }
//        
//        if ([showdata isKindOfClass:[NSDictionary class]] && [showdata count] > 0) {
//            
//            YMPayView *payView = [[[NSBundle mainBundle]loadNibNamed:@"YMPayView" owner:self options:nil]firstObject];
//            payView.superVC = self;
//            payView.block = ^(long long staus) {
//                YMOrderDetailViewController *vc = [SECOND_STORBOARD instantiateViewControllerWithIdentifier:@"orderDetailView"];
//                vc.params = @{@"demand_id":@(staus),@"member_id":[YMUserInfo sharedYMUserInfo].member_id};
//                [self.navigationController pushViewController:vc animated:YES];
//            };
//            payView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//            if ([showdata[@"order_list"] isKindOfClass:[NSDictionary class]] && [showdata[@"order_list"] count] > 0) {
//                id moneyNumber = showdata[@"order_list"][@"order_amount"];
//                if ([moneyNumber isKindOfClass:[NSString class]] && moneyNumber != @"" && moneyNumber != nil) {
//                    [payView setDetailMoneyWith:moneyNumber andData:showdata];
//                }
//            }
//            [self.view.window addSubview:payView];
//            [payView setAnimaltion];
//        }
//    }];
//}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}

@end
