//
//  NSMutableArray+WSMutableArray.m
//  ESTicket
//
//  Created by 王帅 on 16/3/10.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "NSMutableArray+WSMutableArray.h"
#import "objc/runtime.h"

@implementation NSMutableArray (WSMutableArray)

//+ (void)load {
//    [super load];
//    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
//    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(ws_objectAtIndex:));
//    method_exchangeImplementations(fromMethod, toMethod);
//}
//
//- (id)ws_objectAtIndex:(NSUInteger)index {
//    if (self.count-1 < index) {
//        // 这里做一下异常处理，不然都不知道出错了。
//        @try {
//            return [self ws_objectAtIndex:index];
//        }
//        @catch (NSException *exception) {
//            [LPUnitily showToastWithText:@"数据出现异常"];
//            // 在崩溃后会打印崩溃信息，方便我们调试。
//            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
//            NSLog(@"%@", [exception callStackSymbols]);
//            return nil;
//        }
//        @finally {}
//    } else {
//        return [self ws_objectAtIndex:index];
//    }
//}


@end
