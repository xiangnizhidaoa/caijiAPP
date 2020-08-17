//
//  NSString+AES.m
//  PeopleYunXin
//
//  Created by 牛方路 on 2019/11/13.
//  Copyright © 2019 牛方路. All rights reserved.
//

#import "NSString+AES.h"

//#import <AppKit/AppKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

// key跟后台协商一个即可，保持一致
static NSString *const PSW_AES_KEY = @"fkpeopleyuncnaes";
// 这里的偏移量也需要跟后台一致，一般跟key一样就行
static NSString *const AES_IV_PARAMETER = @"fkpeopleyuncnaes";

@implementation NSString (AES)

- (NSString*)aci_encryptWithAES {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *AESData = [self AES128operation:kCCEncrypt
                                       data:data
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    NSString *baseStr_GTM = [self hexStringFromData:AESData];
    return baseStr_GTM;
}

//- (NSString*)aci_decryptWithAES {
//
//    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *baseData_GTM = [self decodeBase64Data:data];
//    NSData *baseData = [[NSData alloc]initWithBase64EncodedString:self options:0];
//
//    NSData *AESData_GTM = [self AES128operation:kCCDecrypt
//                                           data:baseData_GTM
//                                            key:PSW_AES_KEY
//                                             iv:AES_IV_PARAMETER];
//    NSData *AESData = [self AES128operation:kCCDecrypt
//                                       data:baseData
//                                        key:PSW_AES_KEY
//                                         iv:AES_IV_PARAMETER];
//
//    NSString *decStr_GTM = [[NSString alloc] initWithData:AESData_GTM encoding:NSUTF8StringEncoding];
//    NSLog(@"decStr_GTM : %@",decStr_GTM);
//    NSString *decStr = [[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding];
//
//    return decStr;
//}

/**
 *  AES加解密算法
 *
 *  @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 *  @param data      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 *
 *
 */
- (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    
    char keyPtr[kCCKeySizeAES128 + 1];  //kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置加密参数
    /**
        这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说

    */
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {
        NSLog(@"Success");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    } else {
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}

//// 这里附上GTMBase64编码的代码，可以手动写一个分类，也可以直接cocopods下载，pod 'GTMBase64'。
///**< GTMBase64编码 */
//- (NSString*)encodeBase64Data:(NSData *)data {
//    data = [GTMBase64 encodeData:data];
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    return base64String;
//}
//
///**< GTMBase64解码 */
//- (NSData*)decodeBase64Data:(NSData *)data {
//    data = [GTMBase64 decodeData:data];
//    return data;
//}

// 普通字符串转换为十六进
- (NSString *)hexStringFromData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];
        
        if([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }
        
        hexStr = [hexStr stringByAppendingString:newHexStr];
        
    }
    return hexStr;
}

//十六进制转Data
- (NSData*)dataForHexString:(NSString*)hexString
{
    if (hexString == nil) {
        
        return nil;
    }
    
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            
            byte = *ch - '0';
        }else if ('a' <= *ch && *ch <= 'f') {
            
            byte = *ch - 'a' + 10;
        }else if ('A' <= *ch && *ch <= 'F') {
            
            byte = *ch - 'A' + 10;
            
        }
        
        ch++;
        
        byte = byte << 4;
        
        if (*ch) {
            
            if ('0' <= *ch && *ch <= '9') {
                
                byte += *ch - '0';
                
            } else if ('a' <= *ch && *ch <= 'f') {
                
                byte += *ch - 'a' + 10;
                
            }else if('A' <= *ch && *ch <= 'F'){
                
                byte += *ch - 'A' + 10;
                
            }
            
            ch++;
            
        }
        
        [data appendBytes:&byte length:1];
        
    }
    
    return data;
}

@end
