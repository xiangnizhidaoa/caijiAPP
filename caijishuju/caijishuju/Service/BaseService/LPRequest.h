//
//  SMRequest.h
//  SMGuideForUser
//
//  Created by Company Computer on 14/11/12.
//  Copyright (c) 2014年 Company Computer. All rights reserved.
//上传下载 用的ASI

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIProgressDelegate.h"

typedef void(^ProgressBlock)(float,long long,long long);
typedef void(^CompleteBlock)(id dict,NSError *);
typedef void(^CompleteFileDownBlock)(NSString *,NSError *);

@interface LPRequest : NSObject<ASIHTTPRequestDelegate,ASIProgressDelegate>

+ (LPRequest *)shareInstance;

@property (nonatomic, assign) BOOL hiddenLoading;

//上传
- (void)uploadFile:(NSData *)data
               url:(NSString *)url
          complete:(CompleteBlock) completeBlock
          progress:(ProgressBlock) progressBlock;

//下载
- (void)downloadFileWithUrl:(NSString *)url
                   complete:(CompleteFileDownBlock) completeFileDownBlock
                   progress:(ProgressBlock) progressBlock;


@end
