//
//  CollectionViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "CollectionViewController.h"
#import "MyTaskDetailsController.h"
#import "TaskMapDataSubmitController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"采集地图";
}


- (IBAction)oneonebtaction:(UIButton *)sender {
    MyTaskDetailsController *mtdc = [MyTaskDetailsController new];
    [self.navigationController pushViewController:mtdc animated:YES];
    
    
}


- (IBAction)twotwobtaction:(UIButton *)sender {
    TaskMapDataSubmitController *tmdsc = [TaskMapDataSubmitController new];
    [self.navigationController pushViewController:tmdsc animated:YES];
    
}




@end
