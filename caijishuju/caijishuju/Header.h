//
//  Header.h
//  renminjinfu
//
//  Created by 牛方路 on 2018/6/21.
//  Copyright © 2018年 牛方路. All rights reserved.
//

#ifndef Header_h
#define Header_h


//AppDelegate
#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
//1.获取屏幕宽度与高度
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

// 颜色
#define skyRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define skyRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// 十六进制颜色
#define RGBCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define HEIGHT_TAB_BAR         49
#define HEIGHT_BOTTOM_MARGIN   (SCREENH_HEIGHT==812?34:0) 

#define GetImage(imageName) [UIImage imageNamed:imageName]
#define GetFont(x) [UIFont systemFontOfSize:x]
#define GetBoldFont(x) [UIFont boldSystemFontOfSize:x]

//16.沙盒目录文件
// NSUserDefaults 实例化
#define skyUserDefaults [NSUserDefaults standardUserDefaults]

//获取temp
#define skyPathTemp NSTemporaryDirectory()

// 沙盒Document路径
#define AppDocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//获取沙盒 Cache
#define skyPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//手机版本
#define IsIphone5 (SCREEN_HEIGHT == 568) ? YES:NO
#define IsIphone6 (SCREEN_HEIGHT == 667) ? YES:NO
#define IsIphone6Plus (SCREEN_HEIGHT == 736) ? YES:NO
#define KISIphoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size))

#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom > 0.0;\
}\
(isPhoneX);})

#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight  ([UIScreen mainScreen].bounds.size.height)

#define kBottomSafeSpace (IPHONE_X ? 34.0 : 0.0)


#define SystemVersion [[UIDevice currentDevice] systemVersion].floatValue

#endif /* Header_h */
