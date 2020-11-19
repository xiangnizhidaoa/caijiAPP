//
//  RegiestViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/31.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "RegiestViewController.h"

@interface RegiestViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phone;/** 手机号 */


@end

@implementation RegiestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
}
/** 注册 */
- (IBAction)regiest:(UIButton *)sender {
    if (self.phone.text.length == 11) {
        [LSNetworkService postRegiestWithDic:@{@"lianxidh":self.phone.text} response:^(id dict, BSError *error) {
            if (dict != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"%@",dic);
                if ([dic[@"status"] integerValue] == 1) {
                    [LPUnitily showToastWithText:@"注册成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    [LPUnitily showToastWithText:dic[@"message"]];
                }
            }
        }];
    }else{
        [LPUnitily showToastWithText:@"请输入正确的手机号"];
    }
}


@end
