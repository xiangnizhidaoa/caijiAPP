//
//  MK_UseAFNetWorking.h
//  MoKey_SDK_Demo
//
//  Created by wangxinxu on 2017/10/26.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MK_UseAFNetWorking : NSObject

+ (MK_UseAFNetWorking *)NewNewWork;

- (void)postNetWorkPostWithPostDic:(NSDictionary *)postDic Url:(NSString *)url headerDic:(NSDictionary *)headDic withCompletion:(void(^)(id completion))completion;

- (void)getNetWorkGetWithGetDic:(NSDictionary *)postDic Url:(NSString *)url headerDic:(NSDictionary *)headDic withCompletion:(void(^)(id completion))completion;

- (void)postUpLoadDataByString:(NSString *)urlString BODYDic:(NSDictionary *)bodyDic imageDic:(NSDictionary *)imageDic headerDic:(NSDictionary *)headerDic WithDataBlock:(void (^)(id dict))dataBlock;

- (void)downloadFileWithURL:(NSString*)requestURLString
                 parameters:(NSDictionary *)parameters
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress;

@end
