//
//  YMMyBackCardTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMMyBankInfoModel.h"
#import "YMAlipayInfoModel.h"

typedef enum : NSUInteger {
    bankType,
    alipayType,
} CellType;

@class YMMyBackCardTableViewCell;

@protocol YMMyBackCardTableViewCellDelegate <NSObject>

-(void)MyBackCardViewCell:(YMMyBackCardTableViewCell *)MyBackCardViewCell  alipayModel:(YMAlipayInfoModel *)alipayModel add:(BOOL)add ;

-(void)MyBackCardViewCell:(YMMyBackCardTableViewCell *)MyBackCardViewCell  bankModel:(YMMyBankInfoModel *)bankModel add:(BOOL)add ;

@end

@interface YMMyBackCardTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL showSelectButton;

//@property(nonatomic,copy) NSString *bankName;
//@property(nonatomic,copy)NSString *backCardIDName;
//@property(nonatomic,copy)NSString *userName;

@property(nonatomic,assign)BOOL firstCell;

@property(nonatomic,assign)CellType type;

@property(nonatomic,weak)id<YMMyBackCardTableViewCellDelegate> delegate;

@property(nonatomic,strong)YMMyBankInfoModel *bankInfoModel;
@property(nonatomic,strong)YMAlipayInfoModel *alipayInfoModel;


@end
