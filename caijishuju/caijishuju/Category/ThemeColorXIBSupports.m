//
//  ThemeColorXIBSupports.m
//  DingDingClient
//
//  Created by phoenix on 15/10/23.
//  Copyright © 2015年 SEU. All rights reserved.
//

#import "ThemeColorXIBSupports.h"

@implementation UIView (DDThemeColor)

@dynamic cornerRadius, borderWidth, borderColor;

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius > 0)
    {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (borderWidth > 0)
    {
        self.layer.borderWidth = borderWidth;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

@end

@implementation UITextField (DDThemeColor)

@dynamic placeholderColor;

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

@end
