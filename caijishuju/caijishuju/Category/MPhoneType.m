//
//  MPhoneType.m
//  NewDuDriver
//
//  Created by M on 2020/4/9.
//  Copyright © 2020 Hoau. All rights reserved.
//

#import "MPhoneType.h"
#import <sys/utsname.h>

@implementation MPhoneType

/**
 设备型号标识(需转化)
 */
+ (NSString *)PhoneTypeIDString {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *model = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    return model;
}

/**
 设备型号
 */
+ (NSString *)PhoneNameOfModel {
    NSString *phone = [[MPhoneType PhoneModelDic] objectForKey:[MPhoneType PhoneTypeIDString]];
    
    return [phone length] > 0 ? phone : [MPhoneType PhoneTypeIDString];

}

/**
 设备标识对应型号
 */
+ (NSDictionary *)PhoneModelDic {
    NSDictionary *dic = @{
        @"i386":@"iPhoneSimulator",
        @"x86_64":@"iPhoneSimulator",
        @"iPhone1,1":@"iPhone",
        @"iPhone1,2":@"iPhone3G",
        @"iPhone2,1":@"iPhone3GS",
        @"iPhone3,1":@"iPhone4",
        @"iPhone3,2":@"iPhone4",
        @"iPhone3,3":@"iPhone4",
        @"iPhone4,1":@"iPhone4S",
        @"iPhone5,1":@"iPhone5",
        @"iPhone5,2":@"iPhone5",
        @"iPhone5,3":@"iPhone5C",
        @"iPhone5,4":@"iPhone5C",
        @"iPhone6,1":@"iPhone5S",
        @"iPhone6,2":@"iPhone5S",
        @"iPhone7,2":@"iPhone6",
        @"iPhone7,1":@"iPhone6Plus",
        @"iPhone8,1":@"iPhone6S",
        @"iPhone8,2":@"iPhone6SPlus",
        @"iPhone8,4":@"iPhoneSE",
        @"iPhone9,1":@"iPhone7",
        @"iPhone9,3":@"iPhone7",
        @"iPhone9,2":@"iPhone7Plus",
        @"iPhone9,4":@"iPhone7Plus",
        @"iPhone10,1":@"iPhone8",
        @"iPhone10,4":@"iPhone8",
        @"iPhone10,2":@"iPhone8Plus",
        @"iPhone10,5":@"iPhone8Plus",
        @"iPhone10,3":@"iPhoneX",
        @"iPhone10,6":@"iPhoneX",
        @"iPhone11,2":@"iPhoneXS",
        @"iPhone11,4":@"iPhoneXSMax",
        @"iPhone11,6":@"iPhoneXSMax",
        @"iPhone11,8":@"iPhoneXR",
        @"iPhone12,1":@"iPhone11",
        @"iPhone12,3":@"iPhone11Pro",
        @"iPhone12,5":@"iPhone11ProMax",
        @"iPhone12,8":@"iPhoneSE(2nd generation)",
        @"iPad1,1":@"iPad1",
        @"iPad2,1":@"iPad2",
        @"iPad2,2":@"iPad2",
        @"iPad2,3":@"iPad2",
        @"iPad2,4":@"iPad2",
        @"iPad3,1":@"iPad3rd",
        @"iPad3,2":@"iPad3rd",
        @"iPad3,3":@"iPad3rd",
        @"iPad3,4":@"iPad4th",
        @"iPad3,5":@"iPad4th",
        @"iPad3,6":@"iPad4th",
        @"iPad6,11":@"iPad5th",
        @"iPad6,12":@"iPad5th",
        @"iPad7,5":@"iPad6th",
        @"iPad7,6":@"iPad6th",
        @"iPad7,11":@"iPad7th",
        @"iPad7,12":@"iPad7th",
        @"iPad2,5":@"iPadMini",
        @"iPad2,6":@"iPadMini",
        @"iPad2,7":@"iPadMini",
        @"iPad4,4":@"iPadMini2",
        @"iPad4,5":@"iPadMini2",
        @"iPad4,6":@"iPadMini2",
        @"iPad4,7":@"iPadMini3",
        @"iPad4,8":@"iPadMini3",
        @"iPad4,9":@"iPadMini3",
        @"iPad5,1":@"iPadMini4",
        @"iPad5,2":@"iPadMini4",
        @"iPad11,1":@"iPadMini5",
        @"iPad11,2":@"iPadMini5",
        @"iPad4,1":@"iPadAir",
        @"iPad4,2":@"iPadAir",
        @"iPad4,3":@"iPadAir",
        @"iPad5,3":@"iPadAir2",
        @"iPad5,4":@"iPadAir2",
        @"iPad11,3":@"iPadAir3rd",
        @"iPad11,4":@"iPadAir3rd",
        @"iPad6,7":@"iPadPro12.9-inch1st",
        @"iPad6,8":@"iPadPro12.9-inch1st",
        @"iPad6,3":@"iPadPro9.7-inch",
        @"iPad6,4":@"iPadPro9.7-inch",
        @"iPad7,1":@"iPadPro12.9-inch2nd",
        @"iPad7,2":@"iPadPro12.9-inch2nd",
        @"iPad7,3":@"iPadPro10.5-inch",
        @"iPad7,4":@"iPadPro10.5-inch",
        @"iPad8,1":@"iPadPro11-inch",
        @"iPad8,2":@"iPadPro11-inch",
        @"iPad8,3":@"iPadPro11-inch",
        @"iPad8,4":@"iPadPro11-inch",
        @"iPad8,5":@"iPadPro12.9-inch3rd",
        @"iPad8,6":@"iPadPro12.9-inch3rd",
        @"iPad8,7":@"iPadPro12.9-inch3rd",
        @"iPad8,8":@"iPadPro12.9-inch3rd",
        @"iPad8,9":@"iPad Pro (11-inch) (2nd generation)",
        @"iPad8,10":@"iPad Pro (11-inch) (2nd generation)",
        @"iPad8,11":@"iPad Pro (12.9-inch) (4th generation)",
        @"iPad8,12":@"iPad Pro (12.9-inch) (4th generation)",
        @"iPod1,1":@"iPodTouch1st",
        @"iPod2,1":@"iPodTouch2nd",
        @"iPod3,1":@"iPodTouch3rd",
        @"iPod4,1":@"iPodTouch4th",
        @"iPod5,1":@"iPodTouch5th",
        @"iPod7,1":@"iPodTouch6th",
        @"AppleTV2,1":@"AppleTV2nd",
        @"AppleTV3,1":@"AppleTV3rd",
        @"AppleTV3,2":@"AppleTV3rdRevA",
        @"AppleTV5,3":@"AppleTVHD",
        @"AppleTV6,2":@"AppleTV4K"
    };
    return dic;
}


@end
