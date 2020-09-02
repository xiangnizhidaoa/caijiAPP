//
//  MViewToast.h
//  HuaMaster
//
//  Created by M on 2018/6/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MViewToast : NSObject

/**
 停留2秒，显示提示框

 @param text 显示文字
 */
+ (void)MShowWithText:(NSString *)text;

@end
