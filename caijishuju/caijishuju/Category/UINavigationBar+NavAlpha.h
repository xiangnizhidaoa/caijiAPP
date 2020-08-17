//
//  UINavigationBar+NavAlpha.h
//  MFTour
//
//  Created by tilt on 16/7/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (NavAlpha)
// 改变透明度的view
@property (nonatomic, strong) UIView *alphaView;

// 根据颜色改变透明度
- (void)changeNavigationBarAlphaWith:(UIColor *)color;
-(void)ex_setNavigationBartrnaslate:(BOOL)trans;
@end
