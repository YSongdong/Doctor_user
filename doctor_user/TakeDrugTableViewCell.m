//
//  TakeDrugTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TakeDrugTableViewCell.h"

@interface TakeDrugTableViewCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *drugBackgrounView; //背景view

@property (weak, nonatomic) IBOutlet UITextField *drugNameTF; //药名TF
@property (weak, nonatomic) IBOutlet UILabel *showTimeCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)saveBtnAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *selectdTimeBtn; //选择时间背景btn


@property (weak, nonatomic) IBOutlet UITextField *drugDayTF;//用药天数TF
@property (weak, nonatomic) IBOutlet UIButton *drugEditBtn; //编辑按钮

- (IBAction)EditDeleteBtnAction:(UIButton *)sender;


- (IBAction)selectdTimeBtnAction:(UIButton *)sender; //选择时间按钮

@property(nonatomic,assign) BOOL isEdit; //是否编辑状态

- (IBAction)drugDayBtnAction:(UIButton *)sender; //用药天数


@property(nonatomic,strong) NSMutableDictionary *param; //配置


@end



@implementation TakeDrugTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置默认状态下
    self.isEdit = NO;
    [self updateUI];
    [self.drugNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)updateUI{
    //背景view
    self.drugBackgrounView.layer.borderWidth = 1;
    self.drugBackgrounView.layer.borderColor = [UIColor lineColor].CGColor;
    self.drugBackgrounView.layer.cornerRadius = 5;
    self.drugBackgrounView.layer.masksToBounds = YES;
   
    //删除按钮
    [self.drugEditBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.drugEditBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
 
    //隐藏保存按钮
    self.saveBtn.hidden = YES;
    
    self.drugNameTF.delegate = self;
    self.drugDayTF.delegate = self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.drugNameTF resignFirstResponder];
    [self.drugDayTF resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(closeRmoveView)]) {
        [self.delegate closeRmoveView];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;

}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.drugNameTF) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}
//结束编辑状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.drugNameTF) {
        self.drugNameTF.text = textField.text;
        self.param[@"drug"] = textField.text;
    }else if (textField == self.drugDayTF){
        self.drugDayTF.text =  [NSString stringWithFormat:@"%@",textField.text];
        self.param [@"day"] = textField.text;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//删除按钮
- (IBAction)EditDeleteBtnAction:(UIButton *)sender {
    //删除单元格
    if ([self.delegate respondsToSelector:@selector(selectdDeleteBtn:andWarnID:)]) {
        [self.delegate selectdDeleteBtn:self.indexPath andWarnID:self.model.warn_id];
    }
  
}

-(void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    
    if (!_isEdit) {
        self.drugNameTF.enabled = NO;
        self.selectdTimeBtn.enabled = NO;
        self.drugDayTF.enabled = NO;
       
    }else{
        self.drugNameTF.enabled = YES;
        self.selectdTimeBtn.enabled = YES;
        self.drugDayTF.enabled = YES;
    
    }
    
}

//选择时间按钮
- (IBAction)selectdTimeBtnAction:(UIButton *)sender {
   
        //创建时间选择
        if ([self.delegate  respondsToSelector:@selector(selectdTimeBtnAction:)]) {
            [self.delegate  selectdTimeBtnAction:self.indexPath];
        }
   
    
   
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
    
}
-(void)setModel:(headlthyDetailModel *)model
{

    _model = model;
    
    //药品
    self.drugNameTF.text = model.drug;
    
    //天
    self.drugDayTF.text = [NSString stringWithFormat:@"%@",model.day];
    
    //次数
    self.timeCountLabel.text = model.second;
    
    
}

//用药天数
- (IBAction)drugDayBtnAction:(UIButton *)sender {
    
    [self.drugDayTF becomeFirstResponder];
}

-(NSMutableDictionary *)param{

    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }

    return _param;
}

//改变保存状态
-(void)setIsAdd:(BOOL)isAdd{
    
    _isAdd = isAdd;
    if (isAdd) {
        self.isEdit = isAdd;
        self.saveBtn.hidden = NO;
    }else{
       self.saveBtn.hidden = YES;
    }
   

}

- (IBAction)saveBtnAction:(UIButton *)sender {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"day"]=  self.drugDayTF.text;
    param[@"drug"] = self.drugNameTF.text;
    param[@"second"] =self.timeCountLabel.text;
    if ([self.delegate  respondsToSelector:@selector(selectdSaveBtnAction:andIndexPath:)]) {
        [self.delegate  selectdSaveBtnAction:param.copy andIndexPath:self.indexPath];
    }
    
}
@end
