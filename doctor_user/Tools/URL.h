//
//  URL.h
//  doctor_user
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#ifndef URL_h
#define URL_h

#define FT_INLINE static inline
FT_INLINE  NSString  *getRequestPath(NSString *act) ;
FT_INLINE NSString *imageAddress();

//接口域名
#define PUBLISH_DIMAIN_URL @"http://weixin.ys9958.com/index.php/api/"

#pragma mark  ----新接口 --------------------
FT_INLINE  NSString  * getNewRequestPath(NSString *act) {
    return [PUBLISH_DIMAIN_URL stringByAppendingFormat:@"%@",
            act];
}
//热点
#define Hotspot_Url getNewRequestPath(@"Hotspot/index")

//健康助手
#define HealthIndex_Url  getNewRequestPath(@"HealthAides/index")

//添加健康助手ID
#define HealthyAddHealthy_Url  getNewRequestPath(@"HealthAides/index")
//添加（修改）药物
#define HealthyAdd_med_Url  getNewRequestPath(@"HealthAides/add_med")
//删除药物
#define HealthyDel_Url    getNewRequestPath(@"HealthAides/del_medication")
//修改嘱咐
#define HealthyAlterMed_Url  getNewRequestPath(@"HealthAides/add_medication")
//用药提醒设置
#define HealthySound_Url  getNewRequestPath(@"HealthAides/sound")
//添加（修改）就诊提醒
#define HealthyMedical_Url  getNewRequestPath(@"HealthAides/health_medical")
//删除就医提醒
#define HealthyMedlicalDel_Url getNewRequestPath(@"HealthAides/del_medical")
//就医历史
#define HealthAides_Url  getNewRequestPath(@"HealthAides/history")
//健康档案
#define HealthyFiles_Url  getNewRequestPath(@"HealthAides/health")
//修改健康档案
#define HealthyFiles_updata_Url   getNewRequestPath(@"HealthAides/healths")



//疑难杂症
#define Diseases_Url    getNewRequestPath(@"Diseases/index")
//获取疑难杂症列表
#define DiseasesList_Url  getNewRequestPath(@"Diseases/diseasesList")
//疑难杂症详情
#define DisasesDeta_Url  getNewRequestPath(@"Diseases/diseasesInfo")

//私人医生
#define PrivateDoctor_Url  getNewRequestPath(@"PrivateDoctor/index")
//档案信息卡
#define PrivateDoctorFileCark_Url  getNewRequestPath(@"PrivateDoctor/fileCard")
//预约服务
#define PrivateDoctoAppointment_Url  getNewRequestPath(@"PrivateDoctor/appointment")


//图片路径
FT_INLINE NSString *imageAddress()
{
    return [PUBLISH_DIMAIN_URL stringByAppendingFormat:@"Manment/Public/Uploads/"];
}
//获取域名
FT_INLINE NSString *getDomainName(){
    return PUBLISH_DIMAIN_URL ;
}


#endif /* URL_h */
