//
//  MSTabBarView.m
//  MSCustomTabBarController
//
//  Created by MrSong on 16/6/7.
//  Copyright © 2016年 MrSong. All rights reserved.
//

#import "MSTabBarView.h"

@interface MSTabBarView ()

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *items;

@property (nonatomic, assign) NSInteger selectIndex;
@property (weak, nonatomic) IBOutlet UIButton *xuqiuBtn;

@end

@implementation MSTabBarView

#pragma mark - Life Cycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectIndex = 0;
    UIButton *selectdBtn = _items[0];
    selectdBtn.selected = YES;
    [selectdBtn setTitleColor:[UIColor btnBlueColor] forState:UIControlStateSelected];
    
    //去掉按钮按下去的阴影
    for (UIButton *btn in _items) {
        btn.adjustsImageWhenHighlighted = NO;
        [btn setTitleColor:[UIColor textLabelColor] forState:UIControlStateNormal];
    }
    _xuqiuBtn.adjustsImageWhenHighlighted = NO;
    [_xuqiuBtn setTitleColor:[UIColor textLabelColor] forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)selectItem:(UIButton *)sender
{
    //找到上次
    UIButton *lastItem = _items[_selectIndex];
    lastItem.selected = NO;
    [lastItem setTitleColor:[UIColor textLabelColor] forState:UIControlStateNormal];
    
    sender.selected = YES;
    [sender setTitleColor:[UIColor btnBlueColor] forState:UIControlStateSelected];
    // button的tag对应tabBarController的selectedIndex
    // 设置选中button的样式
    self.selectIndex = sender.tag;
    // 让代理来处理切换viewController的操作
    if ([self.viewDelegate respondsToSelector:@selector(msTabBarView:didSelectItemAtIndex:)]) {
        [self.viewDelegate msTabBarView:self didSelectItemAtIndex:sender.tag];
    }
}

- (IBAction)clickCenterItem:(id)sender
{
    // 让代理来处理点击中间button的操作
    if ([self.viewDelegate respondsToSelector:@selector(msTabBarViewDidClickCenterItem:)]) {
        [self.viewDelegate msTabBarViewDidClickCenterItem:self];
    }
}
-(void)setItemIndex:(NSInteger)itemIndex{

    //找到上次
    UIButton *lastItem = _items[_selectIndex];
    lastItem.selected = NO;
    [lastItem setTitleColor:[UIColor textLabelColor] forState:UIControlStateNormal];
    
    UIButton *btn = [self viewWithTag:itemIndex];
    btn.selected = YES;
    [btn setTitleColor:[UIColor btnBlueColor] forState:UIControlStateSelected];
    self.selectIndex = btn.tag;
    // 让代理来处理切换viewController的操作
    if ([self.viewDelegate respondsToSelector:@selector(msTabBarView:didSelectItemAtIndex:)]) {
        [self.viewDelegate msTabBarView:self didSelectItemAtIndex:btn.tag];
    }

}

#pragma mark - Setter

//- (void)setSelectIndex:(NSInteger)selectIndex
//{
//    // 先把上次选择的item设置为可用
//    UIButton *lastItem = _items[_selectIndex];
//    lastItem.enabled = YES;
//    // 再把这次选择的item设置为不可用
//    UIButton *item = _items[selectIndex];
//    item.enabled = NO;
//    _selectIndex = selectIndex;
//}

@end
