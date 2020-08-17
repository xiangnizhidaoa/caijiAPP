//
//  BSUrl.m
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/25.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import "BSUrl.h"

@implementation BSUrl

static BSUrl * instance = nil;
+ (BSUrl*)getInstance{
    @synchronized(self) {
        if (instance == nil)
        {
            instance = [[BSUrl alloc] init];
        }
    }
    return instance;
}

- (id)init{
    if (self = [super init]) {
        
        self.loginUrl = [BSUrl hostUrlWithParam:@"/public/login/login"];
        
    }
    return self;
}

+ (NSString *)hostUrlWithParam:(NSString *)param{
    return [NSString stringWithFormat:@"%@%@",HostUrl,param];
}


@end
