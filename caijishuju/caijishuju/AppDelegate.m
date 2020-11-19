//
//  AppDelegate.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "AppDelegate.h"
#import <QMapKit/QMapKit.h>
#import "HHRLaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [QMapServices sharedServices].APIKey = @"F7ABZ-EKRWW-MEGR4-RIYHI-GQHIH-7CFHU";
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:@"login" object:nil];
    
    
    return YES;
}

/**
 通知开启登录页
 */

-(void)login:(NSNotification *)notif{
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    BSNavigationController *navc = [[BSNavigationController alloc] initWithRootViewController:login];
    navc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.window.rootViewController presentViewController:navc animated:YES completion:nil];
    
 
    
}


@end
