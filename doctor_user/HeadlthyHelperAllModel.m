//
//  HeadlthyHelperAllModel.m
//  doctor_user
//
//  Created by dong on 2017/8/9.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "HeadlthyHelperAllModel.h"

@implementation HeadlthyHelperAllModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{@"mealth":[HeadlthyAllMealthModel class],@"health_medication":[HeadlMedictionModel class],@"health_medical":[HeadlMedicalModel class],@"health_history":[healthHistModel class]};

}




@end

@implementation HeadlthyAllMealthModel



@end
@implementation HeadlMedictionModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    
    return @{@"detail":[headlthyDetailModel class]};
    
}

@end

@implementation HeadlMedicalModel



@end

@implementation healthHistModel

-(NSString *)year{
    if (![NSString isEmpty:_history_time]) {
        return [_history_time substringWithRange:NSMakeRange(0,3)];
    }
    return @"";
}

-(NSString *)month{
    if (![NSString isEmpty:_history_time]) {
        return [_history_time substringWithRange:NSMakeRange(5,2)];
    }
    return @"";
}
-(NSString *)day{
    if (![NSString isEmpty:_history_time]) {
        return [_history_time substringWithRange:NSMakeRange(8,2)];
    }
    return @"";
}


@end

@implementation headlthyDetailModel



@end


