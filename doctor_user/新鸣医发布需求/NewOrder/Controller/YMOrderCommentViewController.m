//
//  YMOrderCommentViewController.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMOrderCommentViewController.h"
#import "YMOfficialActivityTopView.h"

#import "YMTAContentTableViewCell.h"
#import "YMMyReplyTableViewCell.h"

#import "YMMyContentTableViewCell.h"

#import "YMCheckPingModel.h"

#import "YMDoctorCommentTableViewCell.h"

static NSString *const doctorContentCell= @"doctorContentCell";

static NSString *const myReplyDoctorCell= @"myReplyDoctorCell";

static NSString *const myContentViewCell = @"MyContentViewCell";

static NSString *const doctorCommentViewCell = @"doctorCommentViewCell";

@interface YMOrderCommentViewController ()<YMOfficialActivityTopViewDelegate,UITableViewDelegate,UITableViewDataSource,YMMyReplyTableViewCellDelegate>

@property(nonatomic,strong)YMOfficialActivityTopView *orderTopView;

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)UITableView *TaCommentTableView;

@property(nonatomic,strong)UITableView *myCommentTableView;

@property(nonatomic,assign)BOOL hiddenKey;

@property(nonatomic,strong)YMCheckPingModel *model;



@end

@implementation YMOrderCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看评价";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    _type = 1;
    // Do any additional setup after loading the view.
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
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    [self initView];
    [self requrtData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [self initOrderTopView];
    [self initTableView];
    
}


-(void)initOrderTopView{
    _orderTopView = [[YMOfficialActivityTopView alloc]init];
    _orderTopView.backgroundColor = [UIColor whiteColor];
    _orderTopView.delegate = self;
    _orderTopView.lefName = @"TA的评价";
    _orderTopView.rightName = @"我的评价";
    [self.view addSubview:_orderTopView];
    [_orderTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.left.top.right.equalTo(self.view);
    }];
}


-(void)initTableView{
    _TaCommentTableView = [[UITableView alloc]init];
    _TaCommentTableView.backgroundColor = [UIColor clearColor];
    _TaCommentTableView.delegate = self;
    _TaCommentTableView.dataSource = self;
    _TaCommentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_TaCommentTableView registerClass:[YMTAContentTableViewCell class] forCellReuseIdentifier:doctorContentCell];
    [_TaCommentTableView registerClass:[YMMyReplyTableViewCell class] forCellReuseIdentifier:myReplyDoctorCell];
    
    [_TaCommentTableView registerClass:[YMMyContentTableViewCell class] forCellReuseIdentifier:myContentViewCell];
    
    
    [_TaCommentTableView registerClass:[YMDoctorCommentTableViewCell class] forCellReuseIdentifier:doctorCommentViewCell];
    [self.view addSubview:_TaCommentTableView];
    [_TaCommentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(_orderTopView.mas_bottom);
    }];
}


-(void)requrtData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]
     sendRequstWith:@"act=new_order&op=checkPing"
     params:@{@"order_id":[NSString isEmpty:_order_id]?@"":_order_id}
     withModel:nil
     waitView:self.view
     complateHandle:^(id showdata, NSString *error) {
         if (showdata == nil) {
             return ;
         }
         
         if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
             weakSelf.model = [YMCheckPingModel modelWithJSON:showdata];
             [weakSelf.TaCommentTableView reloadData];
         }
     }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 1) {
        return (SCREEN_HEIGHT - 118)/2.f;
    }else{
        if (indexPath.section == 0) {
            return  [YMMyContentTableViewCell heightForContent:_model.user_hui forLabelAyy:_model.user_ping];
        }else{
          return  [YMDoctorCommentTableViewCell heightDoctorComment:_model.doctor_hui];
        }
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_type) {
        case 1:{
            if(indexPath.section == 0){
                YMTAContentTableViewCell *cell = [[YMTAContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:doctorContentCell];
                cell.model = _model;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                YMMyReplyTableViewCell *cell = [[YMMyReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myReplyDoctorCell];
                cell.delegate = self;
              
                cell.user_hui = _model.user_hui ;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
            
            break;
        case 2:{
            if (indexPath.section == 0) {
                YMMyContentTableViewCell *cell = [[YMMyContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myContentViewCell];
                cell.model = _model;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                YMDoctorCommentTableViewCell *cell = [[YMDoctorCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:doctorCommentViewCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = _model;
                return cell;
            }
        }
        default:
            return nil;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - YMOfficialActivityTopViewDelegate
-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView hallButton:(UIButton *)sender{
    [self keyboardWillHide];
    if (_type == 1) {
        return;
    }
    
    _type = 1;
    [_TaCommentTableView reloadData];

}

-(void)officialActivityView:(YMOfficialActivityTopView *)officialActivityView participateButton:(UIButton *)sender{
    [self keyboardWillHide];
    if (_type == 2) {
        return;
    }
    _type = 2;
    [_TaCommentTableView reloadData];
}

-(void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
//    int height = keyboardRect.size.height;
    [_TaCommentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardRect.size.height);
    }];
}



-(void)keyboardWillHide{
    [_TaCommentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


#pragma mark - YMMyReplyTableViewCellDelegate

-(void)MyReplyView:(YMMyReplyTableViewCell *)view commentStr:(NSString  *)commentStr submitButton:(UIButton *)sender{
    [self keyboardWillHide];
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=new_order&op=subHuifu" params:@{@"order_id":[NSString isEmpty:_order_id]?@"":_order_id,@"client":@"user",@"content":[NSString isEmpty:commentStr]?@"":commentStr} withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self requrtData];
    }];
    
//    [[KRMainNetTool sharedKRMainNetTool]
//     sendRequstWith:@"act=new_order&op=subHuifu"
//     params:@{@"order_id":[NSString isEmpty:_order_id]?@"":_order_id,@"client":@"user",@"content":[NSString isEmpty:commentStr]?@"":commentStr}
//     withModel:nil
//     waitView:self.view
//     complateHandle:^(id showdata, NSString *error) {
//         if (showdata == nil) {
//             return ;
//         }
////         [self requrtData];
//     }];
}

-(void)endEditing{
    [self keyboardWillHide];
    [self.view endEditing:YES];
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}


@end
