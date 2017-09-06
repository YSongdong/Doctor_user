//
//  YMHomeCenterTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/29.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHomeCenterTableViewCell.h"
#import "YFRollingLabel.h"
#import "HRAdView.h"

#import "HotspotModel.h"

@interface YMHomeCenterTableViewCell(){
    YFRollingLabel *_label;
}


@property (strong, nonatomic) IBOutlet UIView *view;

//医生库
- (IBAction)doctorBtnClick:(UIButton *)sender;
//护士库
- (IBAction)nurseBtnClick:(UIButton *)sender;
//需求大厅
- (IBAction)xuQiuButClick:(UIButton *)sender;
//疑难杂症
- (IBAction)zaZhengButClick:(UIButton *)sender;
//体检报告
- (IBAction)tiJianButClick:(UIButton *)sender;
//案例库
- (IBAction)anLiKuButClick:(UIButton *)sender;
//活动
- (IBAction)activityButClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *lineView;  //中间线条view
@property (weak, nonatomic) IBOutlet UIImageView *todayHotImageView;  //今日热点
@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;

@property (weak, nonatomic) IBOutlet UIButton *adViewGrounBtn; //跑马灯背景btn

@property (nonatomic, strong) HRAdView *adView; //跑马灯效果

@property (nonatomic,strong) NSMutableArray *dataArr; //热点数组数据


@end

@implementation YMHomeCenterTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self requestDataWithUrl];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
    [self requestDataWithUrl];
    
}


-(void)initView{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    _lineView.backgroundColor = [UIColor light_GrayColor];
 
}
-(void)initHospot
{
    NSMutableArray *textArr = [NSMutableArray array];
    for ( HotspotModel *model in self.dataArr) {
        [textArr addObject:model.hotspot_title];
    }
    HRAdView * view = [[HRAdView alloc]initWithTitles:textArr];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_adViewGrounBtn);
        make.bottom.equalTo(self.mas_bottom).offset(-98);
        make.right.equalTo(self.mas_right).offset(-40);
    }];
    view.textAlignment = NSTextAlignmentLeft;//默认
    view.isHaveTouchEvent = YES;
    view.labelFont = [UIFont boldSystemFontOfSize:14];
    view.color = [UIColor blackColor];
    view.time = 2.0f;
    view.defaultMargin = 10;
    view.numberOfTextLines = 2;
    __weak typeof(self) weakself = self;
    view.clickAdBlock = ^(NSUInteger index){
        HotspotModel *model = weakself.dataArr[index];
        NSString *url = model.hotspot_url;
        NSString *title = model.hotspot_title;
        if ([weakself.delegate respondsToSelector:@selector(selectdHospotUrl:andTitle:)]) {
            [weakself.delegate selectdHospotUrl:url andTitle:title];
        }
        [self.adView closeScroll];
    };
    view.headImg = [UIImage imageNamed:@"today_hot"];
    view.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.adView = view;
    view.backgroundColor = [UIColor whiteColor];
    
    [self.adView beginScroll];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)myiDingDanClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:dingDanButton:)]) {
        [self.delegate HomeCenterTableViewCell:self dingDanButton:sender];
    }
}

- (IBAction)myiZhuShouClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:zhuShowButton:)]) {
        [self.delegate HomeCenterTableViewCell:self zhuShowButton:sender];
    }
}

//医生库
- (IBAction)doctorBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:doctorButton:)]) {
        [self.delegate HomeCenterTableViewCell:self doctorButton:sender];
    }
}
//护士
- (IBAction)nurseBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:nurseButton:)]) {
        [self.delegate HomeCenterTableViewCell:self nurseButton:sender];
    }
}
//需求大厅
- (IBAction)xuQiuButClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:xuQiuButton:)]) {
        [self.delegate HomeCenterTableViewCell:self xuQiuButton:sender];
    }
}

//案例库
- (IBAction)zaZhengButClick:(UIButton *)sender {
   
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:anLiKuButton:)]) {
        [self.delegate HomeCenterTableViewCell:self anLiKuButton:sender];
    }
}
//活动
- (IBAction)tiJianButClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:activityButton:)]) {
        [self.delegate HomeCenterTableViewCell:self activityButton:sender];
    }
   
}
//体检报告
- (IBAction)anLiKuButClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:tiJianButton:)]) {
        [self.delegate HomeCenterTableViewCell:self tiJianButton:sender];
    }
}


//疑难杂症
- (IBAction)activityButClick:(UIButton *)sender {
   
    if ([self.delegate respondsToSelector:@selector(HomeCenterTableViewCell:zaZhengButton:)]) {
        [self.delegate HomeCenterTableViewCell:self zaZhengButton:sender];
    }
}

#pragma mark  -- 热点时迅 ------
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}
//热点
- (void)requestDataWithUrl {
    __weak typeof(self) weakSelf = self;
    KRMainNetTool *tool = [KRMainNetTool new];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"type"] = [NSNumber numberWithInt:2];
    [tool sendNowRequstWith:Hotspot_Url params:params withModel:nil  waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil ) {
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]||[showdata isKindOfClass:[NSMutableArray  class]]) {
            
            for (NSDictionary *dict in showdata) {
                HotspotModel *model = [HotspotModel modelWithDictionary:dict];
                [weakSelf.dataArr addObject:model];
            }

        }
        [weakSelf initHospot];
    }];

}





@end
