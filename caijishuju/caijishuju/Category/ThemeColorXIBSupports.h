//
//  ThemeColorXIBSupports.h
//  DingDingClient
//
//  Created by phoenix on 15/10/23.
//  Copyright © 2015年 SEU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DDThemeColor)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end


@interface UITextField (DDThemeColor)

@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@end

