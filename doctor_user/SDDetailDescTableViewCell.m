//
//  SDDetailDescTableViewCell.m
//  doctor_user
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SDDetailDescTableViewCell.h"

@interface SDDetailDescTableViewCell ()

@property(nonatomic,strong) UILabel *detaDescLab; // 详情描述
@property(nonatomic,strong) UIImageView *detaImageView; //图片

@end

@implementation SDDetailDescTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)createUINSDic:(NSDictionary *)dict{

    UILabel *showDescLab = [[UILabel alloc]init];
    [self addSubview:showDescLab];
    
    self.detaDescLab = [[UILabel alloc]init];
    [self addSubview:self.detaDescLab];
    
    showDescLab.text =dict[@"showTimeLab"];
    showDescLab.textColor = [UIColor text333Color];
    showDescLab.font = [UIFont systemFontOfSize:15];
    [showDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
    }];
    
    self.detaDescLab.text = dict[@"diseases_company"];
    self.detaDescLab.textColor = [UIColor text333Color];
    self.detaDescLab.font = [UIFont systemFontOfSize:15];
    self.detaDescLab.numberOfLines = 0;
    [self.detaDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(78);
        make.top.equalTo(showDescLab.mas_top);
        make.right.equalTo(self).offset(-10);
    }];
    
    //图片
    NSArray *imgs = dict[@"imgs"];
    CGFloat cellHeight = 0;
    
    if ([self.detaDescLab.text isEqualToString:@""]) {
        
         cellHeight = 40;
    }else{
        
     CGSize titleSize = [self.detaDescLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 78, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        
       cellHeight = titleSize.height+20;
    }
    
    if (imgs.count > 0) {
        for (int i=0; i<imgs.count; i++) {
            self.detaImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, cellHeight+i*210+i*10, SCREEN_WIDTH-20, 210)];
            [self addSubview:self.detaImageView];
            NSString *url =imgs[i];
            [self.detaImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
        }
        
    }
    
}

-(void)setDict:(NSDictionary *)dict{

    _dict = dict;
    if ([dict count] != 0) {
         [self createUINSDic:dict];
    }
   
    
}

+(CGFloat)cellDetailDescHeight:(NSDictionary *)symptomStr{
    
    CGFloat cellHeight = 0;
    
    UILabel *detailLabel = [[UILabel alloc]init];
    
    detailLabel.numberOfLines = 0;
    
    //详情描述
    NSString *str = symptomStr[@"diseases_company"];
    
    CGSize titleSize;
    
    if (![str isEqualToString:@""]) {
         titleSize = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 78, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        detailLabel.size = titleSize;
        
      
       
    }
   
    //图片
    NSArray *arr =symptomStr[@"imgs"];
    if (arr.count > 0) {
        
        cellHeight = arr.count*210+arr.count*10+20;
        
    }
  
    return cellHeight+titleSize.height+20;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
