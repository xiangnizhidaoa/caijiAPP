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
    [[MK_UseAFNetWorking NewNewWork] postNetWorkPostWithPostDic:dic Url:BS_Url.loginUrl headerDic:nil withCompletion:^(id completion) {
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
