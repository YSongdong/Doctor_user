//
//  YMHomeBtnTableViewCell.h
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    FUWUMINGXING,
    MINGYI,
    YINANZAZHENG,
    YISHENGKU,
    HUSHIKU
}BTN_TYPE;
typedef void(^BTN_CLICK)(BTN_TYPE type);
@interface YMHomeBtnTableViewCell : UITableViewCell
@property (nonatomic, strong) BTN_CLICK block;
@property (nonatomic, assign) BTN_TYPE btnType;

@end
