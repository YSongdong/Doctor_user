//
//  RemindTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RemindTableViewCell.h"

#import "SDRemind.h"

@interface RemindTableViewCell () <UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *remindBackgrouView;

@property (weak, nonatomic) IBOutlet UIButton *editDelBtn;
- (IBAction)editDelBtnAction:(UIButton *)sender;

- (IBAction)saveBtnAction:(UIButton *)sender;

- (IBAction)selectdTimeBtnAction:(UIButton *)sender;//选择时间


- (IBAction)selectdDepBtnAction:(UIButton *)sender;//选择科室
//科室label

@property (weak, nonatomic) IBOutlet UITextField *selectdDoctorTF;//输入医生

@property (weak, nonatomic) IBOutlet UIButton *saveBtn; //保存按钮


@property(nonatomic,assign) BOOL isEdit; //是否编辑状态
@property (weak, nonatomic) IBOutlet UITextView *attentionTextView;//注意事项textview

- (IBAction)selectdDoctorBtnAction:(UIButton *)sender;//点击输入医生
@property (weak, nonatomic) IBOutlet UIButton *selectdTimeBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectdDoctorBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectdDepBtn;

@property (nonatomic,strong) NSMutableDictionary *params; //配置





@property (nonatomic,strong)  UILocalNotification *localNotification; //本地推送


@end

@implementation RemindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.isEdit = NO;
    [self updateUI];
    
}

-(void)updateUI{
    //背景view
    self.remindBackgrouView.layer.borderWidth = 1;
    self.remindBackgrouView.layer.borderColor = [UIColor lineColor].CGColor;
    self.remindBackgrouView.layer.cornerRadius = 5;
    self.remindBackgrouView.layer.masksToBounds = YES;
    
    //编辑按钮
    [self.editDelBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.editDelBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
   
    
    self.saveBtn.hidden = YES;
    self.selectdDoctorTF.delegate = self;
    self.attentionTextView.delegate = self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.selectdDoctorTF resignFirstResponder];
    [self.attentionTextView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(closeRmoveView)]) {
        [self.delegate closeRmoveView];
    }
}

#pragma mark  --- UITextFeildDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.selectdDoctorTF resignFirstResponder];
    
    return YES;


}

#pragma mark  --- UITextViewDelegate---
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == self.attentionTextView) {
        if (range.location == 0){
            
            return YES;
        }
        
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 150) {
            return NO;
        }
    }
    
    //如果用户点击了return
    if([text isEqualToString:@"\n"]){
        
        [self.attentionTextView becomeFirstResponder];
        
        return NO;
    }
    return YES;
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{

    _indexPath = indexPath;
}
//编辑
- (IBAction)editDelBtnAction:(UIButton *)sender {
  
    //删除单元格
    if ([self.delegate respondsToSelector:@selector(selectdDelRemindBtnAction:andMedicalID:)]) {
        [self.delegate selectdDelRemindBtnAction:self.indexPath andMedicalID:self.model.medical_id];
    }
    
    
}
//保存
- (IBAction)saveBtnAction:(UIButton *)sender {

    self.params[@"doctor"] = self.selectdDoctorTF.text;
    self.params[@"remarks"]= self.attentionTextView.text;
    self.params[@"doctor_time"] = self.timeLabel.text;
    self.params[@"medical_id"] = self.model.medical_id;
  
    if ([self.delegate respondsToSelector:@selector(selectdSaveBtnAction:andNSDict:)]) {
        [self.delegate selectdSaveBtnAction:self.indexPath andNSDict:self.params.copy];
    }
}
//选择时间
- (IBAction)selectdTimeBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectdRemindTimeBtnAction:)]) {
        [self.delegate selectdRemindTimeBtnAction:self.indexPath];
    }
    
}
//选择科室
- (IBAction)selectdDepBtnAction:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector(selectdDepBtnAction:)]) {
        [self.delegate selectdDepBtnAction:self.indexPath];
    }
}
-(void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    
    if (!_isEdit) {
        self.timeLabel.enabled = NO;
        self.selectdDoctorTF.enabled = NO;
        self.departmentLabel.enabled = NO;
        self.selectdDoctorTF.enabled = NO;
        self.selectdDepBtn.enabled = NO;
        self.selectdTimeBtn.enabled = NO;
        self.selectdDoctorBtn.enabled = NO;
        self.attentionTextView.editable = NO;
       
    }else{
        self.timeLabel.enabled = YES;
        self.selectdDoctorTF.enabled = YES;
        self.departmentLabel.enabled = YES;
        self.selectdDoctorTF.enabled = YES;
        self.selectdDepBtn.enabled = YES;
        self.selectdTimeBtn.enabled = YES;
        self.selectdDoctorBtn.enabled = YES;
        self.attentionTextView.editable = YES;
       
    }
    
}

-(void)setModel:(HeadlMedicalModel *)model
{
    _model = model;
    
    //时间
    self.timeLabel.text = model.doctor_time;
    //医生
    self.selectdDoctorTF.text = model.doctor;
    //科室
    self.departmentLabel.text = model.small_ksh;
    //注意事项
    self.attentionTextView.text = model.remarks;
    
    
    
}

//输入医生
- (IBAction)selectdDoctorBtnAction:(UIButton *)sender {
    //获取焦点
    [self.selectdDoctorTF becomeFirstResponder];
    
}

-(NSMutableDictionary *)params{

    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return   _params;

}
//改变保存状态
-(void)setIsAdd:(BOOL)isAdd{
    
    _isAdd = isAdd;
    if (isAdd) {
        
        self.isEdit =isAdd;
        self.saveBtn.hidden = NO;
    }else{
        
        self.isEdit =NO;
        self.saveBtn.hidden = YES;
    }
   
}


@end
