//
//  LoginViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "LoginViewController.h"
#import "RegiestViewController.h"
#import "PasswordViewController.h"
#import "CodeLoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phone;/** 手机号 */

@property (weak, nonatomic) IBOutlet UITextField *codde;/** 验证码 */

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;/** 发送按钮 */

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;/** 验证码描述label */

@property (weak, nonatomic) IBOutlet UIButton *changeBtn;/** 切换按钮 */

@property (nonatomic, assign) NSInteger isCode;/** 是否是验证码登录 */

@property (nonatomic, assign) NSInteger isPhone;/** 是否是手机号 */

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCode = 0;
    self.isPhone = 0;
    self.passwordLabel.text = @"密码";
    self.codde.placeholder = @"请输入密码";
    self.sendBtn.hidden = YES;
    self.phone.delegate = self;
}
/** 校验手机号 */
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
/** 登录按钮 */
- (IBAction)login:(UIButton *)sender {
    if (self.isPhone == 1) {
        if (self.phone.text.length > 0 && self.codde.text.length > 0) {
            [LSNetworkService postLoginWithDic:@{@"userName":self.phone.text,@"password":self.codde.text} response:^(id dict, BSError *error) {
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
            [LPUnitily showToastWithText:@"账号或密码填写错误,请重新填写"];
        }
    }else{
        [LPUnitily showToastWithText:@"手机号输入有误,请重新输入"];
    }
    
}
/** 修改登录方式 */
- (IBAction)changeLoginType:(UIButton *)sender {
    CodeLoginViewController *codeLogin = [[CodeLoginViewController alloc] initWithNibName:@"CodeLoginViewController" bundle:nil];
    [self.navigationController pushViewController:codeLogin animated:YES];
}
/** 注册按钮 */
- (IBAction)regiest:(UIButton *)sender {
    RegiestViewController *regiest = [[RegiestViewController alloc] initWithNibName:@"RegiestViewController" bundle:nil];
    [self.navigationController pushViewController:regiest animated:YES];
}
/** 采集地图按钮 */
- (IBAction)map:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"map" object:self];
}
/** 忘记密码按钮 */
- (IBAction)forgetPassword:(UIButton *)sender {
    PasswordViewController *password = [[PasswordViewController alloc] initWithNibName:@"PasswordViewController" bundle:nil];
    [self.navigationController pushViewController:password animated:YES];
}

/** 获取验证码 */
- (IBAction)senderCode:(UIButton *)sender {
    
}






@end
