//
//  YMDropDownView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/21.
//  Copyright © 2017年 CoderDX. All rights reserved.
//
#import "YMDropDownView.h"

@interface YMDropDownView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *dropDownTableView;

@end

@implementation YMDropDownView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

-(void)initView{
    _dropDownTableView = [[UITableView alloc]init];
    _dropDownTableView.backgroundColor = [UIColor whiteColor];
    _dropDownTableView.delegate = self;
    _dropDownTableView.dataSource = self;
    _dropDownTableView.separatorStyle = UIScrollViewIndicatorStyleDefault;
    [self addSubview:_dropDownTableView];
    [_dropDownTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(0);
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *userNameLabel = [[UILabel alloc]init];
        userNameLabel.textColor = RGBCOLOR(51, 51, 51);
        userNameLabel.font = [UIFont systemFontOfSize:15];
        userNameLabel.tag = 10010;
        [cell addSubview:userNameLabel];
        [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *usernameLabel =(UILabel*)[cell.contentView viewWithTag:10010];
    
    YMSignUpAndDorctorModel *model = _data[indexPath.row];
    
    if (model.showType == 0) {
        usernameLabel.text = model.leagure_name;
    }else{
        usernameLabel.text = model.hospital_name;
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(dropDownView:clickModel:)]) {
        [self.delegate dropDownView:self clickModel:_data[indexPath.row]];
    }
}


-(void)setData:(NSArray<YMSignUpAndDorctorModel *> *)data{
    _data = data;
    [_dropDownTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(data.count *44);
    }];
    [_dropDownTableView reloadData];
}

-(void)setDistanceTopHeight:(CGFloat)distanceTopHeight{
    [_dropDownTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(distanceTopHeight);
    }];
}

@end
