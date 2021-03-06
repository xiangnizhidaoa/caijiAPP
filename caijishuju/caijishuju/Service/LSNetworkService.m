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
    NSString *url = [NSString stringWithFormat:@"%@?istask=true&pageNo=%@&pageSize=%@&zuowumc=%@&token=%@&loginName=%@&userid=%@",BS_Url.MyTask,dic[@"pageNo"],dic[@"pageSize"],dic[@"zuowumc"],App_Utility.currentUser.token,App_Utility.currentUser.phone,App_Utility.currentUser.userid];
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

//退出登录
+(void)getLogOutResponse:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?token=%@",BS_Url.logOut,App_Utility.currentUser.token];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//我的采集
+(void)getMyCollectionWithDic:(NSDictionary *)dic response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?pageNo=%@&pageSize=%@&zuowumc=%@&timetype=%@&starttime=%@&endtime=%@&token=%@&loginName=%@&userid=%@",BS_Url.myCollection,dic[@"pageNo"],dic[@"pageSize"],dic[@"zuowumc"],dic[@"timetype"],dic[@"starttime"],dic[@"endtime"],App_Utility.currentUser.token,App_Utility.currentUser.phone,App_Utility.currentUser.userid];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//删除数据填报
+(void)getDeleatWithID:(NSString *)ID response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?id=%@&token=%@",BS_Url.deleat,ID,App_Utility.currentUser.token];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//注册
+(void)postRegiestWithDic:(NSDictionary *)dic response:(BSResponse)response
{
    [[MK_UseAFNetWorking NewNewWork] postNetWorkPostWithPostDic:nil Url:[NSString stringWithFormat:@"%@?lianxidh=%@",BS_Url.regiest,dic[@"lianxidh"]] headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//找回密码
+(void)getPasswordWithDic:(NSDictionary *)dic response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?phone=%@&plainPassword=%@&yanzhengma=%@",BS_Url.password,dic[@"phone"],dic[@"plainPassword"],dic[@"yanzhengma"]];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}




/// 数据采集保存请求
+ (void)getDataCollectionSaveWithString:(NSDictionary *)bodyStr response:(BSResponse)response {
    
    [[MK_UseAFNetWorking NewNewWork] postNetWorkPostWithPostDic:bodyStr Url:[NSString stringWithFormat:@"%@?token=%@",BS_Url.dataSave,App_Utility.currentUser.token] headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
    
}

//上传图片
+(void)postUpLoadImageWithDic:(NSDictionary *)dic response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?type=image&code_id=%@&column=%@&isreplace=%@",BS_Url.upLoadImage,dic[@"code_id"],dic[@"column"],dic[@"isreplace"]];
    NSDictionary *dicc = @{@"files":dic[@"filePath"]};
    [[MK_UseAFNetWorking NewNewWork] postUpLoadDataByString:url BODYDic:nil imageDic:dicc headerDic:nil WithDataBlock:^(id dict) {
        response(dict,nil);
    }];
}

//图片识别
+(void)getZhiwuImageWithDic:(NSDictionary *)dic response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?fileid=%@&token=%@",BS_Url.zhiwuImage,dic[@"fileid"],App_Utility.currentUser.token];
    [[MK_UseAFNetWorking NewNewWork] getNetWorkGetWithGetDic:nil Url:url headerDic:nil withCompletion:^(id completion) {
        response(completion,nil);
    }];
}

//任务状态
+(void)getTaskStatuseWithID:(NSString *)ID response:(BSResponse)response
{
    NSString *url = [NSString stringWithFormat:@"%@?id=%@&token=%@",BS_Url.taskStatise,ID,App_Utility.currentUser.token];
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
