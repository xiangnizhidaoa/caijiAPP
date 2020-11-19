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

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;/** 头像 */

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;/** 姓名 */

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(map) name:@"map" object:nil];
    
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
    self.nameLabel.text  = App_Utility.currentUser.userName.length > 0 ? App_Utility.currentUser.userName : @"";
    self.contentLabel.text = App_Utility.currentUser.roleNames.length > 0 ? App_Utility.currentUser.roleNames : @"";
}
/** 跳转采集地图页面 */
-(void)map{
    self.tabBarController.selectedIndex = 1;
}
/** 导出页面 */
- (IBAction)exportData:(UIButton *)sender {
    ExportViewController *export = [[ExportViewController alloc] initWithNibName:@"ExportViewController" bundle:nil];
    [self.navigationController pushViewController:export animated:YES];
}
/** 我的消息页面 */
- (IBAction)userMsg:(UIButton *)sender {
    MyMsgTableViewController *myMsg = [[MyMsgTableViewController alloc] initWithNibName:@"MyMsgTableViewController" bundle:nil];
    [self.navigationController pushViewController:myMsg animated:YES];
}
/** 关于我们页面 */
- (IBAction)about:(UIButton *)sender {
    AboutUsTableViewController *aboutUs = [[AboutUsTableViewController alloc] initWithNibName:@"AboutUsTableViewController" bundle:nil];
    [self.navigationController pushViewController:aboutUs animated:YES];
}

/** 退出登录 */
- (IBAction)logOut:(UIButton *)sender {
    [LSNetworkService getLogOutResponse:^(id dict, BSError *error) {
        if (dict != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"status"] integerValue] == 1) {
                [App_Utility clearCurrentUser];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
            }else{
                [LPUnitily showToastWithText:dic[@"message"]];
            }
        }
    }];
}



@end
