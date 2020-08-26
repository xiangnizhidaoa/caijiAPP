//
//  TimeTypeViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/26.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "TimeTypeViewController.h"

@interface TimeTypeViewController ()

@end

@implementation TimeTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)timeType:(UIButton *)sender {
    [self.delegate chooseTypeWithTag:sender.tag];
}

- (IBAction)cancle:(UIButton *)sender {
    [self.delegate cancle];
}

- (IBAction)sure:(UIButton *)sender {
    [self.delegate sure];
}


@end
