//
//  UINavigationBar+NavAlpha.m
//  MFTour
//
//  Created by tilt on 16/7/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UINavigationBar+NavAlpha.h"
#import <objc/runtime.h>
@implementation UINavigationBar (NavAlpha)
static char *alview;
- (void)setAlphaView:(UIView *)alphaView {
    objc_setAssociatedObject(self, &alview, alphaView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)alphaView {
    return objc_getAssociatedObject(self, &alview);
}

- (void)changeNavigationBarAlphaWith:(UIColor *)color {
    if (!self.alphaView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        
        [self insertSubview:self.alphaView atIndex:0];
    }
    self.alphaView.backgroundColor = color;
}

/* 设置导航条透明 和 不透明 */
-(void)ex_setNavigationBartrnaslate:(BOOL)trans
{
    [self setShadowImage:[UIImage new]];
    if (trans) {
        [self setBackgroundImage:[self createImageWithColor:[UIColor clearColor] imageRect:CGRectMake(0, 0, SCREEN_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
        //self.layer.masksToBounds = YES;
    }else
    {
        [self setBackgroundImage:[self createImageWithColor:[UIColor clearColor] imageRect:CGRectMake(0, 0, SCREEN_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
        //self.layer.masksToBounds = NO;
    }
}

/*  颜色转换为image */
- (UIImage *)createImageWithColor:(UIColor *)color imageRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
