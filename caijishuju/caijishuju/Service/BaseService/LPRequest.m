//
//  LPJastorReq.m
//  SMGuideForUser
//
//  Created by Company Computer on 14/11/12.
//  Copyright (c) 2014年 Company Computer. All rights reserved.
//

#import "LPRequest.h"
#import "ASIFormDataRequest.h"
#import "LPSystemManager.h"
#import "NSDictionary+NullReplacement.h"

#define CompleteBlockKEY @"completeBlock"
#define ProgressBlockKEY @"progressBlock"
#define RequestTypeKey @"requestType"

@implementation LPRequest

static LPRequest *request = nil;

+ (LPRequest *)shareInstance{
    if (!request) {
        request = [[LPRequest alloc] init];
    }
    
    return request;
}

- (void)uploadFile:(NSData *)data
               url:(NSString *)url
          complete:(CompleteBlock) completeBlock
          progress:(ProgressBlock) progressBlock{
    [LPUnitily addHUDToSystemWindowWithString:@"加载中..."];
    ASIFormDataRequest *uploadRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [uploadRequest setData:data withFileName:@"upload" andContentType:@"application/octet-stream" forKey:@"file"];
    
//    if ([CommonUtils stringIsUsefull:App_Utility.currentUser.Token]) {
//        [uploadRequest addRequestHeader:@"Authorization: Token" value:App_Utility.currentUser.Token];
//
//    }else {
        [uploadRequest addRequestHeader:@"Authorization: Token" value:@""];
//    }

    [uploadRequest setRequestMethod:@"POST"];
    [uploadRequest setUploadProgressDelegate:self];
    [uploadRequest setDelegate:self];
    [uploadRequest setTimeOutSeconds:60.0];

    uploadRequest.shouldAttemptPersistentConnection = NO;
    uploadRequest.showAccurateProgress = YES;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:completeBlock forKey:CompleteBlockKEY];
    [dict setObject:@"FileUpload" forKey:RequestTypeKey];
    NSLog(@"upload file file size is %ld",[data length]);
    [dict setObject:[NSNumber numberWithLongLong:[data length]] forKey:@"filesize"];
    if (progressBlock) {
        [dict setObject:progressBlock forKey:ProgressBlockKEY];
    }
    uploadRequest.userInfo = dict;
    [uploadRequest startAsynchronous];
}

- (void)downloadFileWithUrl:(NSString *)url
                   complete:(CompleteFileDownBlock) completeFileDownBlock
                   progress:(ProgressBlock) progressBlock{
    NSString *filePath = [[[LPSystemManager sharedInstance] offlineFilePath] stringByAppendingPathComponent:[LPUnitily stringWithMD5:url]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        completeFileDownBlock(filePath,nil);
    }else{
        [LPUnitily addHUDToSystemWindowWithString:@"加载中..."];
        ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
        [request setDownloadDestinationPath:filePath];
        [request setDownloadProgressDelegate:self];
        [request setShouldAttemptPersistentConnection:NO];
        request.showAccurateProgress = YES;
        [request setDelegate:self];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dict setObject:completeFileDownBlock forKey:CompleteBlockKEY];
        [dict setObject:@"FileDown" forKey:RequestTypeKey];
        if (progressBlock) {
            [dict setObject:progressBlock forKey:ProgressBlockKEY];
        }
        request.userInfo = dict;
        [request startAsynchronous];
    }
}

- (void)request:(ASIHTTPRequest *)request
didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    int statusCode = [request responseStatusCode];
    if (statusCode >= 400) {
        [LPUnitily removeHUDToSystemWindow];
        CompleteBlock completeBlock= (CompleteBlock)[request.userInfo objectForKey:CompleteBlockKEY];
        NSError *err = [NSError errorWithDomain:@"" code:statusCode userInfo:nil];
        [LPUnitily showToastInView:[LPUnitily keyWindow] withText:[NSString stringWithFormat:@"状态错误:%d", statusCode]];
        if (completeBlock) {
            completeBlock(nil,err);
        }
        return;
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [LPUnitily removeHUDToSystemWindow];
    [request setResponseEncoding:NSUTF8StringEncoding];
    
    if ([request.userInfo objectForKey:RequestTypeKey]&&[[request.userInfo objectForKey:RequestTypeKey] isEqualToString:@"FileDown"]) {
        CompleteFileDownBlock completeFileDownBlock = (CompleteFileDownBlock)[request.userInfo objectForKey:CompleteBlockKEY];
        if (request.responseStatusCode == 200) {
            if (completeFileDownBlock) {
                completeFileDownBlock(request.downloadDestinationPath,nil);
            }
        }else {
            NSError *error = [request error];
            if (completeFileDownBlock) {
                completeFileDownBlock(nil,error);
            }
        }
    }else {
        CompleteBlock completeBlock = (CompleteBlock)[request.userInfo objectForKey:CompleteBlockKEY];
        NSDictionary *resDictionary = [[request responseData] objectFromJSONData];
        NSLog(@"返回信息:\n%@",[resDictionary JSONString]);
        NSLog(@"server response: %@",resDictionary);
        if([resDictionary isKindOfClass:[NSDictionary class]])
        {
            completeBlock([resDictionary dictionaryByReplacingNullsWithBlanks],nil);
        }
        else if([resDictionary isKindOfClass:[NSArray class]]){ //依赖外部接口 可能是array
            completeBlock(resDictionary,nil);
        }
        else
        {
            completeBlock(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [LPUnitily removeHUDToSystemWindow];
    NSError *error = [request error];
    if (error.code == 2) {
        [LPUnitily showToastInView:[LPUnitily keyWindow] withText:@"网络请求超时，请稍后~"];
    }else {
        [LPUnitily showToastInView:[LPUnitily keyWindow] withText:error.localizedDescription];
    }
    if ([request.userInfo objectForKey:RequestTypeKey]&&[[request.userInfo objectForKey:RequestTypeKey] isEqualToString:@"FileDown"]) {
        CompleteFileDownBlock completeFileDownBlock = (CompleteFileDownBlock)[request.userInfo objectForKey:CompleteBlockKEY];
        if (completeFileDownBlock) {
            completeFileDownBlock(nil,error);
        }
    }else {
        CompleteBlock completeBlock= (CompleteBlock)[request.userInfo objectForKey:CompleteBlockKEY];
        if (completeBlock) {
            completeBlock(nil,error);
        }
    }
}

- (void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes
{
//    ProgressBlock progressBlock= (ProgressBlock)[request.userInfo objectForKey:ProgressBlockKEY];
//
//    NSNumber *fileSize = [request.userInfo objectForKey:@"filesize"];
//    
//    NSLog(@"did send bytes is %lld upload file file size is %lld",bytes,[fileSize longLongValue]);
//    
//    if (progressBlock) {
//        progressBlock(bytes/[fileSize longLongValue],bytes,[fileSize longLongValue]);
//    }
}

-(void)request:(ASIHTTPRequest *)request incrementUploadSizeBy:(long long)newLength{
    ProgressBlock progressBlock= (ProgressBlock)[request.userInfo objectForKey:ProgressBlockKEY];
    
    NSNumber *fileSize = [request.userInfo objectForKey:@"filesize"];
    long long otherSize = 222;
    long long didUploadSize = newLength - otherSize;
    NSLog(@"did send bytes is %lld upload file file size is %lld",didUploadSize,[fileSize longLongValue]);
    
    if (progressBlock) {
        progressBlock(didUploadSize/[fileSize longLongValue],didUploadSize,[fileSize longLongValue]);
    }
}

- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
    ProgressBlock progressBlock= (ProgressBlock)[request.userInfo objectForKey:ProgressBlockKEY];
    
    NSNumber *fileSize = [request.responseHeaders valueForKey:@"Content-Length"];
    
    if (progressBlock) {
        progressBlock(bytes/[fileSize longLongValue],bytes,[fileSize longLongValue]);
    }
}



@end
