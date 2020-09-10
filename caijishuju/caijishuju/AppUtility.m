//
//  AppUtility.m
//  LotterySelect
//
//  Created by 鹏 刘 on 15/11/26.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import "AppUtility.h"
#import "AppDelegate.h"


#define BS_CURRENT_USER_KEY     @"ls_current_user_info"

@implementation LSCurrentUser

MJCodingImplementation

@end

@implementation AppUtility

static AppUtility *instance = nil;

+ (AppUtility*)getInstance{
    @synchronized(self)
    {
        if (instance == nil)
        {
            instance = [[AppUtility alloc] init];
        }
    }
    return instance;
}

- (id)init{
    if (self = [super init]){
        // 当前用户缓存(会持久化)
        _currentUser = (LSCurrentUser *)[NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/%@",[[LPSystemManager sharedInstance] userInfoFilePath],BS_CURRENT_USER_KEY]];
        if (nil == self.currentUser){
            _currentUser = [[LSCurrentUser alloc] init];
            _currentUser.userName = @"";
            _currentUser.token = @"";
            _currentUser.isShow = @"0";
        }
    }
    return self;
}

- (BOOL)checkCurrentUser{
    //有用户名和密码或者有token就可以登录
    return NO;
}

- (void)saveCurrentUser
{
    [NSKeyedArchiver archiveRootObject:self.currentUser toFile:[NSString stringWithFormat:@"%@/%@",[[LPSystemManager sharedInstance] userInfoFilePath],BS_CURRENT_USER_KEY]];
    NSLog(@"%@",[[LPSystemManager sharedInstance] userInfoFilePath]);
}

- (void)clearCurrentUser
{
    // 清空当前用户登录的token凭证,新注册或者登录后重新获取,设置成默认的访客账号
    _currentUser.userName = @"";
    _currentUser.token = @"";
    [self saveCurrentUser];
}

// 倒计时(GCD实现)
+ (void)countDown:(NSTimeInterval)second complete:(void(^)())completeBlock progress:(void(^)(id time))progressBlock
{
    __block int timeout = second;//倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0)
        {
            // 倒计时结束,关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示,根据自己需求设置
                completeBlock();
            });
        }
        else
        {
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            if(timeout == second)
            {
                strTime = [NSString stringWithFormat:@"%.2d", timeout];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示,根据自己需求设置
                NSLog(@"____%@", strTime);
                progressBlock(strTime);
                
            });
            
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}



@end
