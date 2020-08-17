//
//  BSTableViewController.m
//  PeopleYunXin
//
//  Created by 牛方路 on 2019/11/4.
//  Copyright © 2019 牛方路. All rights reserved.
//

#import "BSTableViewController.h"

@interface BSTableViewController ()

@end

@implementation BSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏文字大小及颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


@end
