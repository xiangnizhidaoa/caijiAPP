//
//  BSUrl.h
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/25.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BS_Url [BSUrl getInstance]
/** 请求地址 */
#ifdef DEBUG
#define HostUrl @"https://farmviewer.digitaltest.cn/web"
#else
#define HostUrl @"https://farmviewer.digitaltest.cn/web"
#endif

/** 接口定义 */
@interface BSUrl : NSObject

+ (BSUrl*)getInstance;

@property (nonatomic, copy) NSString *loginUrl;/** 一键登录 */

@property (nonatomic, copy) NSString *getCode;/** 获取验证码 */

@property (nonatomic, copy) NSString *handbook;/** 使用手册 */

@property (nonatomic, copy) NSString *MyTask;/** 我的任务 */

@property (nonatomic, copy) NSString *isLogin;/** 用户是否登录 */

@property (nonatomic, copy) NSString *logOut;/** 退出登录 */

@property (nonatomic, copy) NSString *myCollection;/** 我的采集 */

@property (nonatomic, copy) NSString *deleat;/** 删除接口 */

@property (nonatomic, copy) NSString *regiest;/** 注册 */

@property (nonatomic, copy) NSString *password;/** 找回密码 */

@property (nonatomic, copy) NSString *downImage;/** 下载图片 */

@property (nonatomic, copy) NSString *imageID;/** 获取图片加载ID */
/** 数据采集 */
@property (nonatomic, copy) NSString *dataSave;

@property (nonatomic, copy) NSString *upLoadImage;/** 上传图片 */

@property (nonatomic, copy) NSString *zhiwuImage;/** 植物识别 */

@property (nonatomic, copy) NSString *taskStatise;/** 任务状态 */


+ (NSString *)hostUrlWithParam:(NSString *)param;

@end
