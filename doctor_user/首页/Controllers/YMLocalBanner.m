//
//  SHLocalBanner.m
//  ShuangHe
//
//  Created by 谭攀 on 16/10/16.
//  Copyright © 2016年 shuanghe. All rights reserved.
//

#import "YMLocalBanner.h"

@interface YMLocalBanner()<UIScrollViewDelegate>

/**
 *  滑动试图
 */
@property (strong, nonatomic) UIScrollView * scrollView;

/**
 *  系统PageControl
 */
@property (strong, nonatomic) UIPageControl * systemPageCtrl;

/**
 *  定时器
 */
@property (strong, nonatomic) NSTimer * timer;

/**
 *firstModel + models + lastModel
 */
@property (strong, nonatomic) NSMutableArray<YMLocalBannerModel *> *banners;

/**
 *  scollView的宽度
 */
@property (assign, nonatomic) CGFloat scrollViewWidth;

/**
 *  标志位
 */
@property (assign, nonatomic) NSInteger scrollFlag;

@end

@implementation YMLocalBanner

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollViewWidth = self.width;
}

#pragma mark - private method
- (void)initView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    // 隐藏水平导航栏
    self.scrollView.showsHorizontalScrollIndicator = NO;
    // 设置分页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
     self.scrollView.scrollEnabled = NO;
    self.systemPageCtrl = [[UIPageControl alloc] init];
    
    self.systemPageCtrl.pageIndicatorTintColor = [UIColor whiteColor];
    self.systemPageCtrl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.systemPageCtrl.backgroundColor =[UIColor blackColor];
    self.systemPageCtrl.alpha = 0.3;
    self.systemPageCtrl.enabled = NO;
    [self addSubview:self.systemPageCtrl];
    [self insertSubview:self.systemPageCtrl aboveSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_systemPageCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@40);
        make.bottom.equalTo(_scrollView.mas_bottom);
    }];
    
//    _pageLabel = [[UILabel alloc] init];
//    _pageLabel.layer.cornerRadius = 25.0;
//    _pageLabel.textAlignment = NSTextAlignmentCenter;
//    _pageLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//    [self insertSubview:_pageLabel aboveSubview:self.scrollView];
}
/**
 *  为滑动试图设置数据
 */
- (void)setScrollViewData: (NSArray<YMLocalBannerModel *> *) banners {
    
    if (_timer) {
        [self.timer invalidate];
    }
    
    // 设置滑动视图的实际尺寸
    [self layoutIfNeeded];
    [self setNeedsLayout];
    [self.scrollView removeAllSubviews];
    self.scrollView.contentSize = CGSizeMake(self.width * banners.count, self.height);
    // 设置滑动视图的偏移量
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
    for (int i = 0; i < banners.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
        CGRect frame = CGRectMake(i * self.width, 0, self.width, self.height);
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView.mas_top);
            make.leading.mas_equalTo(frame.origin.x);
            make.size.mas_equalTo(self.scrollView.size);
            //make.bottom.equalTo(self.scrollView.mas_bottom);
        }];
        
       YMLocalBannerModel *model  = banners[i];
        imageView.tag = 100 + i;
        imageView.contentMode = UIViewContentModeScaleToFill;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.adv_image]
                  placeholderImage:[UIImage imageNamed:@"default_icon"]];
        
        //添加点击事件
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [imageView addGestureRecognizer:tapGesture];
        
    }
    // 设置分页控件的页数
    //[self.scrollView setContentOffset:CGPointMake(_scrollFlag * self.width, 0) animated:NO];
    self.systemPageCtrl.numberOfPages = banners.count - 2;
    if (banners.count > 3) {
        [self addTimer];
    }
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGes {
    UIImageView *imageView = (UIImageView *)tapGes.view;
    NSInteger index = imageView.tag - 100;
    if (_delegate && [_delegate respondsToSelector:@selector(banner:didClickBanner:)]) {
        [_delegate banner:self didClickBanner:_banners[index]];
    }
}

/**
 *  添加定时器
 */
- (void)addTimer{
    
    if (!_autoScroll) {
        return;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(turnToNextBanner)
                                       userInfo:nil
                                        repeats:YES];
    // 设置RunLoop模式，保证在tableView拖动的时候定时器仍然运行
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    if (!self.timer) {
    }
}

/**
 *  移除定时器
 */
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)turnToNextBanner {
    // 计算scrollView滚动的位置
    CGFloat offsetX = _scrollFlag * self.width;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    if (_scrollFlag > self.banners.count - 2) {
        _scrollFlag = 1;
    } else {
        _scrollFlag ++;
    }
}

/**
 *  设置PageControl的当前页
 */
- (void)setPageCtrlCurrentPage:(NSInteger)currentPage {
    self.systemPageCtrl.currentPage = currentPage;

    [self noticeDelegateDidChangeViewWithIndex:currentPage];
}

/**
 *  通知代理对象
 */
- (void)noticeDelegateDidChangeViewWithIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(banner:didChangeViewWithIndex:)]) {
        [self.delegate banner:self didChangeViewWithIndex:index];
    }
}

#pragma make - set && get
- (void)setModels:(NSArray<YMLocalBannerModel *> *)models {
    _models = models;
    if (_models.count == 0) {
        [self.scrollView removeAllSubviews];
        return;
    }
    YMLocalBannerModel *firstModel = [_models firstObject];
    YMLocalBannerModel *lastModel = [_models lastObject] ;
    _banners = [NSMutableArray arrayWithObject:lastModel];
    [_banners addObjectsFromArray:_models];
    [_banners addObject:firstModel];
    [self setScrollViewData:_banners];
}

#pragma mark - 更新PageController的当前页

/**
 *  更新PageController的当前页
 *
 *  @param contentOffset_x 当前滑动试图内容的偏移量
 */
- (void)updatePageCtrlWithContentOffset:(CGFloat)contentOffset_x{
    // 一定要用float类型，非常重要
    CGFloat index = contentOffset_x / (self.width) ;
    
    if (index >= self.banners.count - 1) {
        // 滑到最后一个按钮（表面是第一个）
        //设置视图的偏移量到第二个按钮
        self.scrollView.contentOffset = CGPointMake(self.width, 0);
        [self setPageCtrlCurrentPage:0];
        //self.titleLabel.text = [self.model firstObject];
    }else if(index <= 0){
        // 滑到第一个按钮（表面是最后一个）
        self.scrollView.contentOffset = CGPointMake((self.banners.count - 2) *self.width, 0);
        [self setPageCtrlCurrentPage:self.banners.count - 3];
    } else {
        //设置_pageCtrl显示的页数（减去第一个按钮）
        [self setPageCtrlCurrentPage:index - 1];
    }
    _scrollFlag = self.systemPageCtrl.currentPage + 2;
}

#pragma mark - UIScrollViewDelegate

/**
 *  在手指已经开始拖住的时候移除定时器
 *
 *  @param scrollView 滑动试图
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_timer) {
        [self.timer invalidate];
    }
}

/**
 *  在手指已经停止拖住的时候添加定时器
 *
 *  @param scrollView 滑动试图
 *  @param decelerate 是否有减速效果
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
    if (_timer == nil) {
    }
}

/**
 *  当滑动试图停止减速（停止）调用（用于手动拖拽）
 *
 *  @param scrollView 滑动试图
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updatePageCtrlWithContentOffset:scrollView.contentOffset.x];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updatePageCtrlWithContentOffset:scrollView.contentOffset.x];
}

/**
 当滑动试图停止减速调用（用于定时器）
 
 @param scrollView 滑动试图
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updatePageCtrlWithContentOffset:scrollView.contentOffset.x];
}

@end
