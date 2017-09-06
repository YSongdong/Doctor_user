//
//  TakeDrugFootView.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TakeDrugFootView.h"

#import "SDRemind.h"
@interface TakeDrugFootView ()

@property (weak, nonatomic) IBOutlet UIButton *addDrugBtn; //添加药品
@property (weak, nonatomic) IBOutlet UIView *backGrouView;//背景view

- (IBAction)addDrugBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *editBtn; //编辑
- (IBAction)editBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextView *footTextView; //

@property (nonatomic,strong)  UILocalNotification *localNotification; //本地推送

@end


@implementation TakeDrugFootView

-(void)awakeFromNib
{
    [super awakeFromNib];
   
    [self updataUI];
  
}
-(void)updataUI{

    self.addDrugBtn.layer.borderWidth = 1;
    self.addDrugBtn.layer.borderColor = [UIColor btnBroungColor].CGColor;
    self.addDrugBtn.layer.cornerRadius = 5;
    self.addDrugBtn.layer.masksToBounds = YES;
    
    //背景view
    self.backGrouView.layer.borderWidth = 1;
    self.backGrouView.layer.borderColor = [UIColor lineColor].CGColor;
    self.backGrouView.layer.cornerRadius = 5;
    self.backGrouView.layer.masksToBounds = YES;
    
    self.footTextView.scrollEnabled = NO;
    //设置不可用
    self.footTextView.editable = NO;

 

}
#pragma mark  --- UITextViewDelegate---
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == self.footTextView) {
        if (range.location == 0){
           
            return YES;
        }else{
           
        }
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 90) {
            return NO;
        }
    }
    
    //如果用户点击了return
    if([text isEqualToString:@"\n"]){
        
        [self.footTextView becomeFirstResponder];
        
        return NO;
    }
    return YES;
}
//添加药品
- (IBAction)addDrugBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdAddTakeDrugBtn)]) {
        [self.delegate selectdAddTakeDrugBtn];
    }
    
}

-(void)setModel:(HeadlMedictionModel *)model
{
    _model = model;
    
   
    //
    self.footTextView.text = model.orders;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.footTextView  becomeFirstResponder];

}
//编辑（保存按钮）
- (IBAction)editBtnAction:(UIButton *)sender {
    sender.selected =!sender.selected;
    if (sender.selected) {
        
        [self.editBtn setTitle:@"保存" forState:UIControlStateNormal];
        self.footTextView.editable = YES;
        
    }else{
    
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.footTextView.editable = NO;
        [self.footTextView  becomeFirstResponder];
        NSMutableDictionary *param =[NSMutableDictionary dictionary];
        param[@"orders"] = self.footTextView.text;
        param[@"medication_id"] = self.model.medication_id;

        if ([self.delegate respondsToSelector:@selector(selectdSaveBtnAction:)]) {
            [self.delegate selectdSaveBtnAction:param.copy];
        }
    }
    
}

-(void)setIsSave:(BOOL)isSave
{
    _isSave = isSave;
    if (isSave) {
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.footTextView.editable = NO;
        [self.footTextView  becomeFirstResponder];
        
    }

}









@end
