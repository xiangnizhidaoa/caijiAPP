//
//  BSNavigationController.m
//  PeopleYunXin
//
//  Created by 牛方路 on 2019/11/4.
//  Copyright © 2019 牛方路. All rights reserved.
//

#import "BSNavigationController.h"

@interface BSNavigationController ()

@end

@implementation BSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏颜色
//    [self.navigationBar setBarTintColor:RGBCOLORV(0xE9414B)];
    UIImage *navImg =[UIImage imageNamed:@"background"];
    navImg = [navImg resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationBar setBackgroundImage:navImg forBarMetrics:UIBarMetricsDefault];
    //设置导航栏透明度
    self.navigationBar.translucent = NO;
    self.navigationBar.hidden = YES;
}

//自定义右侧按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        self.tabBarController.tabBar.hidden = YES;
        self.navigationBar.hidden = NO;
        // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 44, 44);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    self.interactivePopGestureRecognizer.delegate = viewController;
    
    [super pushViewController:viewController animated:animated];
}

//右侧按钮事件
- (void)back{
    if (self.childViewControllers.count == 2) {
        self.tabBarController.tabBar.hidden = NO;
        self.navigationBar.hidden = NO;
    }
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
