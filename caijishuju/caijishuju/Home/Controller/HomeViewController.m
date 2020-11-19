//
//  HomeViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "HomeViewController.h"
#import "MyTaskTableViewController.h"
#import "MyCollectionTableViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(map) name:@"map" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionMap) name:@"collectionMap" object:nil];
    self.tabBarController.selectedIndex = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userlogin) name:@"userlogin" object:nil];
}
/** 登录后通知执行的时间 */
-(void)userlogin{
    self.tabBarController.selectedIndex = 0;
}
/** 跳转采集地图 */
-(void)collectionMap{
    self.tabBarController.selectedIndex = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [LSNetworkService getIsLoginResponse:^(id dict, BSError *error) {
        if (dict != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"status"] integerValue] == 1) {
                
            }else{
                // 所有需要弹出登录的时候直接发送通知就好
                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
            }
        }
    }];
}
/** 跳转采集地图 */
-(void)map{
    self.tabBarController.selectedIndex = 1;
}

/** 跳转采集地图 */
- (IBAction)collection:(UIButton *)sender {
    self.tabBarController.selectedIndex = 1;
}

/** 跳转我的采集 */
- (IBAction)myCollection:(UIButton *)sender {
    MyCollectionTableViewController *myCollection = [[MyCollectionTableViewController alloc] initWithNibName:@"MyCollectionTableViewController" bundle:nil];
    [self.navigationController pushViewController:myCollection animated:YES];
}

/** 跳转任务地图 */
- (IBAction)task:(UIButton *)sender {
    self.tabBarController.selectedIndex = 2;
}

/** 跳转我的任务 */
- (IBAction)myTask:(UIButton *)sender {
    MyTaskTableViewController *myTask = [[MyTaskTableViewController alloc] initWithNibName:@"MyTaskTableViewController" bundle:nil];
    [self.navigationController pushViewController:myTask animated:YES];
}


@end
