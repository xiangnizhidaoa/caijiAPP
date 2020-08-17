//
//  LPSystemManager.h
//  ArchInstance
//
//  Created by 刘 鹏 on 15/9/7.
//  Copyright (c) 2015年 LP. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @class
 @abstract System Manager。
 */
@interface LPSystemManager : NSObject

/*!
 @property
 @abstract 离线文件地址。
 */
@property (nonatomic, strong) NSString *offlineFilePath;

/*!
 @property
 @abstract 用户信息存储地址。
 */
@property (nonatomic, strong) NSString *userInfoFilePath;

/*!
 @method
 @abstract LPSystemManager单例方法
 @result LPSystemManager 实例
 */
+ (id)sharedInstance;

@end
