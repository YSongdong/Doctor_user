//
//  SDHealthyManagerViewController.m
//  doctor_user
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDHealthyManagerViewController.h"



#import "SDDatePickerView.h"


#import "SDStateFormExplairTableViewCell.h"
#import "SDHealthyManagerTableViewCell.h"
#import "SDDoctorYuYueTableViewCell.h"
#define SDSTATEFORMEXPLAIRTABLEVIEE_CELL @"SDStateFormExplairTableViewCell"
#define SDHEALTHYMANAGERTABLEVIEW_CELL @"SDHealthyManagerTableViewCell"
#define SDDOCTORYUYUETABLEVIEW_CELL  @"SDDoctorYuYueTableViewCell"
#define  DOWNLOADURL  @"http://audio.xmcdn.com/group11/M01/93/AF/wKgDa1dzzJLBL0gCAPUzeJqK84Y539.m4a"
@interface SDHealthyManagerViewController () <UITableViewDelegate,UITableViewDataSource,SDDoctorYuYueTableViewCellDelegate,SDDatePickerViewDelegate,SDHealthyManagerTableViewCellDelegte,UIDocumentInteractionControllerDelegate>

@property (nonatomic,strong) UITableView *managerTableView;

@property (nonatomic,strong) UIDocumentInteractionController *documentController;//阅读

@end

@implementation SDHealthyManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUITableView];
}
-(void)initUITableView{
    if ([self.btnType isEqualToString:@"2"]) {
        self.title = @"健康管理方案";
        self.managerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    }else  if ([self.btnType isEqualToString:@"5"]) {
        self.title = @"年度健康报告";
        [self initContactBottomView];
        self.managerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-30)];
    }else  if ([self.btnType isEqualToString:@"7"]) {
        self.title = @"医生服务到家预约";
        [self initBottomView];
        self.managerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50)];
    }
    [self.view addSubview:self.managerTableView];
    self.managerTableView.delegate = self;
    self.managerTableView.dataSource = self;
    
    self.managerTableView.separatorStyle =NO;
    
    [self.managerTableView registerNib:[UINib nibWithNibName:SDSTATEFORMEXPLAIRTABLEVIEE_CELL bundle:nil] forCellReuseIdentifier:SDSTATEFORMEXPLAIRTABLEVIEE_CELL];
    [self.managerTableView registerNib:[UINib nibWithNibName:SDHEALTHYMANAGERTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDHEALTHYMANAGERTABLEVIEW_CELL];
    [self.managerTableView registerNib:[UINib nibWithNibName:SDDOCTORYUYUETABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDDOCTORYUYUETABLEVIEW_CELL];
    
    
}
-(void)initBottomView{
    //拨打电话
    UIButton *countBtn  =[[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50)];
    countBtn.backgroundColor = [UIColor NaviBackgrounColor];
    
    [countBtn setTitle:@"提交" forState:UIControlStateNormal];
    [countBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:countBtn];
    
}
-(void)initContactBottomView{

    UIView *bottmView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-30, SCREEN_WIDTH, 30)];
    [self.view addSubview:bottmView];
    
    UILabel *label = [[UILabel alloc]init];
    [bottmView addSubview:label];
    
    label.text =@"如有疑问，请联系您的专属健康顾问";
    label.textColor = [UIColor text333Color];
    label.font = [UIFont systemFontOfSize:13];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottmView.mas_centerX);
        make.centerY.equalTo(bottmView.mas_centerY);
    }];
}

#pragma mark  ---UITableView---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.btnType isEqualToString:@"2"]) {
        //健康管理方案
        return 2;
    }else  if ([self.btnType isEqualToString:@"5"]) {
        //年度健康报告
        return 2;
    }else  if ([self.btnType isEqualToString:@"7"]) {
        //医生服务到家预约
        return 2;
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        SDStateFormExplairTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSTATEFORMEXPLAIRTABLEVIEE_CELL forIndexPath:indexPath];
         cell.textType =self.btnType;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if ([self.btnType isEqualToString:@"7"]) {
            //医生服务到家预约
            SDDoctorYuYueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDDOCTORYUYUETABLEVIEW_CELL forIndexPath:indexPath];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            SDHealthyManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDHEALTHYMANAGERTABLEVIEW_CELL forIndexPath:indexPath];
            cell.ManagerType = self.btnType;
            cell.indexPath = indexPath;
            cell.delegate = self;
            BOOL  isDownFinish = [self isFinishExistFilesName:DOWNLOADURL];
            if (isDownFinish) {
                cell.isOpen = YES;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    return nil;
}
#pragma amrk ----UITableViewDelegate-----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        if ([self.btnType isEqualToString:@"2"]) {
            //健康管理方案
            return 175;
        }else  if ([self.btnType isEqualToString:@"5"]) {
            //年度健康报告
            return 220;
        }else  if ([self.btnType isEqualToString:@"7"]) {
            //医生服务到家预约
            return 220;
        }
    }else{
        return 70;
    }
    return 0;
}

#pragma mark ---- 医生服务到家预约提交按钮-----
-(void)submitBtnAction:(UIButton *)sender{

    if ([self.btnType isEqualToString:@"7"]) {
        //医生服务到家预约
       
    }

}
#pragma mark  --- 医生服务到家预约点击选择时间--------
-(void)selectdTimeBtnAction:(UIButton *)sender{

    SDDatePickerView *pickerView = [[SDDatePickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-315, SCREEN_WIDTH, 315)];
    pickerView.delegate = self;
    [self.view addSubview:pickerView];

}
//选择时间
-(void)selectdTimeNSDict:(NSDictionary *)dic{

    NSString *selectTime = dic[@"selectTime"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    SDDoctorYuYueTableViewCell *cell =  [self.managerTableView cellForRowAtIndexPath:indexPath];
    cell.selectTime = selectTime;

}
#pragma mark  --- 选择下载和打开按钮事件----
-(void)selectdDownOrOpenBtn:(UIButton *)sender andIndexPath:(NSIndexPath *)indexPath{
    
  
    BOOL  isDownFinish = [self isFinishExistFilesName:DOWNLOADURL];
    if (isDownFinish) {
       // 下载完成
      
        [self openReadAppFilesName:DOWNLOADURL.md5String];
    
    }else{
       //下载
        sender.selected = !sender.selected;
        if (sender.selected) {
            //下载
            [self starDownIndexPath:indexPath];
        }else{
           //暂停
          [[DownLoadManager sharedInstance]stopTask];
        }
       
    }

}
-(void) starDownIndexPath:(NSIndexPath *)indexPath{
    // 启动任务
    __weak typeof(self) weakSelf = self;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"下载中";
    hud.contentColor= [UIColor blackColor];
   
    [[DownLoadManager sharedInstance]downLoadWithURL:DOWNLOADURL progress:^(float progress) {
        
        hud.progress = progress;
        
    } success:^(NSString *fileStorePath) {
         NSLog(@"###%@",fileStorePath);
        //关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
        //下载完成
        SDHealthyManagerTableViewCell *cell = [weakSelf.managerTableView cellForRowAtIndexPath:indexPath];
        cell.isOpen = YES;
        
    } faile:^(NSError *error) {
        [weakSelf.view showErrorWithTitle:error.userInfo[NSLocalizedDescriptionKey] autoCloseTime:2];
          //关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }];

}
//判断文件是否存在
-(BOOL) isFinishExistFilesName:(NSString *)name{
    BOOL isExist =  NO;
    NSArray *dataArr = [[DownLoadManager sharedInstance]setObtainFilesAll];
    NSString *filesPath = name.md5String;
    for (NSString *str in dataArr) {
        if ([str isEqualToString:filesPath]) {
            isExist = YES;
        }
    }
    return isExist;
}

//预览
-(void) openReadAppFilesName:(NSString *)filesName{
    NSString *filesPath =[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:filesName];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filesPath]];
    self.documentController.delegate = self;
    
    self.documentController.UTI = @"com.microsoft.word.doc";
    
    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];

}
#pragma mark - UIDocumentInteractionController 代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.bounds;
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
