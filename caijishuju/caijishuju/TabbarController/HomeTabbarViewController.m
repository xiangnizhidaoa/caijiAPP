//
//  HomeTabbarViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "HomeTabbarViewController.h"
#import "HomeViewController.h"
#import "CollectionViewController.h"
#import "TaskViewController.h"
#import "MyViewController.h"

@interface HomeTabbarViewController ()

/** 导航控制器 */
@property (nonatomic,strong)  BSNavigationController *HomeNav;

@property (nonatomic,strong)  BSNavigationController *ConvenientNav;

@property (nonatomic,strong)  BSNavigationController *FindNav;

@property (nonatomic,strong)  BSNavigationController *MyNav;
/** 试图控制器 */
@property (nonatomic,strong) HomeViewController *homeVC;

@property (nonatomic,strong) CollectionViewController *collectionVC;

@property (nonatomic,strong) TaskViewController *taskVC;

@property (nonatomic,strong) MyViewController *myVC;

@end

@implementation HomeTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 主页 */
    self.homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.HomeNav = [[BSNavigationController alloc] initWithRootViewController:self.homeVC];
    self.HomeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"主页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"主页选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:RGBCOLORV(0x2F3031) forKey:NSForegroundColorAttributeName];
    [self.HomeNav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    /** 采集地图 */
    self.collectionVC = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
    self.ConvenientNav = [[BSNavigationController alloc] initWithRootViewController:self.collectionVC];
    self.ConvenientNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"采集地图" image:[[UIImage imageNamed:@"地图"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"地图选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.ConvenientNav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    /** 任务地图 */
    self.taskVC = [[TaskViewController alloc] initWithNibName:@"TaskViewController" bundle:nil];
    self.FindNav = [[BSNavigationController alloc] initWithRootViewController:self.taskVC];
    self.FindNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"任务地图" image:[[UIImage imageNamed:@"地图"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"地图选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.FindNav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    /** 我的 */
    self.myVC = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil];
    self.MyNav = [[BSNavigationController alloc] initWithRootViewController:self.myVC];
    self.MyNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"我的"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"我的选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.MyNav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    
    self.tabBarController.viewControllers = @[self.HomeNav,self.ConvenientNav,self.FindNav,self.MyNav];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}


@end
