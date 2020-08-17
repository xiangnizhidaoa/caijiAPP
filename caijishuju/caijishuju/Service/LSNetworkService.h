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

@end
