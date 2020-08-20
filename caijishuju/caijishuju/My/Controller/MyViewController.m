//
//  MyViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(map) name:@"map" object:nil];
    if (!(App_Utility.currentUser.token.length > 0)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
    }
}

-(void)map{
    self.tabBarController.selectedIndex = 1;
}

- (IBAction)exportData:(UIButton *)sender {
    
}

- (IBAction)userMsg:(UIButton *)sender {
    
}

- (IBAction)about:(UIButton *)sender {
    
}





@end
