//
//  KRShengTableViewController.m
//  Dntrench
//
//  Created by kupurui on 16/10/20.
//  Copyright © 2016年 CoderDX. All rights reserved.
//

#import "KRShengTableViewController.h"

//#import "KRMainNetTool.h"
//#import "MBProgressHUD+KR.h"
@interface KRShengTableViewController ()
@property (nonatomic, strong) NSArray *allCityArray;
@end

@implementation KRShengTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == districtTypeProvince) {
        self.title = @"选择省份";
        [self loadData];
    }
    else if (self.type == districtTypeCity) {
        self.title = @"选择城市";
    }
    else if (self.type == districtTypeArea) {
        self.title = @"选择区域";
    }
    
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=demand&op=area" params:nil withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        _areas = [showdata[@"_area"] copy];
        [self.tableView reloadData];
    }];
}
- (void)setAreas:(NSArray *)areas {

    _areas = areas ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
      return self.areas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = 0;
    }
    cell.textLabel.text = self.areas[indexPath.row][@"area_name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

        if (self.type == districtTypeCity) {
              UIViewController *vc1 = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedAddress" object:self.areas[indexPath.row]];
            [self.navigationController popToViewController:vc1 animated:YES];
    }
    KRShengTableViewController *vc = [[KRShengTableViewController alloc]init];
    if (self.type == districtTypeProvince ) {
        NSArray *areaArray = self.areas[indexPath.row][@"child"];
        vc.type = districtTypeCity ;
        vc.areas = areaArray ;
    }
//    if (self.type == districtTypeCity) {
//        vc.areas = self.areas[indexPath.row][@"child"];
//        vc.type = districtTypeArea ;
//    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
