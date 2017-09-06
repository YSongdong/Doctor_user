//
//  ShareView.m
//  haiyibao
//
//  Created by 曹雪莹 on 2016/11/26.
//  Copyright © 2016年 韩元旭. All rights reserved.
//

#import "ShareView.h"
#import "ImageWithLabel.h"
#import "UIButton+LZCategory.h"
#import "UIImage+CreateBarCode.h"

#define ScreenWidth			[[UIScreen mainScreen] bounds].size.width
#define ScreenHeight		[[UIScreen mainScreen] bounds].size.height
#define SHAREVIEW_BGCOLOR   [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1]
#define WINDOW_COLOR        [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]
#define ANIMATE_DURATION    0.25f
#define LINE_HEIGHT         74
#define BUTTON_HEIGHT       44
#define NORMAL_SPACE        7
#define LABEL_HEIGHT		45

@interface ShareView ()

//	所有标题
@property (nonatomic, strong) NSArray  *shareBtnTitleArray;
//	所有图片
@property (nonatomic, strong) NSArray  *shareBtnImageArray;
//	整个底部分享面板的 backgroundView
@property (nonatomic, strong) UIView   *bgView;
//	取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;
//	所有的分享按钮

@property(nonatomic,strong) UIView *shareButtonView;

@property(nonatomic,strong) UIButton *saveButton;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIImageView *codeImageView;

@property(nonatomic,assign)CGFloat codeImageHeigth;

@property(nonatomic,assign)BOOL qrCode;

@property(nonatomic,copy)NSString *headerImageUrl;

@property(nonatomic,strong)UIImageView *codeCentImageView;

@property(nonatomic,copy)NSString *shareContent;

@property(nonatomic,strong)UIView *QrCodeView;

@end

@implementation ShareView

- (instancetype)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArry:(NSArray *)imageArray{
    
    return [self initWithShareHeadOprationWith:titleArray andImageArry:imageArray createQRcode:NO headerImageUrl:nil shareContent:@""];
}


-(instancetype)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArry:(NSArray *)imageArray createQRcode:(BOOL)qrCode headerImageUrl:(NSString *)headerImageUrl shareContent:(NSString *)shareContent{
    self = [super init];
    if (self) {
        
        _shareBtnTitleArray = titleArray;
        _shareBtnImageArray = imageArray;
        _qrCode = qrCode;
        _headerImageUrl = headerImageUrl;
        _shareContent = shareContent;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        //	背景，带灰度
        self.backgroundColor = WINDOW_COLOR;
        //	可点击
        self.userInteractionEnabled = YES;
        //	点击背景，收起底部分享面板，移除本视图
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        //	加载分享面板
        [self loadUIConfig];
    }
    return self;
}


-(void)initShareButtonView{
    if (_shareButtonView) {
        return;
    }
    _shareButtonView = [[UIView alloc]init];
    _shareButtonView.backgroundColor = RGBCOLOR(222, 222, 222);
    _shareButtonView.layer.masksToBounds = YES;
    _shareButtonView.layer.cornerRadius = 5;
    [_bgView addSubview:_shareButtonView];
    [_shareButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(10);
        make.right.equalTo(_bgView.mas_right).offset(-10);
        make.height.mas_equalTo(100);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-10);
    }];
    [self initShareButton];
}

-(void)initTitleView{
    if (_titleLabel) {
        return;
    }
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"分享鸣医给朋友";
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX);
        make.top.equalTo(_bgView.mas_top).offset(20);
    }];
    
}

-(void)initQRcodeView{
    
    
    if (_codeImageView) {
        return;
    }
    
    _codeImageHeigth = ScreenWidth - (20 + 20 + 25) * 2 + 16; //二维码高度
    
    _QrCodeView = [[UIView alloc]init];
    _QrCodeView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_QrCodeView];
    [_QrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX);
        make.top.equalTo(_titleLabel.mas_bottom).offset(20);
        make.height.width.mas_equalTo(_codeImageHeigth);
    
    }];
    
    _codeImageView = [[UIImageView alloc]init];  //二维码图片
    [_QrCodeView addSubview:_codeImageView];
    
    
    [_codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_QrCodeView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(_codeImageHeigth, _codeImageHeigth));
        make.top.equalTo(_QrCodeView.mas_top);
    }];
    
    _codeCentImageView = [[UIImageView alloc]init];
    
    [_codeCentImageView sd_setImageWithURL:[NSURL URLWithString:_headerImageUrl] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    
    _codeCentImageView.layer.cornerRadius = 5;
    _codeCentImageView.layer.masksToBounds = YES;
    [_QrCodeView addSubview:_codeCentImageView];

    [_codeCentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(_bgView.mas_centerX);
        make.centerY.equalTo(_codeImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}



-(void)initSaveButton{
    if (_saveButton) {
        return;
    }
    _saveButton = [[UIButton alloc]init];
    [_saveButton setTitle:@"保存到手机" forState:UIControlStateNormal];
    [_saveButton setTitleColor:RGBCOLOR(107, 180, 252) forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveQRcode:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _saveButton.backgroundColor = [UIColor clearColor];
    [_bgView addSubview:_saveButton];
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bgView);
        make.bottom.equalTo(_shareButtonView.mas_top).offset(-20);
        make.height.mas_equalTo(20);
    }];
}


-(void) initShareButton{
    
    CGFloat single = (SCREEN_WIDTH -40) /4.0;
    
    for (NSInteger i = 0 ;i<self.shareBtnTitleArray.count;i++) {
        UIButton *commodityButton = [[UIButton alloc]init];
        commodityButton.titleLabel.font = [UIFont systemFontOfSize:13];
        commodityButton.tag = 200+i;
        [commodityButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
        [commodityButton setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [commodityButton setImage:[UIImage imageNamed:_shareBtnImageArray[i]] forState:UIControlStateNormal];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [commodityButton LZSetbuttonType:LZCategoryTypeBottom];
        });
        
        [commodityButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside
         ];
        
        [_shareButtonView addSubview:commodityButton];
        [commodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(single *i);
            make.width.mas_offset(single);
            make.top.bottom.equalTo(_shareButtonView);
        }];
    }
}


- (void)initCenterbgView {
	
    if (_bgView) {
        return;
    }
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 5;
    [self addSubview:_bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_cancelBtn);
        make.bottom.equalTo(self.cancelBtn.mas_top).offset(-10);
        if (_qrCode) {
            make.top.equalTo(self.mas_top).offset(64);
        }else{
            make.height.mas_equalTo(130);
        }
        
    }];
	
}

- (void)initCancelBtn {
	
    if (_cancelBtn) {
        return;
    }
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.backgroundColor = [UIColor whiteColor];
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 5;
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //	点击按钮，取消，收起面板，移除视图
    [_cancelBtn addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(BUTTON_HEIGHT);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
}


/**
 加载自定义视图，按钮的tag依次为（200 + i）
 */
- (void)loadUIConfig {
    
    
    [self initCancelBtn];
    [self initCenterbgView];
    [self initShareButtonView];
    if (_qrCode) {
        [self initTitleView];
        [self initSaveButton];
        [self initQRcodeView];
        [self creatCodeImageView:_shareContent];
    }
    
}

-(void)creatCodeImageView:(NSString *)shareContent
{
    UIImage *codeImage = [UIImage imageOfQRFromURL: shareContent codeSize: _codeImageHeigth red: 0 green: 0 blue: 0 insertImage:nil  roundRadius: 0.f];
    self.codeImageView.image = codeImage;
    
}


/**
 点击取消
 */
- (void)tappedCancel {
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.bgView setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

/**
 按钮点击
 
 @param tapGes 手势
 */
- (void)itemClick:(UITapGestureRecognizer *)tapGes {
    
    [self tappedCancel];
    if (self.btnClick) {
        
        self.btnClick(tapGes.view.tag - 200);
    }
}

-(void)shareClick:(UIButton *)sender{
    [self tappedCancel];
    if (self.btnClick) {
        
        self.btnClick(sender.tag - 200);
    }
}

-(void)saveQRcode:(UIButton *)sender{
    NSLog(@"保存图片");
    
    UIImage *codeImage = [self screenShot: _QrCodeView]; //截图_code.layer.cornerRadius = 10;
    codeImage = [codeImage imageByRoundCornerRadius:5]; //使它保存图片后为正方形
    
    if (codeImage) {
        UIImageWriteToSavedPhotosAlbum(codeImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {
        message = @"保存成功";
    } else {
        message = @"图片保存失败";
    }
    
    [self showRightWithTitle:message autoCloseTime:2];
}

-(UIImage *)screenShot:(UIView *)view
{
    CGSize size = view.frame.size;
    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    [view drawViewHierarchyInRect:rect  afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

@end
