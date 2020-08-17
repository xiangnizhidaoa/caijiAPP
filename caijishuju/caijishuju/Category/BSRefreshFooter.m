//
//  BSRefreshFooter.m
//  LotterySelect
//
//  Created by phoenix on 15/10/26.
//  Copyright © 2015年 SEU. All rights reserved.
//

#import "BSRefreshFooter.h"

@implementation BSRefreshFooter

#pragma mark - 重写方法在这里做一些初始化配置（比如添加子控件

- (void)prepare
{
    [super prepare];
    
    // 设置字体
    self.stateLabel.font = GetFont(14);
    
    // 设置颜色
    self.stateLabel.textColor = ColorGray;
}

#pragma mark - 在这里设置子控件的位置和尺寸

- (void)placeSubviews
{
    [super placeSubviews];
}


@end
