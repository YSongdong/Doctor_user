//
//  YMDoctorAskedTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/6/6.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorAskedTableViewCell.h"
#import "YMPhotoViewCollectionViewCell.h"

static NSString *const photoViewCell = @"photoViewCell";

@interface YMDoctorAskedTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *picCollection;

@property(nonatomic,strong)UILabel *askedContentLabel;//嘱咐内容

@property(nonatomic,strong)UIButton *aplyButton;//付款

@property(nonatomic,strong)UIButton *arbitrationButton;//仲裁

@property(nonatomic,strong)UIView *referralTipView;//复诊提醒

@property(nonatomic,strong)UILabel *referralTipLabel;//复诊提醒Label；

@property(nonatomic,strong)UILabel *referralTipTime;//复诊提醒时间

@property(nonatomic,strong) UILabel *referralTipContent;//提醒内容

@property(nonatomic,strong)NSArray *tipPicArry;

@property(nonatomic,copy)NSString *tipInfoStr;

@property(nonatomic,copy)NSString *nextConeten;

@property(nonatomic,copy)NSString *nextTime;

@end

@implementation YMDoctorAskedTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
    // Initialization code
}

-(void)initView{
    [self initCollectionView];
    [self initAskedInfoView];
    [self initReferralTipView];
}


-(void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _picCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90) collectionViewLayout:flowLayout];
    _picCollection.showsVerticalScrollIndicator = NO;
    _picCollection.showsHorizontalScrollIndicator = NO;
    _picCollection.dataSource=self;
    _picCollection.delegate=self;
    [_picCollection setBackgroundColor:[UIColor clearColor]];
    
    //注册Cell，必须要有
    [_picCollection registerClass:[YMPhotoViewCollectionViewCell class] forCellWithReuseIdentifier:photoViewCell];

    [self addSubview:_picCollection];
    [_picCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.equalTo(@80);
    }];
 
}

-(void)initAskedInfoView{
    _askedContentLabel = [[UILabel alloc]init];
    _askedContentLabel.font = [UIFont systemFontOfSize:13];
    _askedContentLabel.numberOfLines = 0;
    _askedContentLabel.textColor = RGBCOLOR(80, 80, 80);
    [self addSubview:_askedContentLabel];
    [_askedContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_picCollection.mas_bottom).offset(5);
    }];
    
    _arbitrationButton = [[UIButton alloc]init];
    _arbitrationButton.backgroundColor = [UIColor clearColor];
    _arbitrationButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [_arbitrationButton setTitleColor:RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
    
    [_arbitrationButton addTarget:self action:@selector(arbitrationClick:) forControlEvents:UIControlEventTouchUpInside];
    [_arbitrationButton setTitle:@"申请仲裁" forState:UIControlStateNormal];
    _arbitrationButton.layer.masksToBounds = YES;
    _arbitrationButton.layer.cornerRadius = 5;
    _arbitrationButton.layer.borderWidth = 1;
    _arbitrationButton.layer.borderColor = RGBCOLOR(173, 173, 173).CGColor;
    [self addSubview:_arbitrationButton];
    [_arbitrationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_askedContentLabel.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@22);
        make.width.equalTo(@70);
    }];
    
    _aplyButton = [[UIButton alloc]init];
    _aplyButton.backgroundColor = RGBCOLOR(148, 148, 148);
    _aplyButton.titleLabel.font = _arbitrationButton.titleLabel.font ;
    [_aplyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_aplyButton addTarget:self action:@selector(aplayClick:) forControlEvents:UIControlEventTouchUpInside];
    [_aplyButton setTitle:@"确定付款" forState:UIControlStateNormal];
    _aplyButton.layer.masksToBounds = YES;
    _aplyButton.layer.cornerRadius = 5;
    [self addSubview:_aplyButton];
    [_aplyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_arbitrationButton.mas_left).offset(-10);
        make.bottom.height.width.equalTo(_arbitrationButton);
    }];
}

-(void)initReferralTipView{
    
    _referralTipView = [[UIView alloc]init];
    _referralTipView.hidden = YES;
    [self addSubview:_referralTipView];
    [_referralTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(_aplyButton.mas_bottom).offset(10);
    }];
    
    
    
    _referralTipLabel = [[UILabel alloc]init];
    _referralTipLabel.text = @"复诊提醒";
    _referralTipLabel.hidden = _referralTipView.hidden;
    _referralTipLabel.font = [UIFont systemFontOfSize:15];
    [_referralTipView addSubview:_referralTipLabel];
    [_referralTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_referralTipView.mas_left).offset(10);
        make.top.equalTo(_referralTipView.mas_top).offset(10);
    }];
    
    _referralTipTime = [[UILabel alloc]init];
    _referralTipTime.text = @"2017年06月12日";
    _referralTipTime.hidden = _referralTipView.hidden;
    _referralTipTime.font = _referralTipLabel.font;
    [_referralTipView addSubview:_referralTipTime];
    [_referralTipTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_referralTipView.mas_right).offset(-10);
        make.top.equalTo(_referralTipLabel.mas_top);
    }];
    _referralTipContent = [[UILabel alloc]init];
    _referralTipContent.textColor = RGBCOLOR(134, 134, 134);
    _referralTipContent.hidden = _referralTipContent.hidden;
    _referralTipContent.font = [UIFont systemFontOfSize:12];
    _referralTipContent.numberOfLines = 0;
    [_referralTipView addSubview:_referralTipContent];
    [_referralTipContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_referralTipLabel.mas_left);
        make.right.equalTo(_referralTipView.mas_right);
        make.top.equalTo(_referralTipLabel.mas_bottom).offset(5);
    }];
    
}


#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_yuYue) {
        if (_model.instructions_img.count == 0 && [_model.yuyue_status integerValue] < 5) {
            return 1;
        }
    }else{
        if (_model.instructions_img.count == 0&&[_model.demand_type integerValue]==1){
            return 1;
        }
    }
    
    
    return _model.instructions_img.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YMPhotoViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoViewCell forIndexPath:indexPath ];
    if (_model.instructions_img.count !=0) {
        cell.imageUrl = _model.instructions_img[indexPath.row];
    }
    
    return cell;
}
#pragma mark ---- UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){70,70};
}


    
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


#pragma mark - setter

-(void)setModel:(YMDoctorOrderProcessModel *)model{
    _model = model;
    
    if (_yuYue) {
        self.tipPicArry = model.instructions_img;
        
        self.nextTime = model.fuzhen_time;
        self.nextConeten =model.fuzhen_tips;
        if ([_model.yuyue_status integerValue] < 5) {
            _aplyButton.backgroundColor = RGBCOLOR(148, 148, 148);
            _aplyButton.userInteractionEnabled = NO;
            _arbitrationButton.userInteractionEnabled = NO;
            _arbitrationButton.layer.borderColor = RGBCOLOR(80, 80, 80).CGColor;
            [_arbitrationButton setTitleColor:RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
        }else{
            self.tipInfoStr = [NSString isEmpty: model.instructions_content]?@"医生还没提交相应的信息":model.instructions_content;
            
            if ([_model.yuyue_status integerValue] == 6) {
                _aplyButton.backgroundColor = RGBCOLOR(148, 148, 148);
                _aplyButton.userInteractionEnabled = NO;
            }else{
                _aplyButton.backgroundColor = RGBCOLOR(67, 149, 230);
                _aplyButton.userInteractionEnabled = YES;
            }
            
            if ([_model.is_arbitrate integerValue] == 1) {
                _arbitrationButton.userInteractionEnabled = NO;
                _arbitrationButton.layer.borderColor = RGBCOLOR(51  , 51, 51).CGColor;
                [_arbitrationButton setTitleColor:RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
            }else{
                _arbitrationButton.userInteractionEnabled = YES;
                _arbitrationButton.layer.borderColor = RGBCOLOR(225  , 102, 51).CGColor;
                [_arbitrationButton setTitleColor:RGBCOLOR(236, 109, 68) forState:UIControlStateNormal];
            }
        }
    }else{
        
        if ([_model.demand_type intValue] ==1 ) {
            self.tipPicArry = model.instructions_img;
            
            self.nextTime = model.fuzhen_time;
            self.nextConeten =model.fuzhen_tips;
            self.tipInfoStr = [NSString isEmpty: model.instructions_content]?@"医生还没提交相应的信息":model.instructions_content;
            _askedContentLabel.hidden = NO;
        }else{
            _askedContentLabel.hidden = YES;
            _referralTipTime.hidden = YES;
            _referralTipView.hidden = YES;
            _referralTipTime.hidden = YES;
            _referralTipContent.hidden = YES;
            _referralTipLabel.hidden = YES;

        }
        
        if ([_model.mingyi_status integerValue] == 4) {
            _aplyButton.userInteractionEnabled = NO;
            _aplyButton.backgroundColor = RGBCOLOR(148, 148, 148);
        }else{
        
            _aplyButton.userInteractionEnabled = YES;
            _aplyButton.backgroundColor = RGBCOLOR(67, 149, 230);
        
        }
        if ([_model.is_arbitrate integerValue] == 1) {
            _arbitrationButton.userInteractionEnabled = NO;
            _arbitrationButton.layer.borderColor = RGBCOLOR(51  , 51, 51).CGColor;
            [_arbitrationButton setTitleColor:RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
        }else{
            _arbitrationButton.userInteractionEnabled = YES;
            _arbitrationButton.layer.borderColor = RGBCOLOR(225  , 102, 51).CGColor;
            [_arbitrationButton setTitleColor:RGBCOLOR(236, 109, 68) forState:UIControlStateNormal];
        }
    }
    
    [_picCollection reloadData];
}

-(void)setNextConeten:(NSString *)nextConeten{
    
    if (![NSString isEmpty:nextConeten]) {
        _referralTipView.hidden = NO;
        _referralTipTime.hidden = NO;
        _referralTipContent.hidden = NO;
        _referralTipLabel.hidden = NO;
        _referralTipContent.text = nextConeten;
        [_referralTipView drawTopLine:0 right:0];
    }
}

-(void)setNextTime:(NSString *)nextTime{
    _referralTipTime.text = nextTime;
}

-(void)setTipPicArry:(NSArray *)tipPicArry{
    
    _tipPicArry = tipPicArry;
    NSInteger lineNumber = 1;
    CGFloat collectHeight = 80;
    NSInteger rowMacNumber = 1;
    for (NSInteger i = 0; i<tipPicArry.count; i++) {
        if((rowMacNumber *5+20+rowMacNumber*70)>SCREEN_WIDTH){
            lineNumber++;
            rowMacNumber = 1;
        }else{
            rowMacNumber++;
        }
    }
    
    [_picCollection mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(collectHeight*lineNumber));

    }];
}

-(void)setTipInfoStr:(NSString *)tipInfoStr{
    _askedContentLabel.text = tipInfoStr;
}


+(CGFloat)DoctorAskedHeight:(NSString *)askedStr picNum:(NSInteger)number referralInfo:(NSString *)referralInfo{

    NSInteger lineNumber = 1;
   
    CGFloat collectHeight = 80;
    
    NSInteger rowMacNumber = 1;
    for (NSInteger i = 0; i<number; i++) {
        if((rowMacNumber *5+20+rowMacNumber*70)>SCREEN_WIDTH){
            lineNumber++;
            rowMacNumber = 1;
        }else{
            rowMacNumber++;
        }
    }
    
    collectHeight = collectHeight*lineNumber;
    
    
    UILabel *askedLabel = [[UILabel alloc]init];
    
    askedLabel.numberOfLines = 0;
    
    CGSize askedtitleSize = [askedStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    if ([NSString isEmpty:askedStr]) {
        askedtitleSize = CGSizeMake(0, 17);
    }
    
    CGSize referralInfoLabelSize = CGSizeMake(0, 0);
   
    if (![NSString isEmpty:referralInfo]) {
        referralInfoLabelSize = [referralInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    }
    
    NSLog(@"height====%f",askedtitleSize.height+45+collectHeight + referralInfoLabelSize.height + ([NSString isEmpty:referralInfo]?0:35));
    
    return askedtitleSize.height+45+collectHeight +referralInfoLabelSize.height + ([NSString isEmpty:referralInfo]?0:35);//35:底部按钮,35:复诊提醒高度
}

-(void)arbitrationClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(doctorAskedViewCell:arbitration:)]) {
        [self.delegate doctorAskedViewCell:self arbitration:sender];
    }
}

-(void)aplayClick:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(doctorAskedViewCell:aplayButton:)]){
        [self.delegate doctorAskedViewCell:self aplayButton:sender];
    }
}


@end
