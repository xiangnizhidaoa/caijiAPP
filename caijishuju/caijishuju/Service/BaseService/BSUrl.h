//
//  BSUrl.h
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/25.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BS_Url [BSUrl getInstance]

#ifdef DEBUG
#define HostUrl @"https://farmviewer.digitaltest.cn/web"
#else
#define HostUrl @"https://farmviewer.digitaltest.cn/web"
#endif


@interface BSUrl : NSObject

+ (BSUrl*)getInstance;

@property (nonatomic, copy) NSString *loginUrl;//一键登录


+ (NSString *)hostUrlWithParam:(NSString *)param;

@end
