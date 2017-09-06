//
//  SDOtherSeverViewController.m
//  doctor_user
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDOtherSeverViewController.h"

#import "SDOtherSeverTableViewCell.h"

#define SDOTHERSEVERTABLEVIEW_CELL  @"SDOtherSeverTableViewCell"
@interface SDOtherSeverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *otherTableView;


@end

@implementation SDOtherSeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"增值服务";
    [self initTableView];
   
}
-(void)initTableView{

    self.otherTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) ];
    [self.view addSubview:self.otherTableView];
    self.otherTableView.backgroundColor = [UIColor colorWithHexString:@"#EEEFF6"];
    self.otherTableView.delegate = self;
    self.otherTableView.dataSource= self;
    
    [self.otherTableView registerNib:[UINib nibWithNibName:SDOTHERSEVERTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDOTHERSEVERTABLEVIEW_CELL];

}

#pragma mark ----UITableViewSoucre----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SDOtherSeverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDOTHERSEVERTABLEVIEW_CELL forIndexPath:indexPath];
    return cell;

}
#pragma mark  --- UITableViewDelegate-----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 125;

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
