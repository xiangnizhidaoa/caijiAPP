//
//  LPSystemManager.m
//  ArchInstance
//
//  Created by 刘 鹏 on 15/9/7.
//  Copyright (c) 2015年 LP. All rights reserved.
//

#import "LPSystemManager.h"

@implementation LPSystemManager

+ (id)sharedInstance{
    static LPSystemManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//离线文件路径
- (NSString *)offlineFilePath
{
    if (!_offlineFilePath) {
        _offlineFilePath = [AppDocumentPath stringByAppendingPathComponent:@"ESTicket"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:_offlineFilePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_offlineFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:_offlineFilePath isDirectory:YES]];
    }
    
    return _offlineFilePath;
}

//用户信息存储地址
- (NSString *)userInfoFilePath{
    if (!_userInfoFilePath) {
        _userInfoFilePath = [AppDocumentPath stringByAppendingPathComponent:@"UserInfo"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:_userInfoFilePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_userInfoFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    return _userInfoFilePath;
}

//documents目录下文件最大3m同步到云服务  此方法可以对相应文件做标记不同步到云服务
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

@end
