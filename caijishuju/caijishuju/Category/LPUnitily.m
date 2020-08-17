//
//  LPUnitily.m
//  IntegralManage
//
//  Created by tbow-app-02 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LPUnitily.h"
#import <CommonCrypto/CommonDigest.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIImage+Extensions.h"
#import <mach/mach_time.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation LPUnitily

+(BOOL)haveNetwork{
    Reachability *internet = [Reachability reachabilityForInternetConnection];
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    if ((wifi.currentReachabilityStatus != 0) || (internet.currentReachabilityStatus != 0)) {
        return YES;
        
    }
    return NO;
}

+ (NSString *)decodeString:(NSString *)string{
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)encodeString:(NSString *)string
{
    //(CFStringRef)@";/?:@&=$+<>{},"
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                    (__bridge CFStringRef)string,
                                                                                    NULL,
                                                                                    (CFStringRef)@";/?:@&=$+<>,",
                                                                                    kCFStringEncodingUTF8);
    //NSString *result=[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

+ (NSString *)stringWithMD5:(NSString *)source{
    const char *cStr = [source UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}

+ (NSString *)lowercaseStringWithMD5:(NSString *)source{
    const char *cStr = [source UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+(NSData *)md5Data:(NSData *)data{
    
    const void *ptrData = [data bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptrData, (CC_LONG)[data length], result);
    return [NSData dataWithBytes:result length:16];
}

+ (NSDateFormatter *)_HTTPDateFormatter
{
    // Returns a formatter for dates in HTTP format (i.e. RFC 822, updated by RFC 1123).
    // e.g. "Sun, 06 Nov 1994 08:49:37 GMT"
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateFormatter;
}

//convert string to date
+ (NSDate *)stringToDate:(NSString *)httpDate
{
    NSDateFormatter *dateFormatter = [LPUnitily _HTTPDateFormatter];
    return [dateFormatter dateFromString:httpDate];
}

//convert date to string
+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [LPUnitily _HTTPDateFormatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateToString:(NSDate *)date type:(NSString *)timeType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:timeType];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)stringToDate:(NSString *)dateString type:(NSString *)timeType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:timeType];
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)getNLWithBirthdayDate:(NSDate *)birthday{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    
    int nowYear = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    int birthYear = [[dateFormatter stringFromDate:birthday] intValue];
    
    return [NSString stringWithFormat:@"%d",(nowYear-birthYear)];
}

+ (NSString *)getNLWithBirthdayString:(NSString *)birthdayString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthday= [dateFormatter dateFromString:birthdayString];
    [dateFormatter setDateFormat:@"yyyy"];
    int nowYear = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    int birthYear = [[dateFormatter stringFromDate:birthday] intValue];
    
    return [NSString stringWithFormat:@"%d",(nowYear-birthYear)];
}

//获取当前系统的时间戳
+(long)getTimeSp{
    long time;
    NSDate *fromdate=[NSDate date];
    time=(long)[fromdate timeIntervalSince1970];
    return time;
}

//将时间戳转换成NSDate
+(NSDate *)changeSpToTime:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    return confromTimesp;
}

//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
+(long)changeTimeToTimeSp:(NSString *)timeStr{
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    return time;
}

+ (NSString *)circumferencedayofDate:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSYearCalendarUnit |
                                                    NSDayCalendarUnit | NSWeekdayCalendarUnit )
                                          fromDate:date];
    switch ([comp weekday]) {
        case 7:
            return @"周六";
            break;
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        default:
            return @"";
            break;
    }
}

+ (NSString *)weekdayofDate:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSYearCalendarUnit |
                                                    NSDayCalendarUnit | NSWeekdayCalendarUnit )
                                          fromDate:date];
    switch ([comp weekday]) {
        case 7:
            return @"星期六";
            break;
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        default:
            return @"";
            break;
    }
}
+ (NSString *)dateWithWeekDay:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSYearCalendarUnit |
                                                    NSDayCalendarUnit | NSWeekdayCalendarUnit )
                                          fromDate:date];
    NSString *weekDay=@"";
    switch ([comp weekday]) {
        case 7:
            weekDay=@"星期六";
            break;
        case 1:
            weekDay=@"星期日";
            break;
        case 2:
            weekDay=@"星期一";
            break;
        case 3:
            weekDay=@"星期二";
            break;
        case 4:
            weekDay=@"星期三";
            break;
        case 5:
            weekDay=@"星期四";
            break;
        case 6:
            weekDay=@"星期五";
            break;
        default:
            weekDay=@"";
            break;
    }
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld %@",(long)[comp year],(long)[comp month],(long)[comp day],weekDay];
}

+ (float)iosVersion{
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+ (void)setBorderByView:(UIView *)view{
    CALayer *layer = [view layer];
    [layer setMasksToBounds:YES];
    [layer setBorderWidth:1.f];
    [layer setBorderColor:[[UIColor grayColor] CGColor]];
}

+ (void)setRoundBorderByView:(UIView *)view{
    CALayer *layer = [view layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.f];
    [layer setBorderWidth:1.f];
    [layer setBorderColor:RGBCOLOR(230, 230, 230).CGColor];
}

//+ (NSString *)md5Digest:(NSString *)str{
//	const char *cStr = [str UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(cStr, strlen(cStr), result);
//    return [NSString stringWithFormat:
//            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
//            ];
//}

// 正则判断手机号码地址格式
//+ (BOOL)isMobileNumber:(NSString *)mobileNum
//{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//
//    /**
//     电话号码 手机号码同时验证
//     */
//    //    NSString *PhoneAndPHS = @"(^(\\d{3,4}-)?\\d{7,8})$|(13[0-9]{9})";
//
//    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    //    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    //    NSPredicate *regextestPhoneAndPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PhoneAndPHS];
//
//    return ([mobileNum isMatchedByRegex:MOBILE]||[mobileNum isMatchedByRegex:CM]||[mobileNum isMatchedByRegex:CU]||[mobileNum isMatchedByRegex:CT]||[mobileNum isMatchedByRegex:PHS]);
//}

//+ (BOOL)isMobileNumber:(NSString *)mobile{//首字母是1的 11位数字
//    NSString *regex = @"^1\\d{10}$";
//
////    return [mobile isMatchedByRegex:regex];
//}

//+ (BOOL)isEmailNumber:(NSString *)emailNumber
//{
//    NSString * Email = @"^[0-9a-zA-Z_.]+@(([0-9a-zA-Z]+)[.])+[a-z]{2,4}$";
////    return [emailNumber isMatchedByRegex:Email];
//}
//
//+ (BOOL)isAreaNumber:(NSString *)arealNumber{
//    NSString * Area = @"0(10|2[0-5789]|\\d{3})";
////    return [arealNumber isMatchedByRegex:Area];
//}
//
//+ (BOOL)isNumber:(NSString *)number{
//    NSString * Number = @"^[0-9]*$";
////    return [number isMatchedByRegex:Number];
//}

//+ (BOOL)isPhoneNumber:(NSString *)number{
//    NSString * Number = @"((86(\\-|\\s)?)?(0(10|2[0-5789]|\\d{3})(\\-|\\s)?)?(\\d{7,8})$)|((86(\\-|\\s)?)?\\d{7,23})|(100(00|10|86))|(123(10|15|33|58|65|66|69|95|06))|(955(00|11|18|19|22|33|55|59|66|77|88|95|99|01|16|58|61|67|68|98|80))";
////    return [number isMatchedByRegex:Number];
//}

//验证首字母不能为数字 用户名不能以数字开头
+ (BOOL)validateNumber:(NSString*)number{
    BOOL res = NO;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(0, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length != 0) {
            res = YES;
            break;
        }
        i++;
    }
    return res;
}

//密码不能使用数字、字母以外的字符
+ (BOOL)validatePassWord:(NSString *)passWord{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [passWord rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        return NO;
    }
    return YES;
}

//判断输入是否合法（个性签名，组织姓名，组织名称）
+ (BOOL)isInputLegal:(NSString *)string{
    NSString *stringRegex01 = @"[\u4E00-\u9FA5a-zA-Z0-9\\@\\#\\$\\^\\&\\*\\(\\)\\-\\+\\.\\ \\_]*";
    NSString *stringRegex02 = @"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*";
    NSPredicate *predicte01 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex01];
    NSPredicate *predicte02 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex02];
    return ([predicte01 evaluateWithObject:string]||[predicte02 evaluateWithObject:string])&&![self isHasEmoji:string];
}

//是否包含表情字符
+ (BOOL)isHasEmoji:(NSString *)string
{
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    const char *utf8 = [string UTF8String];
    
    BOOL isHasEmoji =NO;
    
    for (int i =0; i < len; i++) {
        unsigned int c = utf8[i];
        if (c==4294967280) {
            isHasEmoji = YES;
            break;
        }
    }
    
    return isHasEmoji;
}


//+ (BOOL)isZipCode:(NSString *)zipCode{
//    NSString * code = @"\\d{6}";
////    return [zipCode isMatchedByRegex:code];
//}

+ (int)covertDoubleToInt:(double)value {
    
    // 四舍五入
    int tempValue = (int)(value * 1000);
    int quotient = tempValue / 1000;
    int remainder = tempValue % 1000;
    if (remainder > 500) {
        return quotient + 1;
    } else {
        return quotient;
    }
}

//获取文本填充的高度 maxHeight=MAXFLOAT 的时候说明没有行数限制
+ (CGSize)getSizeWithContent:(NSString *)content font:(UIFont *)font width:(CGFloat)aWidth maxHeight:(CGFloat)maxHeight
{
    CGSize size = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    size =[content boundingRectWithSize:CGSizeMake(aWidth, maxHeight) // 用于计算文本绘制时占据的矩形块
                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  // 文本绘制时的附加选项
                             attributes:attribute        // 文字的属性
                                context:nil].size;
    
    if (size.width > aWidth) {
        size.width = aWidth;
    }
    
    return size;
}

//给图片加圆角
+ (void)addCornerToView:(UIView *)view withRadius:(CGFloat)radius{
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=radius;
}

//正方形图片变成圆形
+ (void)addCircularToView:(UIView *)view{
    view.clipsToBounds = YES;
    [view.layer setCornerRadius:view.frame.size.height/2];
    //    [view.layer setBorderWidth:.5f];
    //    [view.layer setBorderColor:[[UIColor grayColor] CGColor]];
}

+ (void)tableViewScrollToTop:(UITableView *)tableView{
    [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

// 无代理alert
+ (void)alertNoNetWork {
    [LPUnitily alertWithTitle:@"当前网络不可用，请检查你的网络设置" message:nil];
}

+ (void)alertHttpTimeOut {
    [LPUnitily alertWithTitle:@"请求超时" message:nil];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    dispatch_block_t block = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    };
    
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)alertMessage:(NSString *)message {
    dispatch_block_t block = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    };
    
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

+ (void)addHUDToCurrentViewWithString:(NSString *)string {
    if ([LPUnitily activityViewController]&&[[LPUnitily activityViewController] view]) {
        UIView *view = [[LPUnitily activityViewController] view];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.labelText = string;
        [hud show:YES];
        
    }
}

+ (void)removeHUDToCurrentView{
    if ([LPUnitily activityViewController]&&[[LPUnitily activityViewController] view]) {
        UIView *view = [[LPUnitily activityViewController] view];
        for (MBProgressHUD *hud in [MBProgressHUD allHUDsForView:view]) {
            if (hud) {
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES];
            }
        }
    }
}

+ (void)addHUDToSystemWindowWithString:(NSString *)string {
    if ([UIApplication sharedApplication].keyWindow) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.labelText = string;
        [hud show:YES];
    }
}

+ (void)removeHUDToSystemWindow{
    if ([UIApplication sharedApplication].keyWindow) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        for (MBProgressHUD *hud in [MBProgressHUD allHUDsForView:window]) {
            if (hud) {
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES];
            }
        }
    }
}

+ (void)showToastInView:(UIView *)superView withText:(NSString *)text{
    if (superView) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
        [superView addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelFont = GetFont(15.0f);
        hud.labelText = text;
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1.0);
        } completionBlock:^{
            [hud removeFromSuperview];
        }];
    }
}

+ (void)showToastWithText:(NSString *)text{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = GetFont(15.0f);
    hud.detailsLabelText = text;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.minShowTime = 1.0;
    hud.bezelView.backgroundColor = RGBCOLORVA(0x000000, 0.5);
    hud.offset = CGPointMake(0.f, SCREENH_HEIGHT / 2 - 130);
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1.0);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

+ (UIWindow *)keyWindow{
    return [UIApplication sharedApplication].keyWindow;
}

+ (NSData *)resizeImage:(UIImage *)image{
    CGFloat resize = 480.0f;
    //    CGFloat resize = 720.0f;
    
    UIImage *newImage = nil;
    
    int low = 0.0f;
    if (image.size.width == image.size.height) {
        low = image.size.width;
        if (low < resize) {//不resize
            newImage = image;
        }else{//resize
            newImage = [image imageByScalingToSize:CGSizeMake(resize, resize)];
        }
    }else if (image.size.width < image.size.height){
        low = image.size.width;
        if (low < resize) {//不resize
            newImage = image;
        }else{//resize
            newImage = [image imageByScalingToSize:CGSizeMake(resize, image.size.height/image.size.width*resize)];
        }
    }else if (image.size.height < image.size.width){
        low = image.size.height;
        if (low < resize) {//不resize
            newImage = image;
        }else{//resize
            newImage = [image imageByScalingToSize:CGSizeMake(image.size.width/image.size.height*resize, resize)];
        }
    }
    
    return UIImageJPEGRepresentation(newImage, 0.7f);
}

+ (NSTimeInterval)getCurTick
{
    static double scale = 0.0;
    if (0.0 == scale) {
        mach_timebase_info_data_t info;
        mach_timebase_info(&info);
        scale = info.numer / info.denom * 1e-9;
    }
    
    return mach_absolute_time() * scale;
}

+ (CGFloat)getWidthFromString:(NSString *)string font:(CGFloat)font
{
    CGRect tagRect = [string boundingRectWithSize:CGSizeMake(10000, 20) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil];
    return tagRect.size.width;
}

+ (CGFloat)getHeightFromString:(NSString *)string font:(CGFloat)font width:(CGFloat)width
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil];
    return rect.size.height;
}

//排列算法
+ (NSInteger)getPailieCountWithNum:(NSInteger)Num subNum:(NSInteger)subNum
{
    NSInteger count = 0;
    if (Num >= subNum) {
        count = [LPUnitily cheng:Num]/[LPUnitily cheng:Num-subNum];
    }else {
        count = [LPUnitily cheng:Num-subNum]/[LPUnitily cheng:Num];
    }
    return count;
}

//排列组合算法
+ (NSInteger)getCountWithNum:(NSInteger)Num subNum:(NSInteger)subNum
{
    NSInteger count = 0;
    if (Num >= subNum) {
        count = [LPUnitily cheng:Num]/([LPUnitily cheng:Num-subNum]*[LPUnitily cheng:subNum]);
    }else {
        count = [LPUnitily cheng:subNum]/([LPUnitily cheng:subNum-Num]*[LPUnitily cheng:Num]);
    }
    return count;
}

//**求一个数的阶乘
+ (NSInteger)cheng:(NSInteger )num{
    if (num == 0) {
        return 1;
    }
    NSInteger sum = 1;
    while (num != 1){
        sum = sum * num;
        num--;
    }
    return sum;
}

//设置label行间距
+ (void)setLineplaceWithLabel:(UILabel *)label lineSpacing:(NSInteger)lineSpacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
    label.attributedText = attributedString;
    [label sizeToFit];
}


/** 获取wifi ip地址*/
+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);  
    
    NSLog(@"手机的IP是：%@", address);
    return address;

}
//获取设备的物理ip地址
+ (NSString *)getIpAddresses{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) return nil;
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *ipAddress = [ips objectAtIndex:ips.count - 1];
    return ipAddress;
}

//将View生成图片
+(UIImage*)createImageFromView:(UIView*)view
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

+ (void)setSubStrColorWithBecomeStr:(NSString *)becomeStr endStr:(NSString *)endStr label:(UILabel *)label
{
    NSString *labelText = label.text;
    NSRange range0 = [labelText rangeOfString:becomeStr];
    NSRange range1 = [labelText rangeOfString:endStr];
    NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:labelText];
    //    [textAttributed addAttribute:NSFontAttributeName value:GetFont(14.0f) range:NSMakeRange(0, betMoneyText.length)];
    //    [textAttributed addAttribute:NSForegroundColorAttributeName value:ColorSubTitle range:NSMakeRange(0, betMoneyText.length)];
    [textAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(range0.location+1, range1.location-range0.location-1)];
    label.attributedText = textAttributed;
}

+ (void)setSubStrColorWithBecomeStr:(NSString *)becomeStr endStr:(NSString *)endStr label:(UILabel *)label color:(UIColor *)color
{
    NSString *labelText = label.text;
    if (label.text.length != 0 && [label.text rangeOfString:becomeStr].location != NSNotFound) {
        NSRange range0 = [labelText rangeOfString:becomeStr];
        NSRange range1 = [labelText rangeOfString:endStr];
        NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:labelText];
//        [textAttributed addAttribute:NSFontAttributeName value:label.font range:NSMakeRange(0, labelText.length)];
        //    [textAttributed addAttribute:NSForegroundColorAttributeName value:ColorSubTitle range:NSMakeRange(0, betMoneyText.length)];
        [textAttributed addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range0.location+1, range1.location-range0.location-1)];
        label.attributedText = textAttributed;
    }
    
}


+ (void)addAnimationWithButton:(UIButton *)button
{
    button.hidden = YES;
    dispatch_queue_t queue= dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), queue, ^{
        //        NSLog(@"主队列--延迟执行------%@",[NSThread currentThread]);
        button.hidden = NO;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(0.0),@(1.0),@(1.4),@(1.0)];
        animation.duration = .4f;
        animation.calculationMode = kCAAnimationLinear;
        [button.layer addAnimation:animation forKey:nil];
    });
}

@end


