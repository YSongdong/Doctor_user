//
//  YMDepartmentSelectionViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDepartmentSelectionViewController.h"
#import "DepartmentsView.h"
#import "YMHospitalAndDepartmentModel.h"
#import "YMDeparmentTableViewCell.h"

static NSString *const deparmentCell = @"deparmentCell";

@interface YMDepartmentSelectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,strong)YMHospitalAndDepartmentModel *model;

@property(nonatomic,assign)NSInteger selectInpot;

//@property(nonatomic,strong)UIScrollView *leftScrollView;
//@property(nonatomic,strong)UIScrollView *rightScrollView;

@end

@implementation YMDepartmentSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"科室选择";
    [self initView];
    [self initVar];
    [self requestPageContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [self initTopView];
    [self initLeftTableView];
    [self initRightTableView];
}
-(void)initVar{
    _selectInpot = 0;
}

//获取科室等接口
- (void)requestPageContent {
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"act=doctor_personal&op=sys_enum" params:nil withModel:nil complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSDictionary class]] ||[showdata isKindOfClass:[NSMutableDictionary class]]) {
            weakSelf.model = [YMHospitalAndDepartmentModel modelWithJSON:showdata];
        }
        [weakSelf.leftTableView reloadData];

        [weakSelf.rightTableView reloadData];
    }];
}

-(void)initTopView{
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_topView addGestureRecognizer:tapGestureRecognizer];
    
    
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        if (_hiddentopView) {
            make.height.equalTo(@0);
        }else{
            make.height.equalTo(@44);
        }
    }];
    
    UILabel *titleLabel= [[UILabel alloc]init];
    titleLabel.text = @"不限条件";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [_topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(10);
        make.top.bottom.equalTo(_topView);
        make.right.equalTo(_topView.mas_right).offset(-10);
    }];
    [_topView drawBottomLine:0 right:0];
}

-(void)initLeftTableView{
    
    _leftTableView = [[UITableView alloc]init];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.tag = 10001;
    [_leftTableView registerClass:[YMDeparmentTableViewCell class] forCellReuseIdentifier:deparmentCell];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    [self.view addSubview:_leftTableView];

    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.top.equalTo(_topView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2.f);
    }];
}

-(void)initRightTableView{
    _rightTableView = [[UITableView alloc]init];
    _rightTableView.tag = 10002;
    [_rightTableView registerClass:[YMDeparmentTableViewCell class] forCellReuseIdentifier:deparmentCell];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_rightTableView];
    
    [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.top.equalTo(_topView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2.f);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 10001) {
        return _model.departments.count;
    }else{
        YMDepartmentModel * departmentModel= _model.departmentsArry[_selectInpot];
        
        return departmentModel._child.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    YMDeparmentTableViewCell *cell = [[YMDeparmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deparmentCell];
    
    if (tableView.tag == 10001) {
        
        if (indexPath.row == _selectInpot) {
            cell.backgroundColor =[UIColor whiteColor];
        }else{
            cell.backgroundColor = RGBCOLOR(240, 240, 240);
        }
        cell.productName = _model.departmentsArry[indexPath.row].ename;
    }else{
        cell.rightCell = YES;
        YMDepartmentModel * departmentModel= _model.departmentsArry[_selectInpot];
        YMDepartmentChildModel* departmentChild = departmentModel.departmentChild[indexPath.row];
        cell.productName = departmentChild.ename;
        [cell drawBottomLine:0 width:0];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 10001) {
        _selectInpot = indexPath.row;
        [_leftTableView reloadData];
        [_rightTableView reloadData];
    }else{
        if ([self.delegate respondsToSelector:@selector(departmentView:disorder:ename:big_ks:)]) {
            YMDepartmentModel * departmentModel= _model.departmentsArry[_selectInpot];
            YMDepartmentChildModel* departmentChild = departmentModel.departmentChild[indexPath.row];
            [self.delegate departmentView:self disorder:departmentChild.disorder ename:departmentChild.ename big_ks:departmentModel.disorder];
            
            UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
            if (ctrl == nil) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        
        
        if ([self.delegate respondsToSelector:@selector(departmentView:disorder:ename:)]) {
            YMDepartmentModel * departmentModel= _model.departmentsArry[_selectInpot];
            YMDepartmentChildModel* departmentChild = departmentModel.departmentChild[indexPath.row];
            [self.delegate departmentView:self disorder:departmentChild.disorder ename:departmentChild.ename];
            
            UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
            if (ctrl == nil) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

-(void)titleClick{
    NSLog(@"title点击");
    if ([self.delegate respondsToSelector:@selector(departmentView:disorder:ename:)]) {
        
        [self.delegate departmentView:self disorder:@"" ename:@"不限"];
        
        UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
        if (ctrl == nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(void)setHiddentopView:(BOOL)hiddentopView {
    _hiddentopView = hiddentopView;
}

@end
