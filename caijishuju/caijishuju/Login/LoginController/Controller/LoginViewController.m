//
//  LoginViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UITextField *codde;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@property (weak, nonatomic) IBOutlet UIButton *changeBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordLabel.text = @"密码";
    self.codde.placeholder = @"请输入密码";
    self.sendBtn.hidden = YES;
}

- (IBAction)login:(UIButton *)sender {
    if (self.phone.text.length > 0 && self.codde.text.length > 0) {
        [LSNetworkService postLoginWithDic:@{@"userName":self.phone.text,@"password":self.codde.text} response:^(id dict, BSError *error) {
            if (dict != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"%@",dic);
                if ([dic[@"status"] integerValue] == 1) {
                    App_Utility.currentUser.token = dic[@"dataValue"][@"token"];
                    [App_Utility saveCurrentUser];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [LPUnitily showToastWithText:dic[@"message"]];
                }
            }
        }];
    }else{
        [LPUnitily showToastWithText:@"账号密码填写错误,请重新填写"];
    }
}
static int i = 0;
- (IBAction)changeLoginType:(UIButton *)sender {
    if (i == 0) {
        self.passwordLabel.text = @"验证码";
        self.codde.placeholder = @"请输入验证码";
        self.codde.text = @"";
        self.sendBtn.hidden = NO;
        [self.changeBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        i = 1;
    }else{
        self.passwordLabel.text = @"密码";
        self.codde.placeholder = @"请输入密码";
        self.codde.text = @"";
        self.sendBtn.hidden = YES;
        [self.changeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        i = 0;
    }
    
}

- (IBAction)regiest:(UIButton *)sender {
    
}

- (IBAction)map:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"map" object:self];
}

- (IBAction)forgetPassword:(UIButton *)sender {
    
}




@end
