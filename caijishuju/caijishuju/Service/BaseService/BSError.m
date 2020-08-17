//
//  BSError.m
//  DingDingCore
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "BSError.h"

@implementation BSError

+ (BSError*)errorWithNSError:(NSError *)error
{
    
	BSError *aError = [BSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo];
	return aError;
}

+ (BSError*)errorWithCode:(NSInteger)code errorMessage:(NSString*)errorMsg
{
	NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
	[userInfo setObject:[NSString stringWithFormat:@"%ld", (long)code] forKey:@"errorCode"];
    if (errorMsg)
    {
        [userInfo setObject:errorMsg forKey:@"errorMsg"];
    }
	BSError *aError = [BSError errorWithDomain:@"LotterySelect" code:code userInfo:userInfo];
	return aError;
}

- (NSInteger)errorCode
{
    return self.code;
}

- (NSString*)errorMsg
{
    NSString* errorMsg = nil;
    errorMsg = [self.userInfo objectForKey:@"errorMsg"];
    
    if (nil == errorMsg)
    {
        if (NSOrderedSame == [self.domain compare:@"NSURLErrorDomain"])
        {
            switch (self.code)
            {
                case NSURLErrorNotConnectedToInternet:
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                case NSURLErrorTimedOut:
                    errorMsg = @"连接超时";
                    break;
                case kCFURLErrorCancelled:
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                case kCFURLErrorCannotFindHost:
                    errorMsg = @"未能找到使用指定主机名的服务器";
                    break;
                default:
                    // 更改默认服务器出错提示
                    errorMsg = @"服务器君出海去找One Piece啦~~";
                    break;
            }
        }
        else
        {
            errorMsg = @"未知错误";
        }
    }
    
	return errorMsg;
}

@end
