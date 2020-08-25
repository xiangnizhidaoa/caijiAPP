//
//  LSNetworkService.m
//  LotterySelect
//
//  Created by 鹏 刘 on 16/5/5.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "LSNetworkService.h"
#import "BSUrl.h"

@implementation LSNetworkService

//登录
+(void)postLoginWithDic:(NSDictionary *)dic response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?userName=%@&plainPassword=%@&openid=%@",BS_Url.loginUrl,dic[@"userName"],dic[@"password"],@""];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//获取验证码
+(void)getPhoneCodeWithPhone:(NSString *)phone response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?type=%@&phone=%@",BS_Url.getCode,@"2",phone];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//验证码登录
+(void)getCodeLoginWithDic:(NSDictionary *)dic response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?userName=%@&yanzhengma=%@",BS_Url.loginUrl,dic[@"userName"],dic[@"password"]];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//使用手册
+(void)getHandBookResponse:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?wxhelp=%@",BS_Url.handbook,@"false"];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//我的任务
+(void)getMyTaskWithDic:(NSDictionary *)dic response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?istask=ture&pageNo=%@&pageSize=%@&zuowumc=%@&token=%@",BS_Url.MyTask,dic[@"pageNo"],dic[@"pageSize"],dic[@"zuowumc"],App_Utility.currentUser.token];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//是否登录(token是否过期)
+(void)getIsLoginResponse:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?token=%@",BS_Url.isLogin,App_Utility.currentUser.token];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}























+ (NSString *)getNowTime{
    
    //获取当前时间戳
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", time];
    
    return timeSp;
}

@end
