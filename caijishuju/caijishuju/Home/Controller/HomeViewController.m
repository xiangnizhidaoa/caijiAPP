//
//  HomeViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
// 所有需要弹出登录的时候直接发送通知就好
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
}


@end
