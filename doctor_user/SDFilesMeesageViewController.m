//
//  SDFilesMeesageViewController.m
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDFilesMeesageViewController.h"

#import "SDFilesMessageModel.h"

#import "SDUserFilesInfoTableViewCell.h"
#import "SDUserIphoneFormTableViewCell.h"
#define SDUSERFILESINFOTABLEVIEW_CELL  @"SDUserFilesInfoTableViewCell"
#define SDUSERINPHONEFORMTABLEVIEW_CELL  @"SDUserIphoneFormTableViewCell"
@interface SDFilesMeesageViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *filesTableView;
@property(nonatomic,strong) UILabel *filesNumberLab; //档案编号lab
@property(nonatomic,strong) SDFilesMessageModel *model;

@end

@implementation SDFilesMeesageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"档案信息卡";
    [self initTableView];
}
-(void)initTableView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    UILabel *headerLab = [[UILabel alloc]init];
    [headerView addSubview:headerLab];
    headerLab.text = @"档案编号:";
    headerLab.textColor  = [UIColor text333Color];
    headerLab.font = [UIFont systemFontOfSize:16];
    [headerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(10);
        make.centerY.equalTo(headerView.mas_centerY).offset(5);
    }];
    
    self.filesNumberLab = [[UILabel alloc]init];
    [headerView addSubview:self.filesNumberLab];
    self.filesNumberLab.text = @"12-13546";
    self.filesNumberLab.textColor  = [UIColor text333Color];
    self.filesNumberLab.font = [UIFont systemFontOfSize:16];
    [self.filesNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerLab.mas_right).offset(0);
        make.centerY.equalTo(headerLab.mas_centerY);
    }];
    
    self.filesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) ];
    [self.view addSubview:self.filesTableView];
    self.filesTableView.delegate = self;
    self.filesTableView.dataSource = self;
   
    self.filesTableView.tableHeaderView = headerView;
    self.filesTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.filesTableView.separatorStyle = NO;
    
    [self.filesTableView registerNib:[UINib nibWithNibName:SDUSERFILESINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDUSERFILESINFOTABLEVIEW_CELL];
    [self.filesTableView registerNib:[UINib nibWithNibName:SDUSERINPHONEFORMTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDUSERINPHONEFORMTABLEVIEW_CELL];

}
#pragma mark ----UITableViewSoucre----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SDUserFilesInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDUSERFILESINFOTABLEVIEW_CELL forIndexPath:indexPath];
        return cell;
    }else{
    SDUserIphoneFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDUSERINPHONEFORMTABLEVIEW_CELL forIndexPath:indexPath];
        return cell;
    }
    
}
#pragma mark  --- UITableViewDelegate-----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
         return 215;
    }else{
        return 230;
    }
  
}

#pragma mark ---- 数据相关------
-(SDFilesMessageModel *)model{

    if (!_model) {
        _model = [[SDFilesMessageModel alloc]init];
    }
    return _model;

}


-(void) reqeuestLoadData{

    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendNowRequstWith:PrivateDoctorFileCark_Url params:@{@"p_health_id":self.p_health_id} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if (!error) {
            if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
                  weakSelf.model = [SDFilesMessageModel modelWithDictionary:showdata];
            }
             [weakSelf.filesTableView reloadData];
        }else{
            [weakSelf.view showErrorWithTitle:error autoCloseTime:2];
        }
        
    }];


}




    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
