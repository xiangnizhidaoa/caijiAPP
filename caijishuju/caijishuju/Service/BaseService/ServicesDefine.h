//
//  ServicesDefine.h
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/20.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#ifndef ServicesDefine_h
#define ServicesDefine_h
#import "BSError.h"

/*
 *  @brief 通用的请求响应
 *  @param result 返回结果
 *  @param dict 返回具体内容 Value Key
 */
typedef void (^BSResponse)(id dict, BSError* error);

/*
 *  @brief 下载静态图片的请求响应
 *  @param result 返回结果
 *  @param image 返回图片
 *  @param url 返回图片地址
 */
typedef void (^BSResponseImage)(id image, NSString* url, BSError* error);

/*
 *  @brief 下载文件的的请求响应
 *  @param result 返回结果
 *  @param path 返回文件路径
 */
typedef void (^BSResponseFile)(NSString* path, BSError* error);

/*
 *  @brief 上传下载进度响应
 *  @param progress 请求进度
 */
typedef void (^BSProgress)(double progress, double didSize, double fileSize);

#endif /* ServicesDefine_h */
