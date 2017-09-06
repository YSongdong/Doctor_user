//
//  YMActivitySignUpViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/16.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMActivitySignUpViewController.h"
#import "YMActivityBottomView.h"
#import "UIButton+LZCategory.h"
#import "YMDropDownView.h"
#import "YMSignUpAndDorctorModel.h"
#import "YMInfoBaseTableViewController.h"

static NSString *const signDescription = @"请在此描述您雨活动相对应的信息，为什么要参加本次活动，活动方会跟进您提过的资料进行资格审核。";

@interface YMActivitySignUpViewController ()<YMInfoBaseTableViewControllerDelegate,UITextViewDelegate>


@property(nonatomic,strong)UIView *participantsView;//参与视图

@property(nonatomic,strong)UITextView *descriptionTextView;//说明视图

@property(nonatomic,strong)UIButton *selectButton;

@property(nonatomic,strong)UILabel *selectLabel;

@property(nonatomic,strong)UIImageView *selectImageView;

@property(nonatomic,strong)UIView *intervalView;
@property(nonatomic,strong)NSString *leaguer_id;

//@property(nonatomic,strong)CustomTextField *customText;

@property(nonatomic,strong)UITextView *inputTextView;

@property(nonatomic,strong)UIView *inputView;

@property(nonatomic,strong)UILabel *tipLabel;


//@property(nonatomic,strong)YMSignUpAndDorctorModel *model;

@property(nonatomic,strong)NSMutableArray<YMSignUpAndDorctorModel *> *dropDownData;

@end

@implementation YMActivitySignUpViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(239, 239, 246);
    self.title = @"活动报名";
    [self initView];
    [self initVar];
//    [self requrtData];
}


-(void)initView{
    [self initNavigationRightView];
    
    [self initParticipantsView];
    
    _intervalView =[[UIView alloc]init];
    _intervalView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_intervalView];
    [_intervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_participantsView);
        make.top.equalTo(_participantsView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    [self initiInputView];
   
  
    
//    textField.layer.borderWidth = 1.0;
//    textField.layer.borderColor = [UIColor purpleColor].CGColor;
//    textField.layer.cornerRadius = textField.frame.size.height/2;
    
//    [self initdescriptionTextView];
}

-(void)initiInputView{

    _inputView = [[UIView alloc]init];
    _inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_intervalView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *descriptionLabel = [[UILabel alloc]init];
    descriptionLabel.text = @"个人说明: ";
    descriptionLabel.font = [UIFont systemFontOfSize:15];
    [_inputView addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputView.mas_left).offset(10);
        make.top.equalTo(_inputView.mas_top).offset(5);
    }];
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.numberOfLines = 0;
    _tipLabel.font = [UIFont systemFontOfSize:15];
    _tipLabel.text = signDescription;
    _tipLabel.textColor = RGBCOLOR(180, 180, 180);
    [_inputView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputView.mas_left).offset(10);
        make.right.equalTo(_inputView.mas_right).offset(-10);
        make.top.equalTo(descriptionLabel.mas_bottom).offset(5);
    }];
    
    
    _inputTextView = [[UITextView alloc]init];
    _inputTextView.backgroundColor = [UIColor clearColor];
    _inputTextView.font = [UIFont systemFontOfSize:15];
    _inputTextView.delegate = self;
    [_inputView addSubview: _inputTextView];
    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tipLabel.mas_left).offset(-2);
        make.right.equalTo(_tipLabel.mas_right).offset(2);
        make.top.equalTo(descriptionLabel.mas_bottom);
        make.bottom.equalTo(_inputView.mas_bottom);
    }];
}

-(void)initVar{
    _leaguer_id = @"";
    _dropDownData = [NSMutableArray array];
}
-(void)requrtData{
    
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=activities&op=apply" params:@{@"member_id":
                                                                                                @([[YMUserInfo sharedYMUserInfo].member_id integerValue])} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
                for (NSDictionary *dic in showdata) {
                    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
                    [muDic setDictionary:dic];
                    [muDic setValue:@0 forKey:@"showType"];
                    [weakSelf.dropDownData addObject:[YMSignUpAndDorctorModel modelWithJSON:dic]];
                }
        }
        
    }];
}


-(void)initNavigationRightView{
    UIView *rightBtnView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22 *2)];
    [rightBtnView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightBtnBigger = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightBtnBigger.backgroundColor = [UIColor clearColor];
    rightBtnBigger.titleLabel.font = [UIFont systemFontOfSize:17];

    [rightBtnBigger setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtnBigger addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnView addSubview:rightBtnBigger];
    [rightBtnBigger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightBtnView);
    }];
    [rightBtnBigger LZSetbuttonType:LZCategoryTypeBottom];
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


-(void)initParticipantsView{
    
    _participantsView = [[UIView alloc]init];
    _participantsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_participantsView];
    [_participantsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *titlabe = [[UILabel alloc]init];
    titlabe.text = @"参与对象:";
    titlabe.font = [UIFont systemFontOfSize:15];
    [_participantsView addSubview:titlabe];
    [titlabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.bottom.equalTo(_participantsView);
        make.width.mas_equalTo([titlabe intrinsicContentSize].width+5);
    }];
    
    _selectButton = [[UIButton alloc]init];
    
    _selectButton.titleLabel.font = titlabe.font;
   
    [_selectButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_participantsView addSubview:_selectButton];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_participantsView.mas_right);
        make.top.bottom.equalTo(_participantsView);
        make.width.mas_equalTo(80);
    }];
    
    _selectImageView = [[UIImageView alloc]init];
    _selectImageView.image = [UIImage imageNamed:@"dropdown_icon"];
    [_participantsView addSubview:_selectImageView];
    [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_participantsView.mas_centerY);
        make.height.width.mas_equalTo(22);
        make.right.equalTo(_participantsView.mas_right).offset(-10);
    }];
    
    _selectLabel = [[UILabel alloc]init];
    _selectLabel.textAlignment = NSTextAlignmentRight;
    _selectLabel.text = @"请选择:";
    _selectLabel.font = titlabe.font;
    _selectLabel.textColor = RGBCOLOR(180, 180, 180);
    [_participantsView addSubview:_selectLabel];
    [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_selectImageView.mas_left).offset(-5);
        make.top.bottom.equalTo(_participantsView);
        make.left.equalTo(titlabe.mas_right).offset(20);
    }];
    
}

-(void)selectButton:(UIButton *)sender{
    
    YMInfoBaseTableViewController *vc = [[YMInfoBaseTableViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
 
}

-(void)submitClick:(UIButton *)sender{
    
    NSString *descriptStr=_descriptionTextView.text;
   descriptStr = [descriptStr substringFromIndex:5];
    NSDictionary *params = @{@"member_id":@([[YMUserInfo sharedYMUserInfo].member_id integerValue]),
                             @"activity_id":self.activityId?:@"",
                             @"leaguer_id":![NSString isEmpty:_leaguer_id ]?@([_leaguer_id integerValue]):@"",
                             @"personal_statement":[NSString isEmpty:descriptStr]?@"":descriptStr};
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=activities&op=applySubmit" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        
         [self.view showRightWithTitle:@"报名成功" autoCloseTime:5];
        
        UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
        if (ctrl == nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}




#pragma mark - YMInfoBaseTableViewController
-(void)infoBaseController:(YMInfoBaseTableViewController *)infoBase userInfoModel:(YMUserInfoMemberModel *)informodel{
    _selectLabel.text = informodel.leagure_name;
    _selectLabel.textColor = RGBCOLOR(51, 51, 51);
    _leaguer_id = informodel.leaguer_id;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if (text.length == 0) {
        if (textView.text.length == 1) {
            _tipLabel.hidden = NO;
        }else{
            _tipLabel.hidden = YES;
        }
    }else{
        _tipLabel.hidden  = YES;
    }
    
    return YES;
}




@end
