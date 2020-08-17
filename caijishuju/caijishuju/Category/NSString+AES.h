//
//  NSString+AES.h
//  PeopleYunXin
//
//  Created by 牛方路 on 2019/11/13.
//  Copyright © 2019 牛方路. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)

/**< 加密方法 */
- (NSString*)aci_encryptWithAES;

/**< 解密方法 */
- (NSString*)aci_decryptWithAES;

@end

NS_ASSUME_NONNULL_END
