//
//  YMYinanImageTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMYinanImageTableViewCell.h"
@interface YMYinanImageTableViewCell()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet KRMyTextView *myTextView;
@property (weak, nonatomic) IBOutlet UIStackView *imageStackView;

@end
@implementation YMYinanImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    for (UIImageView *imageView in self.imageStackView.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [tap addTarget:self action:@selector(imageBtnClick:)];
        }
    }
    
}
- (void)imageBtnClick:(UITapGestureRecognizer *)sender {
    if (self.block) {
        self.block(sender.view.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDetailDataWith:(NSDictionary *)dic {
    NSLog(@"%@",dic);
    self.myTextView.myPlaceholder = @"请在此描述您的诊断情况，上传诊断材料有助于医生了解您的病情（必填）";
    self.myTextView.delegate = self;
    self.myTextView.text = dic[@"title"];
    NSArray *array = dic[@"images"];
    NSMutableArray *tagArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        UIImageView *imageViews = [self.imageStackView viewWithTag:[dic[@"tag"] integerValue]];
        NSLog(@"%@",imageViews);
        
        imageViews.image = [self thumImageWithImage:dic[@"image"]];
        
        [tagArray addObject:dic[@"tag"]];
    }
    NSMutableArray *array1 = [@[@101,@102,@103,@104,@105,@106] mutableCopy];
    NSMutableArray *mut1 = [array1 mutableCopy];
    
    for (NSNumber *num in mut1) {
        if ([tagArray containsObject:num]) {
            [array1 removeObject:num];
        }
    }
    for (NSNumber *num in array1) {
        UIImageView *imageView = [self.imageStackView viewWithTag:[num integerValue]];
        if ([num integerValue] != 106) {
            imageView.image = [UIImage imageNamed:@"照片框_03"];
        } else {
            imageView.image = [UIImage imageNamed:@"照片框_05"];
        }
    }
    
    
}
- (UIImage *)thumImageWithImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(65, 65), NO, [UIScreen mainScreen].scale);
    //UIGraphicsBeginImageContext(CGSizeMake(30, 30));
    
    [image drawInRect:CGRectMake(0, 0, 65, 65)];
    
    UIImage *nowImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return nowImage;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self endEditing:YES];
    if (self.inpuBlock) {
        self.inpuBlock(textView.text);
    }
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [self endEditing:YES];
    if (self.inpuBlock) {
        self.inpuBlock(textView.text);
    }
    return YES;
}
@end
