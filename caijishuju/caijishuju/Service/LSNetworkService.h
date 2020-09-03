//
//  LSNetworkService.h
//  LotterySelect
//
//  Created by 鹏 刘 on 16/5/5.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicesDefine.h"

@interface LSNetworkService : NSObject

//一键登录
+(void)postLoginWithDic:(NSDictionary *)dic response:(BSResponse)response;

//获取验证码
+(void)getPhoneCodeWithPhone:(NSString *)phone response:(BSResponse)response;

//验证码登录
+(void)getCodeLoginWithDic:(NSDictionary *)dic response:(BSResponse)response;

//使用手册
+(void)getHandBookResponse:(BSResponse)response;

//我的任务
+(void)getMyTaskWithDic:(NSDictionary *)dic response:(BSResponse)response;

//是否登录(token是否过期)
+(void)getIsLoginResponse:(BSResponse)response;

//退出登录
+(void)getLogOutResponse:(BSResponse)response;

//我的采集
+(void)getMyCollectionWithDic:(NSDictionary *)dic response:(BSResponse)response;

//删除数据填报
+(void)getDeleatWithID:(NSString *)ID response:(BSResponse)response;

//注册
+(void)postRegiestWithDic:(NSDictionary *)dic response:(BSResponse)response;

//找回密码
+(void)getPasswordWithDic:(NSDictionary *)dic response:(BSResponse)response;

/// 数据采集保存请求
+ (void)getDataCollectionSaveWithString:(NSString *)bodyStr response:(BSResponse)response;

//上传图片
+(void)postUpLoadImageWithDic:(NSDictionary *)dic response:(BSResponse)response;

//图片识别
+(void)getZhiwuImageWithDic:(NSDictionary *)dic response:(BSResponse)response;

@end
