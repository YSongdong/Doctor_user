//
//  SDHealthyFilesViewController.m
//  doctor_user
//
//  Created by dong on 2017/8/10.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDHealthyFilesViewController.h"


#import "SDCircumstFilesTableViewCell.h"
#import "SDSomkeReactionTableViewCell.h"

#import "SDHealthyFilesModel.h"




#define SDCIRCUMSTFILESTABLEVIEW_CELL  @"SDCircumstFilesTableViewCell"
#define SDSOMKEREACTIONTABLEVIEW_CELL  @"SDSomkeReactionTableViewCell"
@interface SDHealthyFilesViewController ()<UITableViewDelegate,UITableViewDataSource,SDCircumstFilesTableViewCellDelegate>

@property(nonatomic,strong) UITableView *filesTableView;
@property (nonatomic,strong) SDHealthyFilesModel *model;

@property (nonatomic,strong) NSMutableDictionary *param; //保存数据

@end

@implementation SDHealthyFilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健康档案";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNaviRight];
    [self createTableView];
    [self requestFilesData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHealthShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHealthyHide)  name:UIKeyboardWillHideNotification  object:nil];
}
-(void)initNaviRight{
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn addTarget:self action:@selector(onSaveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)createTableView{

    self.filesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.filesTableView];
    self.filesTableView.dataSource = self;
    self.filesTableView.delegate = self;

    
    [self.filesTableView registerNib:[UINib nibWithNibName:SDCIRCUMSTFILESTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDCIRCUMSTFILESTABLEVIEW_CELL];
    [self.filesTableView registerNib:[UINib nibWithNibName:SDSOMKEREACTIONTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDSOMKEREACTIONTABLEVIEW_CELL];

}

#pragma mark  --- UITableViewSoucre
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 6;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SDCircumstFilesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDCIRCUMSTFILESTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        if ([self.model.smoking isEqualToString:@""]) {
            cell.smoking  = @"1";
        }else{
            cell.smoking = self.model.smoking;
        }
        if ([self.model.drink isEqualToString:@""]) {
            cell.drink = @"1";
        }else{
           cell.drink = self.model.drink;
        }
        cell.delegate = self;
         return cell;
        
    }else if(indexPath.section == 1){
        SDSomkeReactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSOMKEREACTIONTABLEVIEW_CELL forIndexPath:indexPath];
        cell.showLabel.text = @"药物过敏:";
        cell.showPlacLabel.text = @"请填写您的过敏药物";
        if (![self.model.drugallergy isEqualToString:@""]) {
            cell.showPlacLabel.hidden = YES;
        }
        cell.somkeTextView.text = self.model.drugallergy;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        return cell;
    }else if(indexPath.section == 2){
        SDSomkeReactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSOMKEREACTIONTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.showLabel.text = @"其他过敏:";
        cell.showPlacLabel.text = @"请填写您的其他过敏事物";
        if (![self.model.drugallergy isEqualToString:@""]) {
            cell.showPlacLabel.hidden = YES;
        }
        cell.somkeTextView.text = self.model.otherallergies;
        return cell;
    }else if(indexPath.section == 3){
        SDSomkeReactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSOMKEREACTIONTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.showLabel.text = @"特病慢病:";
        cell.showPlacLabel.text = @"请填写您的特殊病....";
        if (![self.model.drugallergy isEqualToString:@""]) {
            cell.showPlacLabel.hidden = YES;
        }
        cell.somkeTextView.text = self.model.specialdisease;
        return cell;
    }else if(indexPath.section == 4){
        SDSomkeReactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSOMKEREACTIONTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.showLabel.text = @"诊治医院:";
        cell.showPlacLabel.text = @"请填写您的病症的诊疗医院";
        if (![self.model.drugallergy isEqualToString:@""]) {
            cell.showPlacLabel.hidden = YES;
        }
         cell.somkeTextView.text = self.model.hospital;
        return cell;
    }else {
        SDSomkeReactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSOMKEREACTIONTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.showLabel.text = @"遗传病史:";
        cell.showPlacLabel.text = @"请填写您的遗传病史";
        if (![self.model.drugallergy isEqualToString:@""]) {
            cell.showPlacLabel.hidden = YES;
        }
        cell.somkeTextView.text = self.model.genetic;
        return cell;
    }
   
}
#pragma mark  -- UITableViewDelegate --- 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 160;
        
    }else if(indexPath.section == 4){
        return 45;
    
    }else {
        return 100;
        
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1f;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 10.f;
}
#pragma mark  -- 情况按钮 SDCircumstFilesTableViewCellDelegate-----
-(void)selectdSomkeAndWineBtn:(NSDictionary *)dic{

    [self.param addEntriesFromDictionary:dic];

}

#pragma mark ---- 按钮点击事件-----
//保存
-(void)onSaveBtnAction:(UIButton *)sender{
    //获取celltextView的值
    [self obtainCellTextView];
   
    [self updataFilesData];
    
}
//获取celltextView的值
-(void)obtainCellTextView{
    NSIndexPath *drugIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    SDSomkeReactionTableViewCell  *cell =[self.filesTableView cellForRowAtIndexPath:drugIndexPath];
    self.param[@"drugallergy"] = cell.somkeTextView.text;
    
    NSIndexPath *otheIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    SDSomkeReactionTableViewCell  *cell1 =[self.filesTableView cellForRowAtIndexPath:otheIndexPath];
    self.param[@"otherallergies"] = cell1.somkeTextView.text;
    
    NSIndexPath *speIndexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    SDSomkeReactionTableViewCell  *cell2 =[self.filesTableView cellForRowAtIndexPath:speIndexPath];
    self.param[@"specialdisease"] = cell2.somkeTextView.text;
    
    NSIndexPath *hospIndexPath = [NSIndexPath indexPathForRow:0 inSection:4];
    SDSomkeReactionTableViewCell  *cell3 =[self.filesTableView cellForRowAtIndexPath:hospIndexPath];
    self.param[@"hospital"] = cell3.somkeTextView.text;
   
    NSIndexPath *genIndexPath = [NSIndexPath indexPathForRow:0 inSection:5];
    SDSomkeReactionTableViewCell  *cell4 =[self.filesTableView cellForRowAtIndexPath:genIndexPath];
    self.param[@"genetic"] = cell4.somkeTextView.text;
}

#pragma mark  -- 数据相关的-----
-(void)setMember_id:(NSString *)member_id{
    _member_id = member_id;
}
-(SDHealthyFilesModel *)model{

    if (!_model) {
        _model = [[SDHealthyFilesModel alloc]init];
    }
    return _model;
}
-(NSMutableDictionary *)param{

    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}
//获取档案数据
-(void)requestFilesData{

    __weak typeof( self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"member_id"] = self.member_id;
    [[KRMainNetTool sharedKRMainNetTool] sendNowRequstWith:HealthyFiles_Url params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        weakSelf.model = [SDHealthyFilesModel modelWithDictionary:showdata];
        [weakSelf.filesTableView reloadData];
    }];

}
//修改档案数据
-(void)updataFilesData{

    __weak typeof( self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"member_id"] = self.member_id;
    param[@"health_id"] = self.model.health_id;
    [param addEntriesFromDictionary:self.param.copy];
    [[KRMainNetTool sharedKRMainNetTool] upLoadNewData:HealthyFiles_updata_Url params:param andData:nil complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
     }];

}
#pragma mark ----监听键盘----
-(void)keyboardWillHealthShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSLog(@"%f",keyboardRect.size.height);
  
    //当键盘将要显示时，将tableView的下边距增跟改为键盘的高度
    self.filesTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardRect.size.height, 0);
    
}



-(void)keyboardWillHealthyHide{

    //当键盘将要消失时，边距还原初始状态
    self.filesTableView.contentInset = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
