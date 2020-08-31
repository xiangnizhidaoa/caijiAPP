//
//  AppDelegate.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:@"login" object:nil];
    return YES;
}

-(void)login:(NSNotification *)notif{
//    登录页
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    BSNavigationController *navc = [[BSNavigationController alloc] initWithRootViewController:login];
    navc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.window.rootViewController presentViewController:navc animated:nil completion:nil];
    
    [AMapServices sharedServices].apiKey = @"17eba3596dc056770a725b19d93ef4e0";
    
}


@end
