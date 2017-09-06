//
//  AddHistoryViewController.m
//  doctor_user
//
//  Created by dong on 2017/8/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "AddHistoryViewController.h"
#import "SDCustomTextField.h"


@interface AddHistoryViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectdTimeBtn; //时间选择
- (IBAction)selectdTimeBtnAction:(UIButton *)sender;

@property (strong, nonatomic)  SDCustomTextField *drugDetaTF;//病详情

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView; //第一张图
@property (weak, nonatomic) IBOutlet UIButton *oneDelBtn; //第一删除按钮
- (IBAction)oneDelBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;

@property (weak, nonatomic) IBOutlet UIButton *twoDelBtn;

- (IBAction)twoDelBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;

@property (weak, nonatomic) IBOutlet UIButton *threeDelBtn;

- (IBAction)threeDelBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *fourImageView;

@property (weak, nonatomic) IBOutlet UIButton *fourDelBtn;

- (IBAction)fourDelBtnAction:(UIButton *)sender;

@property(nonatomic,strong)UIView *dateView;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong) NSMutableDictionary *params; //配置字典

@property (nonatomic,assign) NSInteger imageTag; //记录imagetag
@property (nonatomic,strong) NSMutableArray *imgUrlArr; //装imgUrl数组

@property (nonatomic,assign) BOOL  isInitTime; //是否创建时间


@end

@implementation AddHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增历史";
    self.isInitTime = YES;
    self.view.backgroundColor = [UIColor cellBackgrounColor];
    [self updateUI];
    [self initNaviRight];
    
}
-(void)initNaviRight{

    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn addTarget:self action:@selector(onSaveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

}

-(void)updateUI{

    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onCameraTap)];
    [_oneImageView addGestureRecognizer:tapGest];
    UITapGestureRecognizer *twoGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTwoCameraTap)];
    [_twoImageView addGestureRecognizer:twoGest];
    UITapGestureRecognizer *threeGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onThreeCameraTap)];
    [_threeImageView addGestureRecognizer:threeGest];
    UITapGestureRecognizer *fourGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onFourCameraTap)];
    [_fourImageView addGestureRecognizer:fourGest];
    
    //textf
    self.drugDetaTF = [[SDCustomTextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.selectdTimeBtn.frame)+5, SCREEN_WIDTH-20, 40) placeholder:@"请在此描述就医详情" clear:NO leftView:nil fontSize:14];
    self.drugDetaTF.delegate = self;
    [self.view addSubview:self.drugDetaTF];
    [self.drugDetaTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}
-(void)onCameraTap{
    self.imageTag =1;
    [self creareCamera];
    
}
-(void)onTwoCameraTap{
     self.imageTag =2;
    [self creareCamera];
    
}
-(void)onThreeCameraTap{
     self.imageTag =3;
    [self creareCamera];
    
}
-(void)onFourCameraTap{
     self.imageTag =4;
    [self creareCamera];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    [_dateView removeFromSuperview];
    self.isInitTime = YES;

}

-(void)setMember_id:(NSString *)member_id{

    _member_id = member_id;

}
-(void)setHealth_id:(NSString *)health_id{

    _health_id= health_id;
}


#pragma mark ---- 按钮点击事件-----
//保存
-(void)onSaveBtnAction:(UIButton *)sender{
    [self requestSaveHistData];
   
}
//时间选择
- (IBAction)selectdTimeBtnAction:(UIButton *)sender {
    
    if (self.isInitTime) {
        [self setDateView];
        self.isInitTime = NO;
    }
    
    
}
//删除
- (IBAction)oneDelBtnAction:(UIButton *)sender {
    _oneImageView.image = [UIImage imageNamed:@"healthy_placeholder"];
    self.oneDelBtn.hidden = YES;
}
- (IBAction)twoDelBtnAction:(UIButton *)sender {
     _twoImageView.image = [UIImage imageNamed:@"healthy_placeholder"];
    self.twoDelBtn.hidden = YES;
}
- (IBAction)threeDelBtnAction:(UIButton *)sender {
     _threeImageView.image = [UIImage imageNamed:@"healthy_placeholder"];
    self.threeDelBtn.hidden = YES;
}
- (IBAction)fourDelBtnAction:(UIButton *)sender {
     _fourImageView.image = [UIImage imageNamed:@"healthy_placeholder"];
    self.fourDelBtn.hidden = YES;
}

-(void)creareCamera{
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
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //把url地址放到数组中
    NSURL *url =info[UIImagePickerControllerReferenceURL];
    [self.imgUrlArr addObject:url];
    
    switch (self.imageTag) {
        case 1:
            _oneImageView.image =image;
            self.oneDelBtn.hidden = NO;
            break;
        case 2:
              _twoImageView.image =image;
            self.twoDelBtn.hidden = NO;
            break;
        case 3:
              _threeImageView.image =image;
            self.threeDelBtn.hidden = NO;
            break;
        case 4:
              _fourImageView.image =image;
            self.fourDelBtn.hidden = NO;
            break;
        default:
            break;
    }
  
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  --- 创建时间选择器 ----
- (void)setDateView {
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-315, [UIScreen mainScreen].bounds.size.width, 315)];
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
           
        }
        self.dateView.frame = rect;
    }];
    if (sender.tag == 101) {
        NSDate *date = self.datePicker.date;
//        if ([date timeIntervalSinceNow] < 0) {
//            [self showErrorWithTitle:@"请选择正确时间" autoCloseTime:2];
//            return;
//        }
        NSDateFormatter *dateformatter = [NSDateFormatter new];
        dateformatter.dateFormat = @"yyyy年MM月dd日";
        NSDateFormatter *dateformatter1 = [NSDateFormatter new];
        dateformatter1.dateFormat = @"yyyy-MM-dd";
        [_selectdTimeBtn setTitle:[dateformatter stringFromDate:date] forState:UIControlStateNormal];
        self.params[@"history_time"] =[dateformatter1 stringFromDate:date];
        
    }
    self.isInitTime = YES;
}

-(NSMutableDictionary *)params{

    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;

}
-(NSMutableArray *)imgUrlArr{

    if (!_imgUrlArr) {
        _imgUrlArr = [NSMutableArray array];
    }
    return _imgUrlArr;

}

#pragma mark  --- UITextFeildDelegate---
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.drugDetaTF) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 100) {
            return NO;
        }
    }
    
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.drugDetaTF) {
        if (textField.text.length > 100) {
            textField.text = [textField.text substringToIndex:100];
        }
    }
}



#pragma mark   ---- 数据相关 ------
-(NSString *)getImgName{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"image_%f.jpg", a];
    return timeString;
}
-(void)requestSaveHistData{
    
    self.params[@"member_id"] = self.member_id;
    self.params[@"health_id"] = self.health_id;
    self.params[@"title"] = self.drugDetaTF.text;
  
    NSMutableArray *filesArr = [NSMutableArray array];
    
    for (int i=0; i<4; i++) {
        UIButton *btn = [self.view viewWithTag:(200+i)];
        //判断是否选择图片
        if (!btn.hidden) {
            UIImageView *imageView = [self.view viewWithTag:(100+i)];
            NSString *imageStr = [NSString stringWithFormat:@"image%d",i+1];
            
            if (imageView.image != nil) {
                NSData *data = UIImageJPEGRepresentation(imageView.image, 0.1);
                NSDictionary *imgDict = @{@"data":data,@"image":imageStr};
                [filesArr addObject:imgDict];
            }
        }
        
    }
    __weak typeof(self) weakSelf = self;
   [[KRMainNetTool sharedKRMainNetTool] upLoadNewData:HealthAides_Url params:self.params.copy andData:filesArr complateHandle:^(id showdata, NSString *error) {
       
       if (!error) {
            NSMutableString *history_image = [NSMutableString string];
            for (int i=0; i<self.imgUrlArr.count; i++) {
                NSString *url =[NSString stringWithFormat:@"%@",self.imgUrlArr[i]];
                [history_image appendString:url];
                if (i<self.imgUrlArr.count-1) {
                   [history_image appendString:@","];
                }
            }
           self.params[@"history_image"] = history_image.mutableCopy;
           if ([self.delegate respondsToSelector:@selector(selectdSaveBtn:)]) {
              [self.delegate selectdSaveBtn:self.params.copy];
              [self.navigationController popViewControllerAnimated:YES];
          }
    
       }else{
           
           [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
       }
       
   }];


}






@end
