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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(map) name:@"map" object:nil];
// 所有需要弹出登录的时候直接发送通知就好
    if (!(App_Utility.currentUser.token.length > 0)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
    }
}

-(void)map{
    self.tabBarController.selectedIndex = 1;
}

//采集地图
- (IBAction)collection:(UIButton *)sender {
    self.tabBarController.selectedIndex = 1;
}

//我的采集
- (IBAction)myCollection:(UIButton *)sender {
    
}

//任务地图
- (IBAction)task:(UIButton *)sender {
    self.tabBarController.selectedIndex = 2;
}

//我的任务
- (IBAction)myTask:(UIButton *)sender {
    
}


@end
