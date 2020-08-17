//
//  DDBaseService.m
//  DingDingCore
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "BaseService.h"
#import "Reachability.h"

@implementation BaseService

- (BOOL)networkReachable
{
    Reachability* reach = [Reachability reachabilityForInternetConnection];
    
    if([reach currentReachabilityStatus] == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
