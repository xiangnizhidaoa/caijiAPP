//
//  CodeLoginViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/9/14.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "CodeLoginViewController.h"
#import "RegiestViewController.h"
#import "PasswordViewController.h"

@interface CodeLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UITextField *code;

@property (nonatomic, assign) NSInteger isPhone;

@end

@implementation CodeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证码登录";
    self.phone.delegate = self;
    self.isPhone = 0;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *nicknameRegex = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    if ([passWordPredicate evaluateWithObject:textField.text]) {
        self.isPhone = 1;
    }else{
        self.isPhone = 0;
        [LPUnitily showToastWithText:@"手机号输入有误,请重新输入"];
    }
}

- (IBAction)sendCode:(UIButton *)sender {
    if (self.isPhone == 1) {
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
    }else{
        [LPUnitily showToastWithText:@"手机号输入有误,请重新输入"];
    }
}

- (IBAction)login:(UIButton *)sender {
    if (self.isPhone == 1) {
        if (self.phone.text.length > 0 && self.code.text.length > 0) {
            [LSNetworkService getCodeLoginWithDic:@{@"userName":self.phone.text,@"password":self.code.text} response:^(id dict, BSError *error) {
                if (dict != nil) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
                    NSLog(@"%@",dic);
                    if ([dic[@"status"] integerValue] == 1) {
                        App_Utility.currentUser.token = dic[@"dataValue"][@"token"];
                        App_Utility.currentUser.eMail = dic[@"dataValue"][@"eMail"];
                        App_Utility.currentUser.mobile = dic[@"dataValue"][@"mobile"];
                        App_Utility.currentUser.officeName = dic[@"dataValue"][@"officeName"];
                        App_Utility.currentUser.phone = dic[@"dataValue"][@"phone"];
                        App_Utility.currentUser.roleNames = dic[@"dataValue"][@"roleNames"];
                        App_Utility.currentUser.userName = dic[@"dataValue"][@"userName"];
                        App_Utility.currentUser.userid = dic[@"dataValue"][@"userid"];
                        [App_Utility saveCurrentUser];
                        [self dismissViewControllerAnimated:YES completion:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"userlogin" object:self];
                    }else{
                        [LPUnitily showToastWithText:dic[@"message"]];
                    }
                }
            }];
        }else{
            [LPUnitily showToastWithText:@"账号或验证码填写错误,请重新填写"];
        }
    }else{
        [LPUnitily showToastWithText:@"手机号输入有误,请重新输入"];
    }
}

- (IBAction)regiest:(UIButton *)sender {
    RegiestViewController *regiest = [[RegiestViewController alloc] initWithNibName:@"RegiestViewController" bundle:nil];
    [self.navigationController pushViewController:regiest animated:YES];
}

- (IBAction)map:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"map" object:self];
}

- (IBAction)password:(UIButton *)sender {
    PasswordViewController *password = [[PasswordViewController alloc] initWithNibName:@"PasswordViewController" bundle:nil];
    [self.navigationController pushViewController:password animated:YES];
}


@end
