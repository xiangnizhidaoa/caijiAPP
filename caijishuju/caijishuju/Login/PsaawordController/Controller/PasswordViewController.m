//
//  PasswordViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/31.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phone;/** 手机号 */

@property (weak, nonatomic) IBOutlet UITextField *password;/** 密码 */

@property (weak, nonatomic) IBOutlet UITextField *repassword;/** 重复密码 */

@property (weak, nonatomic) IBOutlet UITextField *code;/** 验证码 */

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
}
/** 发送验证码 */
- (IBAction)sendCode:(UIButton *)sender {
    if (self.phone.text.length > 0) {
        [LSNetworkService getPhoneCodeWithPhone:self.phone.text response:^(id dict, BSError *error) {
            if (dict != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"%@",dic);
                if ([dic[@"status"] integerValue] == 1) {
                    [LPUnitily showToastWithText:dic[@"message"]];
                    sender.enabled = NO;
                    // 开始倒计时
                    [UtilFunc countDown:60 complete:^{
                        sender.enabled = YES;
                        [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                    } progress:^(id time) {
                        [sender setTitle:[NSString stringWithFormat:@"%@秒后重发", time] forState:UIControlStateNormal];
                    }];
                }else{
                    [LPUnitily showToastWithText:dic[@"message"]];
                }
            }
        }];
    }else{
        [LPUnitily showToastWithText:@"请填写手机号后点击"];
    }
}

/** 找回密码 */
- (IBAction)findPassword:(UIButton *)sender {
    if ([self.password.text isEqualToString:self.repassword.text]) {
        [LSNetworkService getPasswordWithDic:@{@"phone":self.phone.text,@"plainPassword":self.password.text,@"yanzhengma":self.code.text} response:^(id dict, BSError *error) {
            if (dict != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"%@",dic);
                if ([dic[@"status"] integerValue] == 1) {
                    [LPUnitily showToastWithText:@"修改成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    [LPUnitily showToastWithText:dic[@"message"]];
                }
            }
        }];
    }else{
        [LPUnitily showToastWithText:@"两次密码输入不一致,请重新输入"];
    }
}

@end
