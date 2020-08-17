//
//  BaseTabBar.m
//  Demo
//
//  Created by 牛方路 on 2020/1/14.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "BaseTabBar.h"

@interface BaseTabBar ()

@property (strong, nonatomic) UIButton *centerTabBarBtn;

@end



@implementation BaseTabBar

- (instancetype)init{
    if (self = [super init]){
        [self initView];
    }
    return self;
}

- (void)initView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -10, ScreenWidth, kBottomSafeSpace+49+20+40)];
    
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"标签栏"];
    
    // 设置不拉伸区域
    CGFloat top = 20;
    CGFloat left = 0;
    CGFloat bottom = 0;
    CGFloat right = 0;
    
    // 拉伸图片
    UIImage *bgImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bgImage];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = backView.frame;
    [backView addSubview:imageView];

    [self insertSubview:backView atIndex:0];
    
    // 去除顶部横线
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:[UIImage new]];

}

// layoutSubviews遍历子控件寻找UITabBarButton，给UITabBarButton重新设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = 50;
    self.centerTabBarBtn.frame = CGRectMake((ScreenWidth-width)/2, -5, width, width);
    
    CGFloat tabBarButtonW = ScreenWidth / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {

        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {

            // 重新设置frame
            CGRect frame = CGRectMake(tabBarButtonIndex * tabBarButtonW, 0, tabBarButtonW, 49);
            child.frame = frame;

            // 增加索引
            if (tabBarButtonIndex == 1) {
                tabBarButtonIndex++;
            }
            tabBarButtonIndex++;
        }
    }
}


////处理超出区域点击无效的问题
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if (self.hidden){
//        return [super hitTest:point withEvent:event];
//    }else {
//        //转换坐标
//        CGPoint tempPoint = [self.centerTabBarBtn convertPoint:point fromView:self];
//        //判断点击的点是否在按钮区域内
//        if (CGRectContainsPoint(self.centerTabBarBtn.bounds, tempPoint)){
//            //返回按钮
//            return self.centerTabBarBtn;
//        }else {
//            return [super hitTest:point withEvent:event];
//        }
//    }
//}


- (void)centerTabBarBtnEvent {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"add" object:self];
}


- (UIButton *)centerTabBarBtn {
    
    if (_centerTabBarBtn == nil) {
        _centerTabBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_centerTabBarBtn];
        [_centerTabBarBtn setImage:[UIImage imageNamed:@"标签栏-发帖按钮2"] forState:UIControlStateNormal];
        _centerTabBarBtn.adjustsImageWhenHighlighted = false;
        [_centerTabBarBtn addTarget:self action:@selector(centerTabBarBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _centerTabBarBtn;
}

@end
