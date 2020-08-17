//
//  CustomPickView.m
//  renminjinfu
//
//  Created by 牛方路 on 2018/7/31.
//  Copyright © 2018年 牛方路. All rights reserved.
//

#import "CustomPickView.h"

@implementation CustomPickView

- (IBAction)chanelBtn:(UIButton *)sender
{
    [self.delegate chanel];
}

- (IBAction)sureBtn:(UIButton *)sender
{
    [self.delegate sure];
}

@end
