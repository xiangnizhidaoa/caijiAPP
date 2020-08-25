//
//  MyViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyViewController.h"
#import "MyMsgTableViewController.h"
#import "ExportViewController.h"
#import "AboutUsTableViewController.h"

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
    self.nameLabel.text  = App_Utility.currentUser.userName.length > 0 ? App_Utility.currentUser.userName : @"";
    self.contentLabel.text = App_Utility.currentUser.roleNames.length > 0 ? App_Utility.currentUser.roleNames : @"";
}

-(void)map{
    self.tabBarController.selectedIndex = 1;
}

- (IBAction)exportData:(UIButton *)sender {
    ExportViewController *export = [[ExportViewController alloc] initWithNibName:@"ExportViewController" bundle:nil];
    [self.navigationController pushViewController:export animated:YES];
}

- (IBAction)userMsg:(UIButton *)sender {
    MyMsgTableViewController *myMsg = [[MyMsgTableViewController alloc] initWithNibName:@"MyMsgTableViewController" bundle:nil];
    [self.navigationController pushViewController:myMsg animated:YES];
}

- (IBAction)about:(UIButton *)sender {
    AboutUsTableViewController *aboutUs = [[AboutUsTableViewController alloc] initWithNibName:@"AboutUsTableViewController" bundle:nil];
    [self.navigationController pushViewController:aboutUs animated:YES];
}





@end
