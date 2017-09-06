//
//  YMAddNewUserInforViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/25.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAddNewUserInforViewController.h"

#import "YMuserInforHeaderTableViewCell.h"
#import "YMTextFieldTableViewCell.h"
#import "YMContactAddressTableViewCell.h"
#import "YMPersonalUserInforModel.h"
#import "KRShengTableViewController.h"


static NSString *const userInforHeaderCell = @"userInforHeaderCell";

static NSString *const textFieldCell = @"textFieldCell";

static NSString *const contactAddress = @"contactAddress";

@interface YMAddNewUserInforViewController ()<UITableViewDelegate,UITableViewDataSource,YMContactAddressTableViewCellDelegate,YMTextFieldTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UITableView *userInforTableView;
@property(nonatomic,strong)UIButton *rightBtnBigger;

@property(nonatomic,strong)YMPersonalUserInforModel *userInforModel;

@property(nonatomic,assign)BOOL startEdit;

@property(nonatomic,strong)UIImage *headerImage;

//@property(nonatomic,strong)YMPersonalUserInforModel *inputInforModel;

//@property(nonatomic,strong)YMPersonalUserInforModel *model;

@property(nonatomic,strong)UIView *dateView;

@property(nonatomic,strong)UIDatePicker *datePicker;

@end

@implementation YMAddNewUserInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initView];
    [self initVar];
    
    if (![NSString isEmpty:self.leaguer_id]) {// 有成员ID才去请求
        [self requrtData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];

    
    [self addNavigationRightButton];
    [self initTableView];
}

-(void)initVar{
    _userInforModel = [[YMPersonalUserInforModel alloc]init];
//    _inputInforModel = [[YMPersonalUserInforModel alloc]init];
//    _userInforModel.member_pic = @"http://ys9958.com/data/upload/shop/avatar/avatar_1_new.jpg";
//    _userInforModel.member_name = @"张三";
//    _userInforModel.member_carId = @"341234********31231";
//    _userInforModel.member_sex = @"1";
//    _userInforModel.member_tel = @"123*12312312";
//    _userInforModel.member_occupation = @"掌柜";
//    _userInforModel.member_city = @"重庆";
//    _userInforModel.member_addres = @"重庆市大法师打发打发舒服";
    
}


-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_personal&op=getLeaguerDetail" params:@{@"leaguer_id":[NSString isEmpty:self.leaguer_id]?@"":self.leaguer_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]||[showdata isKindOfClass:[NSMutableDictionary class]]) {
            weakSelf.userInforModel = [YMPersonalUserInforModel modelWithJSON:showdata];
        
            [weakSelf.userInforTableView reloadData];
        }
    }];


}


-(void)addNavigationRightButton{
    UIView *rightBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22 *2)];
    [rightBtnView setBackgroundColor:[UIColor clearColor]];
    
    _rightBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    _rightBtnBigger.backgroundColor = [UIColor clearColor];
    _rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:17];
    [_rightBtnBigger setTitle:@"保存" forState:UIControlStateNormal];
    [_rightBtnBigger addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnView addSubview:_rightBtnBigger];
    [_rightBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightBtnView);
    }];
    [_rightBtnBigger LZSetbuttonType:LZCategoryTypeBottom];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -17;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightBarButtonItem];
    } else {
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
}


-(void)initTableView{
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    _userInforTableView = [[UITableView alloc]init];
    _userInforTableView.delegate = self;
    _userInforTableView.dataSource = self;
    _userInforTableView.backgroundColor = [UIColor clearColor];
    
    [_userInforTableView registerClass:[YMuserInforHeaderTableViewCell class] forCellReuseIdentifier:userInforHeaderCell];
    [_userInforTableView registerClass:[YMTextFieldTableViewCell class] forCellReuseIdentifier:textFieldCell];
    [_userInforTableView registerClass:[YMContactAddressTableViewCell class] forCellReuseIdentifier:contactAddress];
    
    
    _userInforTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_userInforTableView];
    [_userInforTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.section == 0 && indexPath.row == 0)||(indexPath.section == 2 && indexPath.row == 2)) {
        return 80;
    }
    return 50;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1){
        return 2;
    }else{
        return 3;
    }
  //  return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                YMuserInforHeaderTableViewCell *cell = [[YMuserInforHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userInforHeaderCell];
                [cell drawBottomLine:10 right:0];
                
                cell.headerImagUrl = _userInforModel.leaguer_img;
                if (_headerImage) {
                    cell.headerImag = _headerImage;
                }
                
                return cell;
            }
                break;
                
            default:{
                YMTextFieldTableViewCell *cell = [[YMTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCell];
                if (indexPath.row == 1) {
                    cell.titleName = @"真实姓名:";
                    cell.inputTextFieldName = _userInforModel.leagure_name;
                    cell.textFieldPlaceholder = @"请输入您的真实姓名(必填)";
                    cell.textFieldTag = 1;
                }else{
                    cell.titleName = @"身份证号:";
                    cell.inputTextFieldName = _userInforModel.leagure_idcard;
                    cell.textFieldPlaceholder = @"请输入您的身份证号码(必填)";
                    cell.textFieldTag = 2;
                }
                
                cell.delegate = self;
                cell.showTextfield = YES;
                if (indexPath.row == 2) {
                    [cell drawBottomLine:0 right:0];
                }else{
                    [cell drawBottomLine:10 right:0];
                }
                return cell;
            }
                break;
        }
    }else if(indexPath.section == 1){
        YMTextFieldTableViewCell *cell = [[YMTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCell];
        cell.delegate = self;
        if (indexPath.row == 0) {
            cell.titleName = @"性        别:";
            cell.subTitleName = _userInforModel.leagureSexChinese;
            cell.showTextfield = NO;
            [cell drawBottomLine:10 right:0];

        }else if(indexPath.row == 1){
            cell.textFieldTag = 3;
            cell.titleName = @"联系电话:";
            cell.textFieldPlaceholder = @"请输入您的联系电话(必填)";
            cell.showTextfield = YES;
            cell.inputTextFieldName = _userInforModel.leagure_mobile;
            [cell drawBottomLine:0 right:0];
        }
        return cell;
    }else{
        switch (indexPath.row) {
            case 2:{
                YMContactAddressTableViewCell *cell = [[YMContactAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactAddress];
                cell.delegate =self;
                cell.addressStr = _userInforModel.leagure_addr;
                [cell drawBottomLine:0 right:0];
                return cell;
            }
                break;
                
            default:{
                YMTextFieldTableViewCell *cell = [[YMTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCell];
                cell.delegate =self;
                if (indexPath.row == 1) {
                    cell.titleName = @"所在城市:";
                    cell.showTextfield = NO;
                    cell.subTitleName = _userInforModel.leaguer_area_name;
                }else{
                    cell.textFieldTag = 4;
                    cell.titleName = @"职        业:";
                    cell.textFieldPlaceholder = @"请输入您的职业以供医生参考";
                    cell.showTextfield = YES;
                    cell.inputTextFieldName = _userInforModel.leagure_profession;
                }
                [cell drawBottomLine:10 right:0];
                return cell;
            }
                break;
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self keyboardWillHide];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
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
            [controller addAction:action];
            [controller addAction:action1];
            [controller addAction:action2];
            
            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
    }else if(indexPath.section == 1) {
        if(indexPath.row == 0){
            
            __weak typeof(self) weakSelf = self;
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                weakSelf.userInforModel.leagure_sex = @"1";
                [weakSelf.userInforTableView reloadData];
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                _userInforModel.leagure_sex = @"2";
                [weakSelf.userInforTableView reloadData];
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
                //取消
            }];
            [controller addAction:action];
            [controller addAction:action1];
            [controller addAction:action2];
            
            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
    }else{
        if (indexPath.row ==1) {
            KRShengTableViewController *controller = [[KRShengTableViewController alloc]init];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addreeeChoice:) name:@"selectedAddress" object:nil];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    
}

- (void)addreeeChoice:(NSNotification *)notify {
    _userInforModel.leaguer_area_name  =notify.object[@"area_name"];
    _userInforModel.leagure_city = notify.object[@"area_id"];
    [self.userInforTableView reloadData];
}



#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _headerImage = image;
    
    
    //UIImage *newImage = [self thumbnaiWithImage:image size:CGSizeMake(170, 110)];
    
//    NSData *data = UIImageJPEGRepresentation(image, 0.1);
//
//    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
//    tool.isShow = @"2";
//    [tool upLoadData:@"act=doctor_page&op=avatar" params:@{@"member_id":[YMUserInfo sharedYMUserInfo].member_id} andData:@[@{@"name":@"member_avatar",@"data":data}] waitView:self.view complateHandle:^(id showdata, NSString *error) {
//        if (showdata == nil) {
//            return ;
//        }
//        [self showRightWithTitle:@"上传成功" autoCloseTime:2];
//        
//        [self performSelector:@selector(loadData) withObject:nil afterDelay:2];
//        //[self loadData];
//    }];
    
    //[self.imageArray addObject:@{self.upOrDown:data}];
    [_userInforTableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - YMContactAddressTableViewCellDelegate

-(void)contactaddress:(UITextView *)textView editContent:(NSString *)editContent{
    _userInforModel.leagure_addr = editContent;
}


#pragma mark - YMTextFieldTableViewCellDelegate

-(void)textFieldCell:(YMTextFieldTableViewCell *)textField startEdit:(BOOL)startEdit{
    [self keyboardWillHide];
}

-(void)textFieldCell:(UITextField *)textField inputChange:(NSString *)inputStr{
    
    
    switch (textField.tag) {
        case 1:{//姓名
            _userInforModel.leagure_name = inputStr;
//            _inputInforModel.member_name = inputStr;
        }
            break;
        case 2:{//身份证
            _userInforModel.leagure_idcard = inputStr;
//             _inputInforModel.leagure_idcard = inputStr;
        }
            break;
        case 3:{//联系电话
            _userInforModel.leagure_mobile = inputStr;
//             _inputInforModel.leagure_mobile = inputStr;
        }
            break;
        case 4:{//职业
            _userInforModel.leagure_profession = inputStr;
//            _inputInforModel.leagure_profession = inputStr;
        }
            break;
        default:
            break;
    }
}


- (void)setDateView {
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 315)];
    _dateView.backgroundColor = [UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 270)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
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
            self.userInforTableView.scrollEnabled = YES;
        }
        self.dateView.frame = rect;
    }];
    if (sender.tag == 101) {
        NSDate *date = self.datePicker.date;
        if ([date timeIntervalSinceNow] > 0) {
            [self showErrorWithTitle:@"请选择正确时间" autoCloseTime:2];
            return;
        }
       
        NSDateFormatter *dateformatter = [NSDateFormatter new];
        dateformatter.dateFormat = @"yyyy-MM-dd";
        _userInforModel.leagure_birth = [dateformatter stringFromDate:date];
        [_userInforTableView reloadData];
    }
    
}




-(void)saveClick:(UIButton *)sender{
    NSLog(@"保存按钮点击");
    [self keyboardWillHide];
    __weak typeof(self) weakSelf = self;
    NSData *imageData;
    NSString *imageFormat;
    if (UIImagePNGRepresentation(_headerImage) != nil) {
        imageFormat = @"Content-Type: image/png \r\n";
        imageData = UIImagePNGRepresentation(_headerImage);
    }else{
        imageFormat = @"Content-Type: image/jpeg \r\n";
        imageData = UIImageJPEGRepresentation(_headerImage, 1.0);
        
    }
    

    NSDictionary *params = @{@"leaguer_id":_userInforModel.leaguer_id,
                             @"member_id":[YMUserInfo sharedYMUserInfo].member_id,
                             @"leagure_name":_userInforModel.leagure_name,
                             @"leagure_sex":_userInforModel.leagure_sex,
                             @"leagure_idcard":_userInforModel.leagure_idcard,
                             @"leagure_mobile":_userInforModel.leagure_mobile,
                             @"leagure_profession":_userInforModel.leagure_profession,
                             @"leagure_city":_userInforModel.leagure_city,
                             @"leagure_addr":_userInforModel.leagure_addr,
                             @"leaguer_img":_headerImage?imageData:@""};

    
    
    KRMainNetTool *tool = [KRMainNetTool sharedKRMainNetTool];
    tool.isShow = @"2";
    [tool upLoadData:@"act=users_personal&op=saveLeaguer" params:params andData:@[@{@"name":@"leaguer_img",@"data":imageData?:@""}] waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        UIViewController *ctrl = [[weakSelf navigationController] popViewControllerAnimated:YES];
        if (ctrl == nil) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

-(void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSLog(@"%f",keyboardRect.size.height);
    [_userInforTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardRect.size.height);
    }];
}



-(void)keyboardWillHide{
    [_userInforTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - 隐藏键盘
-(void)keyboardHide{
    [self keyboardWillHide];
    [self.view endEditing:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}

@end

