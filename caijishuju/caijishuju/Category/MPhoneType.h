//
//  MPhoneType.h
//  NewDuDriver
//
//  Created by M on 2020/4/9.
//  Copyright © 2020 Hoau. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPhoneType : NSObject

/**
 设备型号标识(需转化)
 */
+ (NSString *)PhoneTypeIDString;

/**
 设备型号
 */
+ (NSString *)PhoneNameOfModel;

@end

NS_ASSUME_NONNULL_END
