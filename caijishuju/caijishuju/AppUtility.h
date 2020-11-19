//
//  AppUtility.h
//  LotterySelect
//
//  Created by 鹏 刘 on 15/11/26.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>

#define App_Utility [AppUtility getInstance]

@interface LSCurrentUser : NSObject

@property (nonatomic, strong) NSString *userName;/** 用户名 */

@property (nonatomic, strong) NSString *token;/** 校验token */

@property (nonatomic, strong) NSString *eMail; /** 邮箱 */

@property (nonatomic, strong) NSString *mobile;/** 手机号 */

@property (nonatomic, strong) NSString *officeName;/** 办公室名称 */

@property (nonatomic, strong) NSString *phone;/** 电话号码 */

@property (nonatomic, strong) NSString *roleNames;

@property (nonatomic, strong) NSString *userid;/** 用户ID */

@property (nonatomic, strong) NSString *isShow;

@end

@interface AppUtility : NSObject

@property (nonatomic, strong) LSCurrentUser* currentUser;

+ (AppUtility*)getInstance;

/** 检查当前用户是否存在 */
- (BOOL)checkCurrentUser;
/** 保存当前用户 */
- (void)saveCurrentUser;
/** 注销当前用户 */
- (void)clearCurrentUser;
/** 倒计时(GCD实现) */
+ (void)countDown:(NSTimeInterval)second complete:(void(^)())completeBlock progress:(void(^)(id time))progressBlock;
@end
