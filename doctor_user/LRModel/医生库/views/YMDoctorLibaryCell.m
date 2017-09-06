//
//  YMDoctorLibaryCell.m
//  doctor_user
//
//  Created by kupurui on 2017/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorLibaryCell.h"
#import "LRMacroDefinitionHeader.h"

@interface YMDoctorLibaryCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *authen;
@property (weak, nonatomic) IBOutlet UILabel *doctorType;//eg 主任医生
@property (weak, nonatomic) IBOutlet UILabel *hospital;
@property (weak, nonatomic) IBOutlet UILabel *dealCount;

@property (weak, nonatomic) IBOutlet UILabel *evaluate;

@end

@implementation YMDoctorLibaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)drawRect:(CGRect)rect {
    _authen.layer.cornerRadius = 5 ;
    _authen.layer.masksToBounds = YES ;
    LRViewBorderRadius(self.headImg, self.headImg.frame.size.width/2, 0, [UIColor clearColor]);
}

- (void)setDataList:(NSDictionary *)dataList {
    
    
    _dataList = dataList ;
    if (![dataList[@"store_avatar"] isKindOfClass:[NSNull class]]) {
          [_headImg sd_setImageWithURL:[NSURL URLWithString:dataList[@"store_avatar"]] placeholderImage:[UIImage imageNamed:@"医盟用户版首页_17-8"]];
    }else {
        _headImg.image = [UIImage imageNamed:@"医盟用户版首页_17-8"];
    }
      _nameLabel.text = [NSString stringWithFormat:@"%@", dataList[@"member_names"]];
    _level.text = [NSString stringWithFormat:@"LV%@",dataList[@"grade_id"]];
    _evaluate.text = [NSString stringWithFormat:@"好评率:%@",dataList[@"goodsP"]];
    _hospital.text = [NSString stringWithFormat:@"%@",dataList[@"member_occupation"]];
    _dealCount.text = [NSString stringWithFormat:@"成交量:%@笔",dataList[@"goods_volume"]];
    _doctorType.text = [NSString stringWithFormat:@"%@",dataList[@"member_aptitude"]];
    _authen.text = [NSString stringWithFormat:@"证"];
    }

@end
