//
//  MK_UseAFNetWorking.m
//  MoKey_SDK_Demo
//
//  Created by wangxinxu on 2017/10/26.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import "MK_UseAFNetWorking.h"

@implementation MK_UseAFNetWorking

+ (MK_UseAFNetWorking *)NewNewWork
{
    return [[MK_UseAFNetWorking alloc]init];
}

- (id)init
{
    if (self == [super init]) {
        
    }
    return self;
}

// POST
- (void)postNetWorkPostWithPostDic:(NSDictionary *)postDic Url:(NSString *)url headerDic:(NSDictionary *)headDic withCompletion:(void(^)(id completion))completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"1111111``````%@",url);
    NSLog(@"222222`````%@",postDic);
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
   
    if (headDic != nil){
        [manager.requestSerializer setValue:[[headDic allValues] firstObject] forHTTPHeaderField:[[headDic allKeys] firstObject]];
    }
    
    
    [manager POST:url parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        if ([jsonDic[@"status"] integerValue] == 40003) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginView" object:self];
//        }else{
            completion(responseObject);
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         completion(nil);
    }];
}

// GET
- (void)getNetWorkGetWithGetDic:(NSDictionary *)postDic Url:(NSString *)url headerDic:(NSDictionary *)headDic withCompletion:(void(^)(id completion))completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSLog(@"333333``````%@",[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    if (headDic != nil){
        [manager.requestSerializer setValue:[[headDic allValues] firstObject] forHTTPHeaderField:[[headDic allKeys] firstObject]];
    }
    [manager GET:url parameters:postDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *) task.response;
//        if ([jsonDic[@"status"] integerValue] == 40003) {
//          [[NSNotificationCenter defaultCenter] postNotificationName:@"loginView" object:self];
//        }else{
            completion(responseObject);
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"返回数据错误");
        completion(nil);
    }];
}

- (void)postUpLoadDataByString:(NSString *)urlString BODYDic:(NSDictionary *)bodyDic imageDic:(NSDictionary *)imageDic headerDic:(NSDictionary *)headerDic WithDataBlock:(void (^)(id dict))dataBlock
{
    NSLog(@"$$$$$$$$$%@",urlString);
    //1.字符串转码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:urlString]];
    //2.创建管理者对象
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (headerDic != nil){
        [manager.requestSerializer setValue:[[headerDic allValues] firstObject] forHTTPHeaderField:[[headerDic allKeys] firstObject]];
    }
    [manager POST:urlString parameters:bodyDic constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        for (NSString *key in imageDic) {
            [formData appendPartWithFileData:imageDic[key]
                                        name:@"filePath"
                                    fileName:@"11111.png"
                                    mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
//            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//            if ([jsonDic[@"status"] integerValue] == 40003) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginView" object:self];
//            }else{
                dataBlock(responseObject);
//            }
        }else{
            dataBlock(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dataBlock(nil);
    }];
}

- (void)downloadFileWithURL:(NSString*)requestURLString
                 parameters:(NSDictionary *)parameters
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress
{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURLString parameters:parameters error:nil];
    NSURLSessionDownloadTask *task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savedPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            failure(error);
        }else{
            success(response,filePath);
        }
    }];
    [task resume];
}


#pragma mark    辅助功能 dic - jsonstr相互转换
- (NSString *)DicToJsonStrWithDic:(NSDictionary *)dic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:NULL];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)JsonStrToDicWithJsonStr:(NSString *)JsonStr
{
    if (JsonStr) {
        
        NSData *jsonData = [JsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        return [NSJSONSerialization JSONObjectWithData:jsonData
                
                                               options:NSJSONReadingMutableContainers
                
                                                 error:&err];
    }else{
        return nil;
    }
}
#pragma mark    Baser64Str - NSData 相互转换
- (NSString *)Base64StrFromData:(NSData *)strData
{
    if (strData) {
        NSString *base64Encoded = [strData base64EncodedStringWithOptions:0];
        return base64Encoded;
    }else{
        return nil;
    }
}

- (NSData *)DateFromBase64String:(NSString *)Base64Str
{
    if (Base64Str) {
        NSData *nsdataFromBase64String = [[NSData alloc]
                                          initWithBase64EncodedString:Base64Str options:0];
        return nsdataFromBase64String;
    }else{
        return nil;
    }
}

- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *temp in windows) {
            if (temp.windowLevel == UIWindowLevelNormal) {
                window = temp;
                break;
            }
        }
    }
    //取当前展示的控制器
    result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    //如果为UITabBarController：取选中控制器
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    //如果为UINavigationController：取可视控制器
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

@end
